#!/usr/bin/env lua

function basic_text_objects()
    local chars = { '_', '.', ':', ',', ';', '|', '/', '\\', '*', '+', '%', '`', '?' }
    for idx,char in ipairs(chars) do
        for idx,mode in ipairs({ 'x', 'o' }) do
            nremap(mode, 'i'..char, string.format(':<C-u>silent! normal! f%sF%slvt%s<CR>', char, char, char))
            nremap(mode, 'a'..char, string.format(':<C-u>silent! normal! f%sF%svf%s<CR>', char, char, char))
        end
    end
end

return {
    basic_text_objects = basic_text_objects
}
