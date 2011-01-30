local gfx = love.graphics
local selected = 1

-- newGameState
newGameState = Gamestate.new()

-- menuGameState
menuGameState = Gamestate.new()

-- gameOverState
gameOverState = Gamestate.new()

-- highScoreState
highScoreState = Gamestate.new()

wereInActualGameNowLoLGlobalsBad = false

--menuGameState functions

function menuGameState:draw()
   gfx.setColor(224, 27, 99, 200)
   gfx.rectangle('fill', 50, 50, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)
   
   drawMenuItemStuff()
end

function menuGameState:keyreleased(key)
   if key == 'up' or key == 'k' or key == 'w' then
      if selected ~= 1 then
         selected = selected - 1
         drawMenuItemStuff()
      end
   elseif key == 'down' or key == 'j' or key == 's' then
      if selected ~= #menuText then
         selected = selected + 1
         drawMenuItemStuff()
      end
   elseif key == 'return' then
      if selected == 1 then
         newGame()
      end
      if selected == 2 then
         newGame()
      end
      if selected == 3 then
         Gamestate.switch(highScoreState)
      end
      if selected == 4 then
         love.event.push('q')
      end
   end
end

-- End of game state
function gameOverState:draw()
   gfx.setColor(224, 27, 99, 200)
   gfx.rectangle('fill', 50, 50, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)

   local gameOverString = string.format("Game Over!\nYour score was %f", score)
   love.graphics.setFont(seconds_font)
   gfx.setColor(5, 255, 5)
   love.graphics.print(gameOverString, SCREEN_HEIGHT/2 - gameOverString:len()*4, SCREEN_HEIGHT/2)
   wereInActualGameNowLoLGlobalsBad = false
end

-- Highscore menu
function highScoreState:draw()
   gfx.setColor(224, 27, 99, 200)
   gfx.rectangle('fill', 50, 50, SCREEN_WIDTH-100, SCREEN_HEIGHT-100)
   gfx.setColor(255, 255, 255)
   local line = ""
   gfx.setFont(ASSETS.largeFont)
   love.graphics.print("High Scores", 200, 100)

   gfx.setFont(ASSETS.smallFont)
   for i, score, name in highscore() do
      line = string.format("%2d. %6.2f  %s", i, score, name)
      love.graphics.print(line, 200, (i * 30) + 150)
   end
end

-- Helper functions
function drawMenuItemStuff()
   local offset = 0
   menuText = {'New Game', 'Settings', 'High Scores', 'Quit'}
   for i, text in pairs(menuText) do
      if i == selected then
         gfx.setColor(0, 255, 4)
      else
         gfx.setColor(133, 249, 255)
      end

      gfx.setFont(ASSETS.largeFont)
      gfx.print(text, 150, 120+offset, 0, 1, 1)
      offset = offset + 100
   end
end

function newGame()
   wereInActualGameNowLoLGlobalsBad = true
   load_time = love.timer.getTime()
   Gamestate.switch(newGameState)
end

return menuGameState, newGameState, gameOverState, highScoreState
