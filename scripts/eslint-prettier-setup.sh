#!/bin/bash

# ----------------------
# Color Variables
# ----------------------
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# Checks for existing eslintrc files
if [ -f ".eslintrc.js" -o -f ".eslintrc.yaml" -o -f ".eslintrc.yml" -o -f ".eslintrc.json" -o -f ".eslintrc" ]; then
  echo -e "${RED}Existing ESLint config file(s) found:${NC}"
  ls -a .eslint* | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
  echo
  read -p  "Create .eslintrc.js (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping ESLint config${NC}"
    skip_eslint_setup="true"
  fi
fi
finished=false

# Checks for existing prettierrc files
if [ -f ".prettierrc.js" -o -f "prettier.config.js" -o -f ".prettierrc.yaml" -o -f ".prettierrc.yml" -o -f ".prettierrc.json" -o -f ".prettierrc.toml" -o -f ".prettierrc" ]; then
  echo -e "${RED}Existing Prettier config file(s) found${NC}"
  ls -a | grep "prettier*" | xargs -n 1 basename
  echo
  echo -e "${RED}CAUTION:${NC} The configuration file will be resolved starting from the location of the file being formatted, and searching up the file tree until a config file is (or isn't) found. https://prettier.io/docs/en/configuration.html"
  echo
  read -p  "Create .prettierrc (Y/n)? "
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo -e "${YELLOW}>>>>> Skipping Prettier config${NC}"
    skip_prettier_setup="true"
  fi
  echo
fi

# ----------------------
# Perform Configuration
# ----------------------

echo
echo -e "${GREEN}Configuring development environment... ${NC}"

echo
echo -e "1/3 ${LCYAN}Installing eslint-config-prettier... ${NC}"
echo
npm install --save-dev eslint-config-prettier && npm install --save-dev eslint-config-airbnb && npm install --save-dev --save-exact prettier

if [ "$skip_eslint_setup" == "true" ]; then
  break
else
  echo
  echo -e "2/3 ${YELLOW}Building your .eslintrc.js file...${NC}"
  > ".eslintrc.js" # truncates existing file (or creates empty)

  echo "module.exports = { "'
      "env": {
        "browser": true,
        "es2021": true
    },
    "extends": [
        "eslint:recommended",
        "airbnb",
        "prettier"
    ],
    "overrides": [
    ],
    "parserOptions": {
        "ecmaVersion": "latest",
        "sourceType": "module"
    },
    "plugins": [
        "react"
    ],
    "rules": {
        "no-plusplus": ["error", { "allowForLoopAfterthoughts": true }],
        "lines-around-comment": [
            "error",
            {
                "beforeBlockComment": true,
                "afterBlockComment": true,
                "beforeLineComment": true,
                "afterLineComment": false,
                "allowBlockStart": true,
                "allowBlockEnd": true,
                "allowObjectStart": true,
                "allowObjectEnd": true,
                "allowArrayStart": true,
                "allowArrayEnd": true
            }
        ],
        "max-len": ["error", { "code": 80, "ignoreUrls": true }],
        "no-tabs": ["error", { "allowIndentationTabs": true }],
        "quotes": [
            "error",
            "double",
            { "avoidEscape": true, "allowTemplateLiterals": false }
        ]
    }
     }
}' >> .eslintrc.js
  > .eslintignore

  echo '
    build/
    coverage/
    node_modules/
    ' >> .eslintignore
fi

if [ "$skip_prettier_setup" == "true" ]; then
  break
else
  echo -e "3/3 ${YELLOW}Building .prettierrc.json file... ${NC}"
  > .prettierrc.json # truncates existing file (or creates empty)

  echo "{"'
    "printWidth": 80,
    "tabWidth": 4,
    "useTabs": true,
    "semi": true,
    "singleQuote": false,
    "quoteProps": "as-needed",
    "jsxSingleQuote": false,
    "trailingComma": "es5",
    "bracketSpacing": true,
    "bracketSameLine": false,
    "arrowParens": "always",
    "requirePragma": false,
    "insertPragma": false,
    "proseWrap": "preserve",
    "htmlWhitespaceSensitivity": "css",
    "embeddedLanguageFormatting": "auto",
    "singleAttributePerLine": false
}' >> .prettierrc.json
  > .prettierignore
  echo "# Ignore artifacts:"'
    build
    coverage
    node_modules
    ' >> .prettierignore
fi

echo
echo -e "Add this under script inside package.json"
echo
echo -e "\"lint\"": \""eslint ."\",""
echo -e "\"lint:fix\"": \""eslint . --fix"\""";
echo
echo -e "${GREEN}Finished setting up!${NC}"
echo