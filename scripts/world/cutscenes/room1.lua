return {
    wall = function(cutscene, event)
        -- Open textbox and wait for completion
        cutscene:text("* The wall seems cracked.")

        -- If we have Susie, play a cutscene
        local susie = cutscene:getCharacter("susie")
        if susie then
            -- Detach camera and followers (since characters will be moved)
            cutscene:detachCamera()
            cutscene:detachFollowers()

            -- All text from now is spoken by Susie
            cutscene:setSpeaker(susie)
			cutscene:showNametag("Susie")
            cutscene:text("* Hey,[wait:5] think I can break\nthis wall?", "smile")
			cutscene:hideNametag()

            -- Get the bottom-center of the broken wall
            local x = event.x + event.width/2
            local y = event.y + event.height/2

            -- Move Susie up to the wall over 0.75 seconds
            cutscene:walkTo(susie, x, y + 40, 0.75, "up")
            -- Move other party members behind Susie
            cutscene:walkTo(Game.world.player, x, y + 100, 0.75, "up")
            if cutscene:getCharacter("ralsei") then
                cutscene:walkTo("ralsei", x + 60, y + 100, 0.75, "up")
            end
            if cutscene:getCharacter("noelle") then
                cutscene:walkTo("noelle", x - 60, y + 100, 0.75, "up")
            end

            -- Wait 1.5 seconds
            cutscene:wait(1.5)

            -- Walk back,
            cutscene:wait(cutscene:walkTo(susie, x, y + 60, 0.5, "up", true))
            -- and run forward!
            cutscene:wait(cutscene:walkTo(susie, x, y + 20, 0.2))

            -- Slam!!
            Assets.playSound("impact")
            susie:shake(4)
            susie:setSprite("shock_up")

            -- Slide back a bit
            cutscene:slideTo(susie, x, y + 40, 0.1)
            cutscene:wait(1.5)

            -- owie
            susie:setAnimation({"away_scratch", 0.25, true})
            susie:shake(4)
            Assets.playSound("wing")

            cutscene:wait(1)
			cutscene:showNametag("Susie")
            cutscene:text("* Guess not.", "nervous")
			cutscene:hideNametag()

            -- Reset Susie's sprite
            susie:resetSprite()

            -- Reattach the camera
            cutscene:attachCamera()

            -- Align the follower positions behind Kris's current position
            cutscene:alignFollowers()
            -- And reattach them, making them return to their target positions
            cutscene:attachFollowers()
            Game:setFlag("wall_hit", true)
        end
    end,
	
	guardian = function(cutscene, event)
		cutscene:showNametag("Wall Guardian")
		cutscene:text("* I Am the Wall Guardian.[wait:5]\n* This Wall is Off Limits for you\nno-good wall slammers.")
		cutscene:hideNametag()
	end,
	
	star = function(cutscene, event)
		cutscene:showNametag("Starwalker?")
		cutscene:text("* This [color:yellow]sprite[color:reset] was [color:yellow]Pissing[color:reset] me\noff...")
		cutscene:text("* I was the original   [color:yellow]Starwalker[color:reset]")
		cutscene:hideNametag()
	end,

	chan = function(cutscene, event)
          local susie = cutscene:getCharacter("susie")
          local krischan = cutscene:getCharacter("krischan")
		cutscene:showNametag("Kris-Chan")
		cutscene:text("* Go! Sonichu! Go out and zap to the extreme!")
		cutscene:text("* Sonichu! Use EXPLOSION!!!")
		cutscene:hideNametag()
          krischan:explode()
          cutscene:wait(3)
		cutscene:showNametag("Susie")
          cutscene:setSpeaker(susie)
          cutscene:text("* What?", "shock")
		cutscene:hideNametag()
	end
}
