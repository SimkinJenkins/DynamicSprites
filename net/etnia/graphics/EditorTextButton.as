package net.etnia.graphics {

	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import net.etnia.engine3d.projection2d.BasicCanvas;

	public class EditorTextButton extends BasicCanvas {

		protected var _textField:TextField;
		protected var _buttonGraphic:Sprite;

		override public function set bounds($value:Rectangle):void {
			super.bounds = $value;
			setButtonGraphic();
			setTextFieldPosition();
		}

		public function EditorTextButton($text:String, $bounds:Rectangle = null) {
			super($bounds);
			init($text);
		}

		protected function init($text:String):void {
			setButtonText($text);
			setButtonGraphic();
			_buttonGraphic.buttonMode = true;
			_buttonGraphic.useHandCursor = true;
		}

		protected function setButtonGraphic():void {
			if(!_buttonGraphic) {
				_buttonGraphic = new Sprite();
			}
			_buttonGraphic.graphics.clear();
			_buttonGraphic.graphics.beginFill(0, 0);
			_buttonGraphic.graphics.drawRect(0, 0, _bounds.width, _bounds.height);
			_buttonGraphic.graphics.endFill();
			addChild(_buttonGraphic);
		}

		protected function setButtonText($text:String = ""):void {
//			_textField = Theme.getInstance().currentTheme.getSingleLineLabel($text, 18);
//			_textField.textColor = 0x5DBDE3;
			var shadow:DropShadowFilter = new DropShadowFilter(3, 90, 0x236AA8, 1, 8, 8, .95);
//			_textField.filters = [shadow];
			if(!_bounds) {
//				_bounds = new Rectangle(0, 0, _textField.textWidth, _textField.textHeight);
			}
			setTextFieldPosition();
//			addChild(_textField);
		}

		protected function setTextFieldPosition():void {
//			if(_textField) {
//				_textField.x = (_bounds.width / 2) - (_textField.textWidth / 2);
//				_textField.y = (_bounds.height / 2) - (_textField.textHeight / 2);
//			}
		}

	}
}