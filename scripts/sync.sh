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
  homelab
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

rm -rf src/projects
mkdir tmp && touch tmp/sidebar.json && echo "[]" > tmp/sidebar.json
mkdir src/projects && cp src/index.md src/projects/index.md
wget -q "https://raw.githubusercontent.com/this-is-tobi/tools/main/scripts/clone-subdir.sh" -O "tmp/clone-subdir.sh"
chmod +x tmp/clone-subdir.sh

# Parse projects
for REPO in ${REPOS[@]}; do
  # Create tmp and src folders
  mkdir -p tmp/projects/$REPO src/projects/$REPO


  # Download project doc files (readme or docs folder)
  printf "\n\n${red}${i}.${no_color} Download doc files for project '$REPO'\n"
  i=$(($i + 1))

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


  # Add sources section and update links
  printf "\n\n${red}${i}.${no_color} Add sources section for project '$REPO'\n"
  i=$(($i + 1))

  addSourcesPage "https://github.com/$USER/$REPO" "src/projects/$REPO/sources.md"
  DESCRIPTION="$(curl -s https://api.github.com/repos/$USER/$REPO | jq -r '.description // empty')"
  FORMATED_REPO="$(echo $REPO | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')"


  # Build project sidebar
  printf "\n\n${red}${i}.${no_color} Build sidebar config for project '$REPO'\n"
  i=$(($i + 1))

  touch tmp/projects/$REPO/config.json && echo "[]" > tmp/projects/$REPO/config.json
  if [ "$DOCS_FOLDER_STATUS" != '404' ]; then
    LINK=/introduction
  else
    LINK=/readme
  fi
  jq \
    --arg r "$REPO" \
    --arg l "$LINK" \
    '. += [{ 
      text: "Introduction", 
      link: ("/" + $r + $l) 
    }]' tmp/projects/$REPO/config.json > src/projects/$REPO/config.json
  cp src/projects/$REPO/config.json tmp/projects/$REPO/config.json

  for FILE in $(find src/projects/$REPO -type f -name "*.md" ! -name "readme.md" ! -name "sources.md" | sort --ignore-case); do
    FILENAME="$(basename ${FILE%.*})"
    FORMATED_FILE="$(echo "$FILENAME" | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')"
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

  jq \
    --arg r "$REPO" \
    '. += [{ 
      text: "Sources", 
      link: ("/" + $r + "/sources") 
    }]' tmp/projects/$REPO/config.json > src/projects/$REPO/config.json
  cp src/projects/$REPO/config.json tmp/projects/$REPO/config.json

  yq \
    -i \
    ".features += {
      \"title\": \"$FORMATED_REPO\", 
      \"details\": \"$DESCRIPTION\", 
      \"link\": \"/$REPO/readme\"
    }" src/projects/index.md

  jq \
    --arg f "$(cat src/projects/$REPO/config.json)" \
    --arg r "$REPO" \
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
