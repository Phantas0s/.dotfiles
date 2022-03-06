This is my notes while exploring the Lua possibilities in NEOVIM

* Everything required is cached; the cache needs to be emptied for every modif like so:

```
lua package.loaded['hypnos/status_line'] = nil
```
