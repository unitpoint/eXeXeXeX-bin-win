/******************************************************************************
* Copyright (C) 2014 Evgeniy Golovin (evgeniy.golovin@unitpoint.ru)
*
* Please feel free to contact me at anytime, 
* my email is evgeniy.golovin@unitpoint.ru, skype: egolovin
*
* eXeXeXeX is a 4X genre of strategy-based video game in which player 
* "eXplore, eXpand, eXploit, and eXterminate" the world
* 
* Latest source code
*	eXeXeXeX: https://github.com/unitpoint/eXeXeXeX
* 	OS2D engine: https://github.com/unitpoint/os2d
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

Logo = extends ColorRectSprite {
	__construct = function(){
		@parent = stage
		@size = stage.size
		@color = Color.BLACK
		
		var sound = null
		var startGame = function(){
			spriteRes.unload()
			sound.stop()
			@detach()
			Game4X(0)
		}
		
		if(!logoEnabled){
			startGame()
			return
		}
		
		@res = Resources()
		@res.loadXML("xmls/logo.xml", false)
		
		var spriteRes = @res.get("logo")
		spriteRes.load()
		
		@sprite = Sprite().attrs {
			resAnim = spriteRes,
			pivot = vec2(0.5, 0.5),
			pos = @size/2,
			opacity = 0,
			parent = this,
		}
		var scale = @size / @sprite.size
		// @sprite.scale = math.max(scale.x, scale.y)
		@sprite.scale = math.min(scale.x, scale.y) * 0.5
		
		@addTimeout(0.6, function(){
			@sprite.addTweenAction {
				duration = 2.5,
				opacity = 1,
			}
		})
		
		// playMusic("music-menu")
		if(GAME_SETTINGS.sound || GAME_SETTINGS.music){
			sound = mplayer.play { 
				sound = "logo",
				volume = 0.5,
				fadeIn = 0.5,
				fadeOut = 0.6,
			}
		}
		
		@addEventListener(TouchEvent.CLICK, startGame)
		
		@addTimeout(3.5, function(){
			@sprite.addTweenAction {
				duration = 2,
				opacity = 0,
				doneCallback = function(){
					@addTimeout(0.2, startGame)
				},
			}
		})
	}
}