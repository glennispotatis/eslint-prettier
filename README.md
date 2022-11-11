# eslint-prettier

## Usage

-   Automatic setup:
    `exec 3<&1;bash <&3 <(curl https://raw.githubusercontent.com/glennispotatis/eslint-prettier/main/scripts/eslint-prettier-setup.sh 2> /dev/null)`

-   Install eslint-config-prettier (`npm install --save-dev eslint-config-prettier`)
-   Create a eslintrc.\* file by running the command `npm init @eslint/config` and run the installation guide.
-   Add "prettier" at the end in the "extends" array in the `.eslintrc.*`file.
-   Create a `.eslintignore` and add necessary ignores (build, node_modules etc...)
-   Install prettier `npm install --save-dev --save-exact prettier`.
-   Then create an empty config file `echo {}> .prettierrc.json`
-   Create a `.prettierignore` and add the same necessary ignores (Should be based on the eslintignore)
-   Run prettier bu doing (`npx prettier --write`) and eslint (`npx eslint`).
