require("starship"):setup()

require("smart-enter"):setup({
	open_multi = true,
})

require("recycle-bin"):setup()

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("yaziline"):setup()

-- Cache current year to avoid repeated os.date calls
local current_year = os.date("%Y")
local last_year_check = os.time()

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	else
		-- Refresh cached year once per minute
		local now = os.time()
		if now - last_year_check > 60 then
			current_year = os.date("%Y")
			last_year_check = now
		end

		if os.date("%Y", time) == current_year then
			time = os.date("%b %d %H:%M", time)
		else
			time = os.date("%b %d  %Y", time)
		end
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
