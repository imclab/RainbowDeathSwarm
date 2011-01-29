-- draw function for the terrain goes here

function drawTerrain()
   local gfx = love.graphics
   local colCount = 0
   local rowCount = 0

   for colCount = (1 + map["counter"]), (map.howLong + map["counter"]), 1 do
      for rowCount = 1, map.howHigh, 1 do
         drawUnit(map[colCount][rowCount])
      end
   end
end

function drawUnit(obj)
   local gfx = love.graphics

   if obj then
      local x1, y1, x2, y2, x3, y3, x4, y4 = obj.shape:getBoundingBox()
      local w = x3 - x2

      gfx.setColor(255, 255, 255)
      gfx.draw(ASSETS.tile, x2, y2, 0, 1, 1, w-w, w-w-w)
   end
end
