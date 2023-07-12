Neovim Java Demo
================

## Quickstart
```
cd project
./gradlew build

cd ..
./start-nvim

# Ignore errors and run
:PlugInstall
:q

./start-nvim
# Wait some time (~ 1 minute) until Mason completes.
# To check progress try :Mason
```

## Details

* `gradlew` is like a dependency manager for Java. It will download the
  JDK 17 into your home's `~/.gradle` directory. You can delete this
  directory if you no longer want to use this project.
* `start-nvim` sets environment vars before starting nvim:
  - Neovim configuration is in `xdg/config/nvim` so we set `XDG_CONFIG_HOME`
    to `xdg/config`
  - Neovim data is in `xdg/data/nvim` so we set `XDG_CONFIG_DATA`
    to `xdg/data`
* If your `nvim` command is not in your search path, you need to modify
  `start-nvim`
