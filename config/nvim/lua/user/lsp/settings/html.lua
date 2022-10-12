return {
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      }
    },
    settings = {
        rootMarkers = {".git/", "package.json", "composer.json", "cargo.lock"},
    }
}
