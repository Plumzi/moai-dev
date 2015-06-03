----------------------------------------------------------------
-- Copyright (c) 2010-2011 Zipline Games, Inc. 
-- All Rights Reserved. 
-- http://getmoai.com
----------------------------------------------------------------

MOAISim.openWindow ( "test", 320, 480 )

viewport = MOAIViewport.new ()
viewport:setSize ( 320, 480 )
viewport:setScale ( 320, 480 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

gfxQuad2 = MOAIGfxQuad2D.new ()
gfxQuad2:setTexture ( "bad.png" )
-- gfxQuad2:setTexture ( "good.png" )
gfxQuad2:setRect ( -64, -8, 64, 8 )

prop2 = MOAIProp2D.new ()
prop2:setDeck ( gfxQuad2 )
prop2:setLoc(50,50)
layer:insertProp ( prop2 )

