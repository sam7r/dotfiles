local M = {}

M.merge = function(base, overrides)
	local ret = base or {}
	local second = overrides or {}
	for _, v in pairs(second) do
		table.insert(ret, v)
	end
	return ret
end

M.filter = function(tbl, callback)
	local filt_table = {}

	for i, v in ipairs(tbl) do
		if callback(v, i) then
			table.insert(filt_table, v)
		end
	end
	return filt_table
end

return M
