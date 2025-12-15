# ~/.emacs.d

## Build

```bash
git clone git@github.com:higuoxing/.emacs.d.git
cd .emacs.d
git submodule update --init --recursive
make bootstrap -j$(nproc)
make build-treesit-languages
```
