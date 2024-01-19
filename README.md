# Arunoruto Website
This is the repo associated with my private website: [www.arnaut.me](www.arnaut.me).
I am using [hugo](https://gohugo.io/) as my static-site generator with the [blowfish](https://github.com/nunocoracao/blowfish) theme.
The site is hosted on [cloudflare pages](https://pages.cloudflare.com/), but feel free to choose your hosting provider (some examples are [here](https://blowfish.page/docs/hosting-deployment/)).

## Install and Update Theme
When first cloning the repo, fetch the theme using submodules using
```sh
git submodule update --init --recursive
```
and update the theme with
```sh
git submodule update --remote --merge
```