scene = {}
scene.__index = scene

function scene.new()
	return setmetatable({debug = {},objects = {}},scene)
end

function scene:scaleObjects()
	for layer,objects in pairs(self.objects) do
		for k,object in pairs(objects) do
			object:scale()
		end
	end
end

function scene:update(elapsed)
	if self.objects then
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
	
	if self.debug then
		for k,v in pairs(self.debug) do
			if v.event then
				v:event(elapsed)
			end
		end
	end
end

function scene:onKeyPress(key, uni)
	if self.objects then
		for dumb,t in pairs(self.objects) do
			for k,v	in pairs(t) do
				if v.keybind then
					v.keybind.onPress(v,key,nil, nil, uni)
				end
			end
		end
	end
	
	if self.debug then
		for k,v	in pairs(self.debug) do
			if v.keybind then
				v.keybind.onPress(v,key,nil, nil, uni)
			end
		end
	end
end

function scene:onKeyRelease(key)
	if self.objects then
		for dumb,t in pairs(self.objects) do 
			for k,v in pairs(t) do
				if v.keybind then
					v.keybind.onRelease(v,key)
				end
			end
		end
	end
end

function scene:onMousePress(key, x, y)
	if self.objects then
		for dumb,t in pairs(self.objects) do
			for k,v	in pairs(t) do
				if v.keybind then
					v.keybind.onPress(v,key, x, y)
				end
			end
		end
	end
	
	if self.debug then
		for k,v	in pairs(self.debug) do
			if v.keybind then
				v.keybind.onPress(v,key, x, y)
			end
		end
	end
end

function scene:onMouseRelease(key, x, y)
	if self.objects then
		for dumb,t in pairs(self.objects) do
			for k,v	in pairs(t) do
				if v.keybind then
					v.keybind.onRelease(v,key, x, y)
				end
			end
		end
	end
end

function scene:draw()
	if self.objects then
		for layer,objects in pairs(self.objects) do
			
			love.graphics.push()
			
			for k,v	in pairs(objects) do
				love.graphics.setColor(v.color.r,v.color.g,v.color.b,v.color.a)

				if v.pose then
					if v.pose.text then
						if v.font then
							love.graphics.setFont(v.font)
						else
							love.graphics.setFont(activeFont)
						end
						
						love.graphics.printf(v.pose.text,v.x+xLetter,v.y+yLetter,v.pose.limit * scale,v.pose.alignment)
					end

					if v.pose.image then
						if v.pose.quad then
							love.graphics.drawq(v.pose.image,v.pose.quad,v.x+xLetter,v.y+yLetter,v.pose.rotate or 0, v.pose.scale * scale)
						else
							love.graphics.draw(v.pose.image,v.x+xLetter,v.y+yLetter,v.pose.rotate or 0, v.pose.scale * scale)
						end
					end
					
					if cache.showHitbox then
						if v.pose.occupy then
							love.graphics.setColor(creamy255.r,creamy255.g,creamy255.b)
							drawHitbox(v.x,v.y,v.pose.occupy)
						end
					end
				end
			end
		
			love.graphics.pop()
		
		end
	end
	
	love.graphics.setFont(standardFont)
	
	if self.debug then
		for k,v in pairs(self.debug) do	
			if v.pose then
				love.graphics.setColor(v.color.r,v.color.g,v.color.b,v.color.a)
				if v.pose.text then
					love.graphics.printf(v.pose.text,v.x+xLetter,v.y+yLetter,v.pose.limit * scale,v.pose.alignment)
				end

				if v.pose.image then
					if v.pose.quad then
						love.graphics.drawq(v.pose.image,v.pose.quad,v.x+xLetter,v.y+yLetter,v.pose.rotate or 0, v.pose.scale * scale)
					else
						love.graphics.draw(v.pose.image,v.x+xLetter,v.y+yLetter,v.pose.rotate or 0, v.pose.scale * scale)
					end
				end
			end
		end
	end
end





function UpdateScene(elapsed)
	scenes.activeScene:update(elapsed)
end

function DrawScene()
	scenes.activeScene:draw()
end

function OnKeyPressScene(key, uni)
	scenes.activeScene:onKeyPress(key, uni)
end

function OnKeyReleaseScene(key)
	scenes.activeScene:onKeyRelease(key)
end

function OnMousePressScene(key, x, y)
	scenes.activeScene:onMousePress(key, x, y)
end

function OnMouseReleaseScene(key, x, y)
	scenes.activeScene:onMouseRelease(key, x, y)
end
