package net.etnia.core.controls {

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import net.etnia.core.controls.structures.DynamicTextInputData;
	import net.etnia.core.controls.structures.IDynamicSpriteData;
	import net.etnia.core.interfaces.IObject;
	import net.etnia.utils.ColorPickerEvent;
	import net.etnia.utils.SimpleColorPicker;
	import net.interalia.Terrain.core.controls.DynamicSpriteRotateLimitControl;

	public class DynamicTextInput extends DynamicSprite implements IDynamicSprite, IObject {

		protected var _textStyle:TextFormat;
		protected var _actualTextStyle:TextFormat;
		protected var _textField:TextField;

		override public function set editable($value:Boolean):void {
			super.editable = $value;
			_textField.selectable = $value;
			if($value) {
				_textField.type = TextFieldType.INPUT;
			} else {
				_textField.type = TextFieldType.DYNAMIC;
			}
		}

		public function set text($text:String):void {
			_textField.text = $text;
			defualtTextStyle = _textStyle;
		}

		public function get textField():TextField {
			return _textField;
		}

		public function set defualtTextStyle($textStyle:TextFormat):void {
			_textStyle = $textStyle;
			textStyle = $textStyle;
		}

		public function set textStyle($textStyle:TextFormat):void {
			_actualTextStyle = $textStyle;
			textField.defaultTextFormat = $textStyle;
			textField.embedFonts = true;
			textField.text = textField.text;
			textField.antiAliasType = AntiAliasType.ADVANCED;
		}

		override public function get classType():String {
			return "net.etnia.core.controls.DynamicTextInput";
		}

		override protected function addSpriteControl():void {
			super.addSpriteControl();
			addChilds(true);
		}

		public function DynamicTextInput($bounds:Rectangle = null, $controlColor:uint=0xADD628) {
			super($bounds, $controlColor);
			defualtTextStyle = getDefaultTextFormat();
		}

		override public function getData():IDynamicSpriteData {
			return new DynamicTextInputData("", _textField.text, Number(_textStyle.color), _bounds, _contentRotateContainer.rotation);
		}

		override public function setData($value:IDynamicSpriteData):void {
			super.setData($value);
			var data:DynamicTextInputData = $value as DynamicTextInputData;
			text = data.text;
			setFontColor(data.color);
		}

		override public function destroy():void {
			_textField.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_textField.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			super.destroy();
		}

		override protected function setScale($bounds:Rectangle):void {
			if(textField) {
				textField.width = $bounds.width;
				textField.height = $bounds.height;
			}
		}

		override protected function init($bounds:Rectangle = null):void {
			setTextField();
			super.init($bounds);
		}

		protected function setTextField():void {
			_textField = getTextField();
			_textField.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_textField.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_textField.multiline = true;
			_textField.wordWrap = true;
//			_textField.border = true;
			_textField.text = "lalalla";
			_textField.type = TextFieldType.INPUT;
		}

		protected function getTextField():TextField {
			return new TextField();
		}

		override protected function onInitButtonClick($event:MouseEvent):void {
			super.onInitButtonClick($event);
			addChild(_textField);
		}

		override protected function addControlListeners($add:Boolean = true):void {
			super.addControlListeners($add);
			if($add) {
				_control.addEventListener(SimpleColorPicker.ON_COLOR_PICK, onColorPick);
			} else {
				_control.removeEventListener(SimpleColorPicker.ON_COLOR_PICK, onColorPick);
			}
		}

		override protected function getControl($bounds:Rectangle):DynamicSpriteControl {
			return new DynamicSpriteRotateLimitControl($bounds, false, _controlColor);
		}

		protected function onMouseOver($event:MouseEvent):void {
			_control.alpha = 1;
		}

		protected function onMouseOut($event:MouseEvent):void {
			_control.alpha = 0;
		}

		protected function onColorPick($event:ColorPickerEvent):void {
			setFontColor($event.color);
		}

		protected function setFontColor($color:uint):void {
			_textStyle.color = $color;
			defualtTextStyle = _textStyle;
		}

		protected function getDefaultTextFormat():TextFormat {
			return new TextFormat("Arial", 25, 0x000000);
		}
		
		

	}
}