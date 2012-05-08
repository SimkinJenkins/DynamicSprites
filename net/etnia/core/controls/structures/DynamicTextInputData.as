package net.etnia.core.controls.structures {

	import flash.geom.Rectangle;
	
	import net.etnia.core.interfaces.IObject;

	public class DynamicTextInputData extends DynamicSpriteData implements IDynamicSpriteData, IObject {

		protected static const CODED_ENTER:String = "|n|";

		protected var _text:String;
		protected var _color:uint;

		public function set text($value:String):void {
			_text = replaceEnters($value);
		}

		public function get normalText():String {
			return _text;
		}

		public function get text():String {
			var myPattern:RegExp = /r|n|/;
			var text:String = _text;
			for(var i:uint = 0; i < text.length; i++) {
				if(text.charAt(i) == "|" && text.charAt(i + 1) == "n" && text.charAt(i + 2) == "|") {
					text = text.substring(0, i) + "\n" + text.substring(i + 3);
				}
			}
			return text;
		}

		public function set color($value:uint):void {
			_color = $value;
		}

		public function get color():uint {
			return _color;
		}

		override public function get classType():String {
			return "net.etnia.core.controls.structures.DynamicTextInputData";
		}

		public function DynamicTextInputData($ID:String = "", $text:String = "", $color:uint = 0, $bounds:Rectangle = null, $rotation:Number = 0, $z:Number = 0) {
			super($ID, $bounds, $rotation, $z);
			_text = $text;
			_color = $color;
		}

		override public function toObject():Object {
			var object:Object = super.toObject();
			object["text"] = text;
			object["color"] = _color;
			return object;
		}

		protected function replaceEnters($text:String):String {
			for(var i:uint = 0; i < $text.length; i++) {
				if($text.charCodeAt(i) == 13) {
					$text = $text.substring(0, i) + CODED_ENTER + $text.substring(i + 1);
				}
			}
			return $text;
		}

	}
}