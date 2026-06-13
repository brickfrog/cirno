# Cirno for VS Code

An ice-fairy theme — midnight navy, starlight blue, ice-cyan, and one red ribbon.
Ships **Cirno** (dark) and **Cirno Day** (light).

## Install

**From a clone (recommended while it's unpublished):**

```sh
# symlink the extension into your VS Code extensions folder
ln -s "$PWD/themes/vscode" ~/.vscode/extensions/cirno-1.0.0
# then reload VS Code and pick it in:  Ctrl/Cmd+K Ctrl/Cmd+T
```

**Package a .vsix:**

```sh
cd themes/vscode
npx @vscode/vsce package
code --install-extension cirno-1.0.0.vsix
```

Then open the theme picker — `Ctrl/Cmd+K Ctrl/Cmd+T` — and choose **Cirno** or **Cirno Day**.

## Notes

- Semantic highlighting is on; the theme tunes both TextMate scopes and semantic tokens.
- Bracket-pair colorization cycles through the full Cirno accent set.
- An `icon.png` (128×128) is referenced by `package.json` if you want a marketplace
  icon — drop one in before publishing, or remove the `"icon"` key.
