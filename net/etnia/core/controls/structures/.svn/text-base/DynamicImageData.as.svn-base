package net.etnia.core.controls.structures {

	import flash.geom.Rectangle;
	
	import net.etnia.core.interfaces.IObject;

	public class DynamicImageData extends DynamicSpriteData implements IDynamicSpriteData, IObject {

		protected var _URL:String;

		public function get URL():String {
			return _URL;
		}

		public function set URL($value:String):void {
			_URL = $value;
		}

		public function DynamicImageData($ID:String = "", $URL:String = "", $bounds:Rectangle = null, $rotation:Number = 0, $z:Number = 0) {
			super($ID, $bounds, $rotation, $z);
			_URL = $URL;
		}

		override public function get classType():String {
			return "net.etnia.core.controls.structures.DynamicImageData";
		}

		override public function toObject():Object {
			var object:Object = super.toObject();
			object["URL"] = _URL;
			return object;
		}

	}
}