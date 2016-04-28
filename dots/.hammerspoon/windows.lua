local window = require 'hs.window'

hs.window.animationDuration=0 -- Disable animations

function maximize_window()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
    -- redrawBorder()
end

hs.hotkey.bind({ 'cmd', 'shift' }, 'f', maximize_window)

