local function init()
    require 'Ow1Dev.vim'.init()
    require 'Ow1Dev.theme'.init()
    require 'Ow1Dev.languages'.init()
    require 'Ow1Dev.floaterm'.init()
    require 'Ow1Dev.telescope'.init()
end

return {
    init = init,
}
