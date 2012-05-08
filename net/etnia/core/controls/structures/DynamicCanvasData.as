package net.etnia.core.controls.structures {

	import flash.geom.Rectangle;
	
	import net.etnia.core.interfaces.IObject;

	public class DynamicCanvasData extends DynamicImageData implements IDynamicSpriteData, IObject {

		protected var _color:uint;
		protected var _tokenID:String;
		protected var _maskID:String;
		protected var _canvasData:CanvasData;
		protected var _sliderPos:Number;

		public function set color($value:uint):void{ 
			_color = $value;
		}

		public function get color():uint {
			return _color;
		}

		public function set maskID($value:String):void{ 
			_maskID = $value;
		}

		public function get maskID():String {
			return _maskID;
		}

		public function set canvasData($value:CanvasData):void{ 
			_canvasData = $value;
		}

		public function get canvasData():CanvasData {
			return _canvasData;
		}
		public function set sliderPos($value:Number):void {
			_sliderPos = $value;
		}

		public function get sliderPos():Number {
			return _sliderPos;
		}

		public function DynamicCanvasData($ID:String = "", $bounds:Rectangle = null, $rotation:Number = 0, $z:Number = 0, $color:uint = 0,
											$maskID:String = "", $tokenURL:String = "", $canvasData:CanvasData = null, $sliderPos:Number = 0) {
			super($ID, $tokenURL, $bounds, $rotation, $z);
			_color = $color;
			_maskID = $maskID;
			_canvasData = $canvasData;
			_sliderPos = $sliderPos;
		}

		override public function get classType():String {
			return "net.etnia.core.controls.structures.DynamicCanvasData";
		}

		override public function toObject():Object {
			var object:Object = super.toObject();
			object["color"] = _color;
			object["maskID"] = _maskID;
			object["sliderPos"] = _sliderPos;
			object["canvasData"] = _canvasData;
			return object;
		}
		
	}
}