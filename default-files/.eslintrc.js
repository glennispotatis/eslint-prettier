module.exports = {
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
