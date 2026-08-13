return {
    terminal = "kitty",
    fileManager = "thunar",
    menu = "rofi -show run",
    browser = "brave",
    rofiWindows = "rofi -show window",
    rofiWebsearch = 'rofi -dmenu -p "Search> " | xargs -I{} brave https://www.google.com/search?q={}',
}
