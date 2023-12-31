#!/bin/bash

# Colorize terminal
red='\e[0;31m'
no_color='\033[0m'

# Step increment
i=1

# Variables
USER=this-is-tobi
REPOS=(
  docs
  dotfiles
  gitmojidex
  homelab
  template-monorepo-ts
  tools
)
BRANCH=main


# Add sources infos into readme file
addSourcesPage () {
  printf "
# Sources

Take a look at the [project sources]($1).
" >> $2
}


# Clean up before processing
printf "\n\n${red}${i}.${no_color} Prepare script\n"
i=$(($i + 1))

# Prepare environment
rm -rf src/projects \
  && mkdir tmp src/projects \
  && touch tmp/sidebar.json && echo "[]" > tmp/sidebar.json \
  && cp src/index.md src/projects/index.md

# Download utility script to clone subdir
wget -q "https://raw.githubusercontent.com/this-is-tobi/tools/main/shell/clone-subdir.sh" -O "tmp/clone-subdir.sh" \
  && chmod +x tmp/clone-subdir.sh

# Parse projects
for REPO in ${REPOS[@]}; do
  # Download project doc files (readme or docs folder)
  printf "\n\n${red}${i}.${no_color} Processing project '$REPO'\n"
  i=$(($i + 1))

  # Create tmp and src folders for processing project
  mkdir -p tmp/projects/$REPO src/projects/$REPO

  # Check if repository have a 'docs' folder and download it instead of readme if there is
  DOCS_FOLDER_STATUS="$(curl --write-out '%{http_code}' --silent --output /dev/null https://github.com/$USER/$REPO/tree/$BRANCH/docs)"
  if [ "$DOCS_FOLDER_STATUS" != '404' ]; then
    tmp/clone-subdir.sh \
      -b "main" \
      -d \
      -o "src/projects/$REPO" \
      -s "docs" \
      -u "https://github.com/$USER/$REPO"
  else
    wget -q "https://raw.githubusercontent.com/$USER/$REPO/$BRANCH/README.md" -O "tmp/projects/$REPO/readme.md"
    cat "tmp/projects/$REPO/readme.md" \
      | sed -E "s|(\[.*\])\(\.\/(.*)\)(.*)|\1\(https://github.com/$USER/$REPO/tree/$BRANCH/\2\)\3|g" \
      > "src/projects/$REPO/readme.md"
  fi

  # Add sources page and update links
  addSourcesPage "https://github.com/$USER/$REPO" "src/projects/$REPO/sources.md"
  DESCRIPTION="$(curl -s https://api.github.com/repos/$USER/$REPO | jq -r '.description // empty')"
  FORMATED_REPO="$(echo $REPO | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1'| sed 's/-/\ /g')"

  # Add root page to project sidebar
  touch tmp/projects/$REPO/config.json && echo "[]" > tmp/projects/$REPO/config.json

  if [ "$DOCS_FOLDER_STATUS" != '404' ]; then
    LINK=/introduction
  else
    LINK=/readme
    jq \
      --arg r "$REPO" \
      --arg l "$LINK" \
      '. += [{ 
        text: "Introduction", 
        link: ("/" + $r + $l) 
      }]' tmp/projects/$REPO/config.json > src/projects/$REPO/config.json
    cp src/projects/$REPO/config.json tmp/projects/$REPO/config.json
  fi

  # Add pages to project sidebar
  for FILE in $(find src/projects/$REPO -type f -name "*.md" ! -name "readme.md" ! -name "sources.md" | sort --ignore-case); do
    UPDATED_FILE="$(dirname $FILE)/${FILE#*-}"
    cat $FILE | sed -E "s|(\[.*\])\(\.\.\/(.*)\)(.*)|\1\(https://github.com/$USER/$REPO/tree/$BRANCH/\2\)\3|g" > $UPDATED_FILE
    rm $FILE
    FILENAME="$(basename ${UPDATED_FILE%.*})"
    FORMATED_FILE="$(echo "$FILENAME" | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1' | tr '-' ' ')"
    jq \
      --arg f "$FORMATED_FILE" \
      --arg n "$FILENAME" \
      --arg r "$REPO" \
      '. += [{ 
        text: $f, 
        link: ("/" + $r + "/" + $n) 
      }]' tmp/projects/$REPO/config.json > src/projects/$REPO/config.json
    cp src/projects/$REPO/config.json tmp/projects/$REPO/config.json
  done

  # Add sources to project sidebar
  jq \
    --arg r "$REPO" \
    '. += [{ 
      text: "Sources", 
      link: ("/" + $r + "/sources") 
    }]' tmp/projects/$REPO/config.json > src/projects/$REPO/config.json
  cp src/projects/$REPO/config.json tmp/projects/$REPO/config.json

  # Add project to home page
  yq -i \
    ".features += {
      \"title\": \"$FORMATED_REPO\", 
      \"details\": \"$DESCRIPTION\", 
      \"link\": \"/$REPO$LINK\"
    }" src/projects/index.md

  # Add project sidebar to global sidebar
  jq \
    --arg f "$(cat src/projects/$REPO/config.json)" \
    --arg r "$FORMATED_REPO" \
    '. += [{
      text: $r,
      collapsed: true,
      items: ($f | fromjson),
    }]' tmp/sidebar.json > src/projects/sidebar.json
  cp src/projects/sidebar.json tmp/sidebar.json
done


# Copy final sidebar file
printf "\n\n${red}${i}.${no_color} Copy final sidebar root config\n"
i=$(($i + 1))

cp tmp/sidebar.json src/projects/sidebar.json


# Clean up
printf "\n\n${red}${i}.${no_color} Clean up after script run\n"
i=$(($i + 1))

rm -rf tmp
