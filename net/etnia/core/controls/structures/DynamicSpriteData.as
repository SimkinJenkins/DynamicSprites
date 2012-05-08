package net.etnia.core.controls.structures {
	import flash.geom.Rectangle;
	
	import net.etnia.core.interfaces.IObject;
	

	public class DynamicSpriteData implements IDynamicSpriteData, IObject {

		protected var _rotation:Number;
		protected var _z:Number = 0;
		protected var _bounds:Rectangle;
		protected var _ID:String;

		public function set x($value:Number):void {
			_bounds.x = $value;
		}

		public function get x():Number {
			return _bounds.x;
		}

		public function set y($value:Number):void {
			_bounds.y = $value;
		}

		public function get y():Number {
			return _bounds.y;
		}

		public function set width($value:Number):void {
			_bounds.width = $value;
		}

		public function get width():Number {
			return _bounds.width;
		}

		public function set height($value:Number):void {
			_bounds.height = $value;
		}

		public function get height():Number {
			return _bounds.height;
		}

		public function set bounds($value:Rectangle):void {
			_bounds = $value;
		}

		public function get bounds():Rectangle {
			return _bounds;
		}

		public function set rotation($value:Number):void {
			_rotation = $value;
		}

		public function get rotation():Number {
			return _rotation;
		}

		public function set z($value:Number):void {
			_z = $value;
		}

		public function get z():Number {
			return _z;
		}

		public function set ID($value:String):void {
			_ID = $value;
		}

		public function get ID():String {
			return _ID;
		}

		public function get classType():String {
			return "net.etnia.core.controls.structures.DynamicSpriteData";
		}

		public function DynamicSpriteData($ID:String = "", $bounds:Rectangle = null, $rotation:Number = 0, $z:Number = 0) {
			ID = $ID;
			bounds = ($bounds == null ? new Rectangle() : $bounds);
			rotation = $rotation;
			z = $z;
		}

		public function toObject():Object {
			var object:Object = new Object();
			object["ID"] = ID;
			object["x"] = x;
			object["y"] = y;
			object["width"] = width;
			object["height"] = height;
			object["rotation"] = rotation;
			object["z"] = z;
			object["classType"] = classType;
			return object;
		}

	}
}