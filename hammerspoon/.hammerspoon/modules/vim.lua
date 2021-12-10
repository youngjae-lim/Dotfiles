local english = "com.apple.keylayout.US"

-- changeInput creates a <Ctrl + [> keybinding in a vin insert mode
-- When in Korean Input Mode, press <Crtl + [> to go into a normal mode with 
-- the input mode changed to English automatically.
-- In this way, you don't need to change the input mode manually
-- when you go to a command line mode to type something.
function changeInput()
  local current = hs.keycodes.currentSourceID()
  if not (current == english) then hs.keycodes.currentSourceID(english) end
  hs.eventtap.keyStroke({}, 'escape')
end

hs.hotkey.bind({'control'}, '[', changeInput)
