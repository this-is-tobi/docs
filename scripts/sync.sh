#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'

# Variables
export GITHUB_USER=this-is-tobi
export GITHUB_REPOS=(
  cheatsheets
  docs
  dotfiles
  gitmojidex
  helm-charts
  homelab
  multiarch-mirror
  template-monorepo-ts
  tools
)
export GITHUB_BRANCH=main

# Utils functions
split_by_comma() {
  local IFS=,
  local WORD_LIST=($1)
  for word in "${WORD_LIST[@]}"; do
    echo "$word"
  done
}

# Add sources infos into readme file
add_sources () {
  [ "$(basename $2)" = "readme.md" ] && TITLE="## Sources" || TITLE="# Sources"
  printf "
$TITLE

Take a look at the [project sources]($1).

If you'd like to improve or fix the code, check out the [contribution guidelines](/contribute).
" >> $2
}


# Declare script helper
TEXT_HELPER="\nThis script aims to build documentation for a given Github user and a list of his repositories.
Following flags are available:

  -b    Branch used to clone documentation.

  -r    List of Github user repositories (comma separated repo name list).

  -u    Github user / organization.

  -h    Print script help.\n\n"

print_help() {
  printf "$TEXT_HELPER"
}

# Parse options
while getopts hb:r:u: flag; do
  case "${flag}" in
    b)
      GITHUB_BRANCH=${OPTARG};;
    r)
      GITHUB_REPOS=($(split_by_comma "${OPTARG}"));;
    u)
      GITHUB_USER=${OPTARG};;
    h | *)
      print_help
      exit 0;;
  esac
done


# Clean up before processing
printf "\n\n${red}[doc generator].${no_color} Prepare script\n"

# Prepare environment
rm -rf src/projects \
  && mkdir tmp src/projects \
  && touch tmp/sidebar.json && echo "[]" > tmp/sidebar.json \
  && cp src/index.md src/projects/index.md \
  && cp src/about.md src/projects/about.md \
  && cp src/contribute.md src/projects/contribute.md \
  && cp src/oss.md src/projects/oss.md

# Download utility script to clone subdir
wget -q "https://raw.githubusercontent.com/this-is-tobi/tools/main/shell/clone-subdir.sh" -O "tmp/clone-subdir.sh" \
  && chmod +x tmp/clone-subdir.sh

# Parse projects
for GITHUB_REPO in ${GITHUB_REPOS[@]}; do
  # Download project doc files (readme or docs folder)
  printf "\n\n${red}[doc generator].${no_color} Processing project '$GITHUB_REPO'\n"

  export GITHUB_REPO=$GITHUB_REPO
  DEDICATED_SOURCE_PAGE=false

  # Create tmp and src folders for processing project
  mkdir -p tmp/projects/$GITHUB_REPO src/projects/$GITHUB_REPO

  # Check if repository have a 'docs' folder and download it instead of readme if there is
  DOCS_FOLDER_STATUS="$(curl --write-out '%{http_code}' --silent --output /dev/null https://github.com/$GITHUB_USER/$GITHUB_REPO/tree/$GITHUB_BRANCH/docs)"
  if [ "$DOCS_FOLDER_STATUS" != '404' ]; then
    tmp/clone-subdir.sh \
      -b "main" \
      -d \
      -o "src/projects/$GITHUB_REPO" \
      -s "docs" \
      -u "https://github.com/$GITHUB_USER/$GITHUB_REPO"

    # Add sources page
    if [[ -n $(find src/projects/$GITHUB_REPO -name "*.md") ]]; then
      DEDICATED_SOURCE_PAGE=true
      add_sources "https://github.com/$GITHUB_USER/$GITHUB_REPO" "src/projects/$GITHUB_REPO/sources.md"
    fi
  fi

  README_FILE_STATUS="$(curl --write-out '%{http_code}' --silent --output /dev/null https://github.com/$GITHUB_USER/$GITHUB_REPO/tree/$GITHUB_BRANCH/docs/01-readme.md)"
  if [ "$README_FILE_STATUS" = '404' ]; then
    wget -q "https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$GITHUB_BRANCH/README.md" -O "tmp/projects/$GITHUB_REPO/readme.md"
    cat "tmp/projects/$GITHUB_REPO/readme.md" \
      | perl -pe 's{\[([^]]+)\]\((?!\.?/docs/|docs/|http)(\.?/)?([^/][^)]*)\)}{[$1](https://github.com/$ENV{GITHUB_USER}/$ENV{GITHUB_REPO}/tree/$ENV{GITHUB_BRANCH}/$3)}g' \
      | perl -pe 's{\[([^]]+)\]\((\.?/docs/)([^)]*)\)}{[$1]($3)}g' \
      > "src/projects/$GITHUB_REPO/readme.md"

    # Add sources page
    add_sources "https://github.com/$GITHUB_USER/$GITHUB_REPO" "src/projects/$GITHUB_REPO/readme.md"
  fi

  # Update links
  DESCRIPTION="$(curl -s https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO | jq -r '.description // empty')"
  FORMATED_REPO="$(echo $GITHUB_REPO | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1'| sed 's/-/\ /g')"

  # Add root page to project sidebar
  touch tmp/projects/$GITHUB_REPO/config.json && echo "[]" > tmp/projects/$GITHUB_REPO/config.json

  LINK=/readme
  jq \
    --arg r "$GITHUB_REPO" \
    --arg l "$LINK" \
    '. += [{ 
      text: "Introduction", 
      link: ("/" + $r + $l) 
    }]' tmp/projects/$GITHUB_REPO/config.json > src/projects/$GITHUB_REPO/config.json
  cp src/projects/$GITHUB_REPO/config.json tmp/projects/$GITHUB_REPO/config.json

  # Add pages to project sidebar
  for FILE in $(find src/projects/$GITHUB_REPO -type f -name "*.md" ! -name "readme.md" ! -name "sources.md" | sort --ignore-case); do
    UPDATED_FILE="$(dirname $FILE)/${FILE#*-}"
    cat $FILE | sed -E "s|\[([^]]+)\]\(\.\./([^)]+)\)|[\1](https://github.com/$GITHUB_USER/$GITHUB_REPO/tree/$GITHUB_BRANCH/\2)|g" > $UPDATED_FILE
    rm $FILE
    FILENAME="$(basename ${UPDATED_FILE%.*})"
    FORMATED_FILE="$(echo "$FILENAME" | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1' | tr '-' ' ')"
    if [ "$FILENAME" = "readme" ]; then
      continue
    fi
    jq \
      --arg f "$FORMATED_FILE" \
      --arg n "$FILENAME" \
      --arg r "$GITHUB_REPO" \
      '. += [{ 
        text: $f, 
        link: ("/" + $r + "/" + $n) 
      }]' tmp/projects/$GITHUB_REPO/config.json > src/projects/$GITHUB_REPO/config.json
    cp src/projects/$GITHUB_REPO/config.json tmp/projects/$GITHUB_REPO/config.json
  done

  # Add sources to project sidebar
  if [ "$DEDICATED_SOURCE_PAGE" = "true" ]; then
    jq \
      --arg r "$GITHUB_REPO" \
      '. += [{ 
        text: "Sources", 
        link: ("/" + $r + "/sources") 
      }]' tmp/projects/$GITHUB_REPO/config.json > src/projects/$GITHUB_REPO/config.json
    cp src/projects/$GITHUB_REPO/config.json tmp/projects/$GITHUB_REPO/config.json
  fi

  # Add project to home page
  yq -i \
    ".features += {
      \"title\": \"$FORMATED_REPO\", 
      \"details\": \"$DESCRIPTION\", 
      \"link\": \"/$GITHUB_REPO$LINK\"
    }" src/projects/index.md

  # Add project sidebar to global sidebar
  jq \
    --arg f "$(cat src/projects/$GITHUB_REPO/config.json)" \
    --arg r "$FORMATED_REPO" \
    '. += [{
      text: $r,
      collapsed: true,
      items: ($f | fromjson),
    }]' tmp/sidebar.json > src/projects/sidebar.json
  cp src/projects/sidebar.json tmp/sidebar.json
done


# Copy final sidebar file
printf "\n\n${red}[doc generator].${no_color} Copy final sidebar root config\n"

cp tmp/sidebar.json src/projects/sidebar.json


# Clean up
printf "\n\n${red}[doc generator].${no_color} Clean up after script run\n"

rm -rf tmp
