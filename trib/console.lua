thread = love.thread.getThread()

while true do
	if not thread:peek("sample") then
		thread:set("checked",thread:get("sample"))
	end
end