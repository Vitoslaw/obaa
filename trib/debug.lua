function DebugControl(key)
	switch(cache.isConsole,{
		["/"] = function() if key == "d" then cache.isConsole = "d" end end,
		d = function() if key == "i" then cache.isConsole = "i" end end,
		i = function() if key == "s" then cache.isConsole = "s1" end end,
		s1 = function() if key == "t" then cache.isConsole = "t1" end end,
		t1 = function() if key == "h" then cache.isConsole = "h" end end,
		h = function() if key == "e" then cache.isConsole = "e1" end end,
		e1 = function() if key == "b" then cache.isConsole = "b" end end,
		b = function() if key == "e" then cache.isConsole = "e2" end end,
		e2 = function() if key == "s" then cache.isConsole = "s2" end end,
		s2 = function() if key == "t" then cache.isConsole = "t2" end end,
		t2 = function() if key == "p" then cache.isConsole = "p" end end,
		p = function() if key == "o" then cache.isConsole = "o" end end,
		o = function() if key == "n" then cache.isConsole = "n" end end,
		n = function() 
			if key == "y" then 
				cache.isConsole = "is" 
				
				cache.promptLog = {pointer = 1}
				
				activeScene.debug.dMsg = TextNew(0,180,"Console has been activated.","center",nil,effects.fadeOut(clock, clock + 1, clock + 2, clock + 3)) 
			end
		end,
		is = function() 
			if activeScene.debug.console or not cache.consoleOpen then
				switch(key,{
					f5 = function()
						cache.consoleOpen = not cache.consoleOpen 
					end,
					["return"] = function() 
						if cache.consoleOpen then 
							activeScene.debug.console.pose.text = "" 
					
							cache.promptLog[#cache.promptLog + 1] = cache.consoleCommand
							cache.promptLog.pointer = #cache.promptLog + 1
					
							local commandPos = cache.consoleCommand:find(" ") or cache.consoleCommand:len()+1
							local v1pos = cache.consoleCommand:find(" ",commandPos+1) or cache.consoleCommand:len()+1
							local v2pos = cache.consoleCommand:find(" ", v1pos+1) or cache.consoleCommand:len()+1
					
							local command = cache.consoleCommand:sub(1,commandPos - 1)
							local v1 = cache.consoleCommand:sub(commandPos + 1,v1pos - 1)
							local v2 = cache.consoleCommand:sub(v1pos + 1,v2pos - 1)
							local v3 = cache.consoleCommand:sub(v2pos + 1)
							
							switch(command,consoleCommands)(v1,v2,v3)
						end 
					end,
					up = function()
						if cache.consoleOpen then
							cache.promptLog.pointer = cache.promptLog.pointer - 1
					
							if cache.promptLog.pointer > 0 then
								activeScene.debug.console.pose.text = cache.promptLog[cache.promptLog.pointer]
							else
								cache.promptLog.pointer = 1
							end
						end
					end,
					down = function()
						if cache.consoleOpen then
							cache.promptLog.pointer = cache.promptLog.pointer + 1
				
							if cache.promptLog.pointer <= #cache.promptLog then
								activeScene.debug.console.pose.text = cache.promptLog[cache.promptLog.pointer]
							else
								activeScene.debug.console.pose.text = ""
								cache.promptLog.pointer = #cache.promptLog + 1
							end
						end
					end
				})()
			end
		end,
		default = function() if key == "/" then cache.isConsole = "/" end end
		})()
		
		if love.keyboard.isDown("lalt") then
			switch(key,{
				["f3"] = function() cache.stats = not cache.stats end,
				["f4"] = function() if cache.showFPS then cache.showFPS = false cache.showTime = true elseif cache.showTime then cache.showTime = false else cache.showFPS = true end end,
				["escape"] = function() if love.keyboard.isDown("lctrl") then events._quit() end end,
				["r"] = function() if love.keyboard.isDown("lctrl") then cache.debug = nil cache.debugPointer = nil cacheB = cache love.load() cache = cacheB end end
			})()
		end
end

function DebugScreen()
	love.graphics.setFont(standardFont)
	
	if cache.stats then
		if cache.debugPointer then
			if cache.debugPointer:checkTable() then
				if loadstring("cache.debug ="..tostring(cache.debugPointer)) then
					loadstring("cache.debug ="..tostring(cache.debugPointer))()
				end
			end
		end
	
		local shift = 0
	
		if cache.debug then
			if type(cache.debug) == "table" then
				for m,n in pairs(cache.debug) do
					love.graphics.print(tostring(m).." : "..tostring(n),xLetter,yLetter + shift)
					shift = shift + 20
				end
			else
				love.graphics.print(tostring(cache.debug),xLetter,yLetter)
			end
		end
	end
	
	if cache.showFPS then
		love.graphics.printf(love.timer.getFPS(),xLetter,yLetter,640*scale,"right")
	elseif cache.showTime then
		love.graphics.printf(clock,xLetter,yLetter,640*scale,"right")
	end
	
	
	if cache.consoleOpen then
		if activeScene.debug then
			if not activeScene.debug.console then
				activeScene.debug.console = TextBoxNew(0,0,true)
			end
			cache.consoleCommand = activeScene.debug.console.pose.text
		end
	else
		activeScene.debug.console = nil
	end
end


consoleCommands = {
	["/toscene"] = function(v1) 
		if scenes[v1] then
			events._toScene(v1) 
		else 
			activeScene.debug.dMsg = MessageBoxNew("Scene doesn't exists.")
		end
	end,
	
	["/getvalue"] = function(v1)
		cache.debugPointer = nil
		
		if v1 then
			if string.checkTable(v1) then
				loadstring("cache.debug ="..v1)()
				activeScene.debug.dMsg = MessageBoxNew("Value gotten.")
			else
				activeScene.debug.dMsg = MessageBoxNew("Not valid value.")
			end
		end
	end,
	
	["/setpointer"] = function(v1)
		if v1 then
			if v1:checkTable() then
				cache.debugPointer = v1
				activeScene.debug.dMsg = MessageBoxNew("Pointer set.")
			else
				activeScene.debug.dMsg = MessageBoxNew("Not valid value.")
			end
		end
	end,
	
	["/reload"] = function(v1)
		if love.filesystem.exists(v1) then
			love.filesystem.load(v1)()
			activeScene.debug.dMsg = MessageBoxNew(v1.." reloaded")
		else
			activeScene.debug.dMsg = MessageBoxNew("File doesn't exists.")
		end
	end,
	
	["/toggleHitbox"] = function()
		cache.showHitbox = not cache.showHitbox
	end,
	
	["/reloadgraphics"] = function() --wip
		love.filesystem.load("configuration.lua")()
		
		LoadResolution()
		TranslateScreen()
	end,
	
	["/execute"] = function(v1)
		if v1 then
			if loadstring(v1) then
				loadstring(v1)()
				activeScene.debug.dMsg = MessageBoxNew("Executed successfully")
			else
				activeScene.debug.dMsg = MessageBoxNew("Operation denied")
			end
		end
	end,
	
	["/setvalue"] = function(v1,v2)
		if v1:checkTable() then
			if v2 ~= "nil" then
				if v2:checkTable() then
					loadstring(v1.." = "..v2)()
					activeScene.debug.dMsg = MessageBoxNew(v1.." = "..v2)
				else
					activeScene.debug.dMsg = MessageBoxNew("Second value invalid")
				end
			else
				loadstring(v1.." = nil")()
				activeScene.debug.dMsg = MessageBoxNew(v1.." = nil")
			end
		else
			activeScene.debug.dMsg = MessageBoxNew("First value invalid")
		end
	end,
	
	default = function() activeScene.debug.dMsg = TextNew(0,180,"Not valid command.","center",nil,effects.fadeOut(clock, clock + 1, clock + 2, clock + 3)) end
}
