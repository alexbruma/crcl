
local composer = require( "composer" )
local scene = composer.newScene()

physics.start()
local gravity = 9
function gravityCount ()
	physics.setGravity(0,gravity)
	gravity=gravity+0.10
end 
	
local bg 
local hero
local score 
local scoreText
local gameOver
local enemy 
local coin

function scene:create( event )
local sceneGroup = self.view
local function heroCollision (event)
	if event.phase == "began" then
		if(event.target.type == "hero" and event.other.type == "enemy") then
			composer.gotoScene( "start", "fade", 0  )
		else
			scoreText.text=scoreText.text + 1
			display.remove(event.other)
			beep = audio.loadSound( "beep.wav" )
			audio.play( beep )
		end
	end
end
	
local function touched(event)
	if(event.phase=="began")then 
		transition.to(hero,{time=200,x=event.x})
	end
end
	
	
	bg = display.newImage( "bg.png" )
	bg.x = display.contentCenterX
	bg.y = 100
	sceneGroup:insert( bg )
	hero = display.newImage("circle.png")
	hero.y = 450
	hero.x= display.contentCenterX
	physics.addBody (hero , "static")
	hero.type= "hero"
	sceneGroup:insert (hero)
	
	score = display.newText ("score:",150,28,"Fitigraf.otf",20) 
	sceneGroup:insert (score)
	scoreText = display.newText (0,190,28,"Fitigraf.otf",20) 
	sceneGroup:insert (scoreText)
	
	gameOver = display.newText (" ",100,100,"Fitigraf.otf",40) 
    gameOver.x= display.contentCenterX 
	gameOver.y= display.contentCenterY
	sceneGroup:insert (gameOver)
	bg:addEventListener("touch", touched, -1)
	hero:addEventListener("collision",heroCollision)
	
	function enemyFall ()
		enemy=display.newImage("rectangle.png")
		physics.addBody(enemy,"dinamic")
		enemy.y = -100
		enemy.x = math.random (1,3)
		enemy.type="enemy"
		
		if enemy.x == 2 then 
			enemy.x = display.contentCenterX
		end 
		if enemy.x == 1 then 
			enemy.x = 60
		end
		if enemy.x == 3 then 
			enemy.x = ((display.contentCenterX*2))-40
		end
		sceneGroup:insert (enemy)
	end
	
		function coinFall ()
			coin=display.newImage("triangle.png")
			physics.addBody(coin,"dinamic")
			coin.y = -100
			coin.x = math.random (1,3)
			coin.type="coin"
			if coin.x == 2 then 
				coin.x = display.contentCenterX
			end 
			if coin.x == 1 then 
				coin.x = 60
			end
			if coin.x == 3 then 
				coin.x = ((display.contentCenterX*2))-40
			end
			sceneGroup:insert(coin)
	end
		
end

function scene:show( event )
local sceneGroup = self.view
local phase = event.phase

	if "will" == phase then
	physics.start()
	timer1=timer.performWithDelay (300, gravityCount, -1)
	timer2=timer.performWithDelay(800, enemyFall, -1)
	timer3=timer.performWithDelay(1200, coinFall, -1)
	elseif "did" == phase then 

		
end
end 

function scene:hide( event )
local sceneGroup = self.view
	local phase = event.phase
		if "will" == phase then
		timer.pause(timer1)
		timer.pause(timer2)
		timer.pause(timer3)
		elseif "did" == phase then 
			gameOver.text = " "
			scoreText.text = 0
			
		end
end
function scene:destroy( event )
local sceneGroup = self.view

composer.removeScene(game,true)
    
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
