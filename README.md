# eslint-prettier

This is a template for eslint and prettier setup. After installation, feel free to add your own rules. Currently, React and Typescript is not installed during this and has to be added manually.

## Usage

Choose either the "Automatic setup" or the "Manual setup". Keep in mind that currently the automatic setup is not supported on windows (Unless you use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install/?target=_blank)).

### Automatic setup

Currently only works for UNIX (Linux/Mac), working on a windows version. For now use manual installation!

```bash
bash <(curl https://raw.githubusercontent.com/glennispotatis/eslint-prettier/main/eslint-setup.sh)
```

### Manual Setup

- Install "eslint-config-prettier"

```bash
npm install --save-dev eslint-config-prettier
```

- Install "eslint-config-airbnb"

```bash
npm install --save-dev eslint-config-airbnb
```

- Install "prettier"

```bash
npm install --save-dev --save-exact prettier
```

- Copy the 4 files in the folder "default-files" and paste them in the root directory of your project.
- Run eslint `npx eslint [options] [file]` and prettier `npx prettier [options] [file]`.
