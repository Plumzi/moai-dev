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

gfxQuad1 = MOAIGfxQuad2D.new ()
gfxQuad1:setTexture ( "good.png" )
gfxQuad1:setRect ( -64, -8, 64, 8 )

prop1 = MOAIProp2D.new ()
prop1:setDeck ( gfxQuad1 )
prop1:setLoc ( 0, 32 )
layer:insertProp ( prop1 )

gfxQuad2 = MOAIGfxQuad2D.new ()
gfxQuad2:setTexture ( "bad.png" )
gfxQuad2:setRect ( -64, -8, 64, 8 )

prop2 = MOAIProp2D.new ()
prop2:setDeck ( gfxQuad2 )
prop2:setLoc ( 0, -32 )
layer:insertProp ( prop2 )
