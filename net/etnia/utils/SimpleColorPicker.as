package net.etnia.utils {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import net.etnia.display.Box;
	import net.etnia.display.LineStyle;

	public class SimpleColorPicker extends Sprite {

		public static const ON_COLOR_PICK:String = "on  color pick";

		protected var _backHit:Sprite;
		protected var _colors:Array;
		protected var _widthComponent:Number = 14, _heightComponent:Number = 14;
		protected var _xIndent:Number = 8, _yIndent:Number = 8;
		protected var _arrange:String;
		protected var _sprites:Array;

		public function SimpleColorPicker($colors:Array, $arrange:String = "default") {
			super();
			_backHit = new Box(10, 10, 0, 0, null, 0);
			_backHit.x = - 5;
			_backHit.y = - 5;
			addChild(_backHit);
			_colors = $colors;
			_sprites = new Array();
			_arrange = $arrange;
			init();
		}

		public function destroy():void {
			for(var i:uint = 0; i < _colors.length; i++) {
				var color:Box = _sprites[i];
				color.removeEventListener(MouseEvent.CLICK, onColorClick);
			}
//			removeAllChilds();
//			removeAllEventListeners();
		}

		protected function init():void {
			for(var i:uint = 0; i < _colors.length; i++) {
				setColorComponent(i, _colors[i]);
			}
		}

		protected function setColorComponent($index:uint, $color:uint):void {
			var color:Box = new Box(_widthComponent, _heightComponent, 5, $color, new LineStyle(2, 0x66CCFF, .6), 1);
			if(_arrange == "default") {
				color.y = $index * (_heightComponent + _yIndent);
			} else {
				color.y = Math.floor($index / 2) * (_heightComponent + _yIndent);
				color.x = (_widthComponent + _xIndent) * ($index % 2);
			}
			color.name = $index.toString();
			color.useHandCursor = true;
			color.buttonMode = true;
			color.addEventListener(MouseEvent.CLICK, onColorClick);
			_sprites.push(color);
			addChild(color);
			_backHit.width = width;
			_backHit.height = height + 5;
		}

		protected function onColorClick($event:MouseEvent):void {
			dispatchEvent(new ColorPickerEvent(_colors[($event.target as Sprite).name], ON_COLOR_PICK)); 
		}

	}
}