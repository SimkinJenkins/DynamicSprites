package net.etnia.core.controls {

	import flash.geom.Rectangle;
	
	import net.etnia.utils.ColorPickerEvent;
	import net.etnia.utils.SimpleColorPicker;

	public class DynamicSpriteColorControl extends DynamicSpriteControl {

		protected var _colorPicker:SimpleColorPicker;
		protected var _colorPickerArrange:String = "default";

		public function DynamicSpriteColorControl($bounds:Rectangle) {
			super($bounds);
		}

		override public function destroy():void {
			_colorPicker.destroy();
			super.destroy();
		}

		override protected function init():void {
			super.init();
			var colors:Array = new Array(0x000000, 0x2D2090, 0xFF9230, 0x840089, 0x27BFB6, 0xDD1B7C);
			_colorPicker = new SimpleColorPicker(colors, _colorPickerArrange);
			_colorPicker.addEventListener(SimpleColorPicker.ON_COLOR_PICK, onColorPick);
			_sizeCont.addChild(_colorPicker);
			_sizeCont.addChild(_closeButton);
			setColorPickerPosition(_colorPicker, _bounds);
		}

		protected function onColorPick($event:ColorPickerEvent):void {
			dispatchEvent(new ColorPickerEvent($event.color, $event.type));
		}

		protected function setColorPickerPosition($colorPicker:SimpleColorPicker, $bounds:Rectangle):void {
			$colorPicker.x = $bounds.width + 10;
			$colorPicker.y = Math.max(0, ($bounds.height / 2) - ($colorPicker.height / 2));
		}

		override protected function setGraphics($bounds:Rectangle):void {
			super.setGraphics($bounds);
			setColorPickerPosition(_colorPicker, $bounds);
		}

	}
}