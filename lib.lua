-- https://github.com/magu5026/FasterStart/blob/master/lib.lua
function Contains(tab,elem)
	for _,v in pairs(tab) do
		if v == elem then
			return true
		elseif type(v) == "table" then
			if Contains(v,elem) then
				return true
			end
		end
	end
	return false
end