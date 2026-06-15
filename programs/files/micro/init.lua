-- https://github.com/zyedidia/micro/issues/3707
-- Thanks to https://github.com/dmaluka !

local buffer = import("micro/buffer")
local lastMulticursorLoc = buffer.Loc(-1, -1)

function mouseMultiCursorNoHorizontal(bp, e)
	local mx, my = e:Position()
	local loc = bp:LocFromVisual(buffer.Loc(mx, my))
	if loc == lastMulticursorLoc then
		return false
	end

	lastMulticursorLoc = loc
	return bp:MouseMultiCursor(e)
end
