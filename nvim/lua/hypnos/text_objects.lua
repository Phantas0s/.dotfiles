#!/usr/bin/env lua

function basic_text_objects()
    local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
    for idx,char in ipairs(chars) do
        for idx,mode in ipairs({ 'x', 'o' }) do
            nremap(mode, 'i'..char, string.format(':<C-u>normal! T%svt%s<CR>', char, char))
            nremap(mode, 'a'..char, string.format(':<C-u>normal! F%svf%s<CR>', char, char))
        end
    end
end

return {
    basic_text_objects = basic_text_objects
}
