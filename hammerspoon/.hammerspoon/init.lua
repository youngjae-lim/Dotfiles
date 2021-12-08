do
  local english = "com.apple.keylayout.US"

  function changeInput()
    local current = hs.keycodes.currentSourceID()
    if not (current == english) then hs.keycodes.currentSourceID(english) end
    hs.eventtap.keyStroke({}, 'escape')
  end

  hs.hotkey.bind({'control'}, '[', changeInput)

  hs.loadSpoon('CircleClock')
  hs.notify.show("Hammerspoon started!", "", "")
end
