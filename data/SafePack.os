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

SafePack = extends Actor {
	__construct = function(game, entItem){
		super()
		// @name = name || "ent-043"
		@game = game
		@entItem = entItem
		@cols = entItem.cols
		@rows = entItem.rows
		@pack = entItem.pack
		@touchEnabled = false
		@tutorial = null
		
		var borderSize, paddingSize = 10, 4
		
		@backpack = Backpack(@game).attrs {
			// pivot = vec2(0, 0),
			// x = @width + borderSize,
			parent = this,
		}
		
		var bg = Box9Sprite().attrs {
			resAnim = res.get("panel"),
			// priority = 1,
			color = (Color.fromInt(0x5a5977) * 2.3), // .clamp(),
			x = @backpack.x + @backpack.width + borderSize,
			parent = this
		}
		bg.setGuides(20, 20, 20, 20)
		
		@slots = []
		for(var x = 0; x < @cols; x++){
			for(var y = 0; y < @rows; y++){
				var slot = ItemSlot(@game, this, #@slots).attrs {
					x = borderSize + (SLOT_SIZE + paddingSize) * x,
					y = borderSize + (SLOT_SIZE + paddingSize) * (y + 1),
					parent = bg,
				}
				@slots[] = slot
			}
		}
		bg.width = slot.x + slot.width + borderSize
		bg.height = slot.y + slot.height + borderSize
		
		BoxShadow(bg)
		
		@title = PanelTitle(bg, _T("Safe"), bg.color) // Color(0.99, 0.99, 0.7))
		@title.x = bg.width - @title.width
		
		@width = bg.x + bg.width
		@height = math.max(bg.height, @backpack.height)
		
		var entIcon = Box9Sprite().attrs {
			resAnim = res.get(@entItem.name),
			x = borderSize + (SLOT_SIZE + paddingSize) * (@cols - 1),
			y = borderSize + (SLOT_SIZE + paddingSize) * 0,
			size = vec2(SLOT_SIZE, SLOT_SIZE),
			// scaleX = -1,
			parent = bg,
		}
		
		@updateItems()
	},
	
	updateItems = function(){
		@pack.updateActorItems(this)
	},
}