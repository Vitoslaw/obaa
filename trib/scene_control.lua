scene = {}
scene.__index = scene

function scene.new(scale)
	return setmetatable({objects = {}, scale = scale},scene)
end


function scene:update(elapsed)
	for dumb, t in pairs(self.objects) do
		for k,v in pairs(t) do
			if v.AI then
				v:AI(elapsed)
			end

			if v.event then
				v:event(elapsed)
			end
		end
	end
end

function scene:onKeyPress(key)
	for dumb,t in pairs(self.objects) do
		for k,v	in pairs(t) do
			if v.keybind then
				v.keybind.onPress(self,key)
			end
		end
	end
end

function scene:onKeyRelease(key)
	for dumb,t in pairs(self.objects) do 
		for k,v in pairs(t) do
			if v.keybind then
				v.keybind.onRelease(self,key)
			end
		end
	end
end

function scene:onMousePress(key, x, y)
	for dumb,t in pairs(self.objects) do
		for k,v	in pairs(t) do
			if v.keybind then
				v.keybind.onPress(self,key, x, y)
			end
		end
	end
end

function scene:onMouseRelease(key, x, y)
	for dumb,t in pairs(self.objects) do
		for k,v	in pairs(t) do
			if v.keybind then
				v.keybind.onRelease(self,key, x, y)
			end
		end
	end
end

function scene:draw()
	for layer,objects in pairs(self.objects) do
		love.graphics.push()
		if self.scale[layer] then TranslateScreen() end 
		for k,v	in pairs(objects) do
			if v.color then
				love.graphics.setColor(v.color.r,v.color.g,v.color.b,v.color.a)
			else
				love.graphics.setColor(0xff,0xff,0xff,0xff)
			end

			if v.pose then
				if v.pose.text then
					love.graphics.print(v.pose.text,v.x,v.y)
				end

				if v.pose.image then
					love.graphics.draw(v.pose.image,v.x,v.y)
				end
			end
		end
		
		love.graphics.pop()
	end
end





function UpdateScene(elapsed)
	activeScene:update(elapsed)
end

function DrawScene()
	activeScene:draw()
end

function OnKeyPressScene(key)
	activeScene:onKeyPress(key)
end

function OnKeyReleaseScene(key)
	activeScene:onKeyRelease(key)
end

function OnMousePressScene(key, x, y)
	activeScene:onMousePress(key, x, y)
end

function OnMouseReleaseScene(key, x, y)
	activeScene:onMouseRelease(key, x, y)
end
