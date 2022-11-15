#!/bin/bash

# Colors
RED="\033[0;31m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LCYAN='\033[1;36m'
NC='\033[0m' # No Color

# Check if eslint config already exist and then ask the user if it should be overridden
if [[ -f ".eslintrc.js" || -f ".eslintrc.yaml" || -f ".eslintrc.json" || -f ".eslintrc" ]]
then
    echo -e "${RED}Existing ESLint config file(s) found:${NC}"
    ls -a .eslintrc.* | xargs -n 1 basename
    echo
    echo -e "${RED}CAUTION:${NC} there is loading priority when more than one config file is present: https://eslint.org/docs/user-guide/configuring#configuration-file-formats"
    echo
    read -p "Create .eslintrc.js? (y/n) "
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo -e "${YELLOW}>>>>> Skipping ESLint config${NC}"
        echo
        skip_eslint="true"
    fi
fi
finished=false

# Check if prettier config already exist and then ask the user if it should be overridden
if [[ -f ".prettierrc.js" || -f ".prettier.config.js" || -f ".prettierrc.yaml" || -f ".prettierrc.yml" || -f ".prettierrc.json" || -f ".prettierrc.toml" || -f ".prettierrc" ]]
then 
    echo -e "${RED}Existing Prettier config file(s) found${NC}"
    ls -a | grep .prettier.* | xargs -n 1 basename
    echo 
    echo -e "${RED}CAUTION:${NC} The configuration file will be resolved starting from the location of the file being formatted, and searching up the file tree until a config file is (or isn't) found. https://prettier.io/docs/en/configuration.html"
    echo
    read -p "Create .prettierrc.json? (y/n) "
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo -e "${YELLOW}>>>>> Skipping Prettier config${NC}"
        echo
        skip_prettier="true"
    fi
fi
echo

# Install npm packages and creating files
echo
echo -e "${GREEN}Configuring Development Environment...${NC}"

echo
echo -e "1/5 ${LCYAN}Installing eslint-config-prettier...${NC}"
echo
npm install --save-dev eslint-config-prettier

echo
echo -e "2/5 ${LCYAN}Installing eslint-config-airbnb...${NC}"
echo
npm install --save-dev eslint-config-airbnb

echo
echo -e "3/5 ${LCYAN}Installing prettier...${NC}"
echo
npm install --save-dev --save-exact prettier

# Setting up .eslint config and eslintignore
if [[ $skip_eslint != "true" ]]
then
    echo
    echo -e "4/5 ${YELLOW}Creating .eslintrc.js file...${NC}"
    > ".eslintrc.js"

    echo 'module.exports = {
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
}' >> .eslintrc.js

    > .eslintignore
    echo "build/" >> .eslintignore
    echo "coverage/" >> .eslintignore
    echo "node_modules/" >> .eslintignore
fi

# Setting up prettier config and prettierignore
if [[ $skip_prettier != "true" ]]
then
    echo -e "5/5 ${YELLOW}Creating .prettierrc.json file..."
    > .prettierrc.json
    echo '{
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
    echo "build" >> .prettierignore
    echo "coverage" >> .prettierignore
    echo "node_modules" >> .prettierignore
fi

echo
echo -e "${GREEN}Installation Complete! Use 'npx eslint' and 'npx prettier -c [File or directory to check]' to check files.${NC}"