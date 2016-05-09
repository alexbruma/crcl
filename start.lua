
local composer = require( "composer" )
local scene = composer.newScene()


local bg
local circle 
local text 
local start
local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "game","fade", 0  )
		return true
	end
end
function scene:create( event )
	local sceneGroup = self.view
	bg = display.newImage( "bg.png" )
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	bg.touch = onSceneTouch
	sceneGroup:insert( bg )
	
	circle = display.newImage( "circleX2.png" )
	circle.x = display.contentCenterX
	circle.y = display.contentCenterY+90
	sceneGroup:insert( circle )
	
	text = display.newText( "CiRC.Le", 100, 100,"Fitigraf.otf", 50 )
	text.x = display.contentWidth/2
	text.y = display.contentWidth -190
	sceneGroup:insert( text )
	
	song = audio.loadSound( "song.wav" )
	local options =
{
    channel = 1,
    loops = -1,
    fadein = 5000
}
			audio.play( song,options)
	
end

function scene:show( event )
	local phase = event.phase
	if "will" == phase then

	circle:addEventListener( "touch", bg )
	
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
	circle:removeEventListener( "touch", bg )
	composer.removeScene("game")
	end
	if"did" == phase then 
	
	end
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene