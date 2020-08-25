# Spoons

Collection of Hammespoon Spoons

## Usage

- Install [Hammerspoon](https://www.hammerspoon.org/)
- Download the spoon that you want to use
    - If you have Hammerspoon installed `.spoon` extension is recognized by hammerspoon, so you can double click and it will install it. (Installation is basically moving it to `~/.hammerspoon/Spoons`)
- Add the relevant configs and hotkey bindings as required for the spoons (See Below)
    - You can find the config file by clicking on the hammerspoon menu bar icon and clicking 'Open Config` 

## Current Spoons

### Screenpush

Pushes an Image that is currently on the clipboard to imgur      

#### Config Required

`IMGUR_CLIENT_ID` : One way to find this, if you don't want to create an account in Imgur is to go to imgur and upload a image, and in the network tab you'll find `client_id` as a query param in the upload requests

#### Quick Install

- After Adding the Spoon add, the following to your config file

```
hs.spoons.use('Screenpush', {
    config = {
        IMGUR_CLIENT_ID = '546c25a59c58ad7'
    },
    hotkeys = {Screenpush = {{"cmd", "shift"}, "/"}},
})
```