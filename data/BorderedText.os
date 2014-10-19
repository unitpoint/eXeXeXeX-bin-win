BorderedText = extends Actor {
	__construct = function(){
		super()
		@touchChildrenEnabled = false
		
		@border = []
		for(var x = -1; x < 2; x+=2){
			for(var y = -1; y < 2; y+=2){
				var text = TextField().attrs {
					pos = vec2(x, y),
					color = Color.BLACK,
					// visible = false,
					priority = 1,
					parent = this,
				}
				@border[] = text
			}
		}
		
		@textField = TextField().attrs {
			color = Color.WHITE,
			priority = 2,
			parent = this,
		}
	},
	
	_applyBorderValue = function(name, value){
		for(var _, text in @border){
			text[name] = value
		}
	},
	
	_applyValue = function(name, value){
		@textField[name] = value
		@_applyBorderValue(name, value)
	},
	
	__get@borderVisible = function(value){
		return @border[0].visible
	},
	__set@borderVisible = function(value){
		@_applyBorderValue("visible", value)
	},
	
	__get@borderColor = function(value){
		return @border[0].color
	},
	__set@borderColor = function(value){
		@_applyBorderValue("color", value)
	},
	
	__get@color = function(value){
		return super() // @border[0].color
	},
	__set@color = function(value){
		super(value)
		@textField.color = value
	},
	
	__get@style = function(){
		throw "style is deprecated"
	},
	__set@style = function(value){
		throw "style is deprecated"
	},

	__get@textPos = function(){
		return @textField.textPos
	},
	__get@textSize = function(){
		return @textField.textSize
	},
	
	__get@text = function(){
		return @textField.text
	},
	__set@text = function(value){
		@_applyValue("text", value)
	},
	
	__set@htmlText = function(value){
		@_applyValue("htmlText", value)
	},
	
	__get@fontSize2Scale = function(){
		return @textField.fontSize2Scale
	},
	__set@fontSize2Scale = function(value){
		@_applyValue("fontSize2Scale", value)
	},
	
	__get@vAlign = function(){
		return @textField.vAlign
	},
	__set@vAlign = function(value){
		@_applyValue("vAlign", value)
	},
	
	__get@hAlign = function(){
		return @textField.hAlign
	},
	__set@hAlign = function(value){
		@_applyValue("hAlign", value)
	},
	
	__get@multiline = function(){
		return @textField.multiline
	},
	__set@multiline = function(value){
		@_applyValue("multiline", value)
	},
	
	__get@breakLongWords = function(){
		return @textField.breakLongWords
	},
	__set@breakLongWords = function(value){
		@_applyValue("breakLongWords", value)
	},
	
	__get@linesOffset = function(){
		return @textField.linesOffset
	},
	__set@linesOffset = function(value){
		@_applyValue("linesOffset", value)
	},
	
	__get@resFont = function(){
		return @textField.resFont
	},
	__set@resFont = function(value){
		@_applyValue("resFont", value)
	},
}