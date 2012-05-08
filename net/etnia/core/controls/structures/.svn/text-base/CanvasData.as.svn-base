package net.etnia.core.controls.structures {

	import net.etnia.core.interfaces.IObject;

	public class CanvasData implements IObject {

		protected var _sourceX:Number, _sourceY:Number, _zoom:Number;

		public function set sourceX($value:Number):void {
			_sourceX = $value;
		}

		public function get sourceX():Number {
			return _sourceX;
		}

		public function set sourceY($value:Number):void {
			_sourceY = $value;
		}

		public function get sourceY():Number {
			return _sourceY;
		}

		public function set zoom($value:Number):void {
			_zoom = $value;
		}

		public function get zoom():Number {
			return _zoom;
		}

		public function CanvasData($sourceX:Number = 0, $sourceY:Number = 0, $zoom:Number = 0) {
			_sourceX = $sourceX;
			_sourceY = $sourceY;
			_zoom = $zoom;
		}

		public function get classType():String {
			return "net.etnia.core.controls.structures.CanvasData";
		}

		public function toObject():Object {
			var object:Object = new Object();
			object["sourceX"] = _sourceX;
			object["sourceY"] = _sourceY;
			object["zoom"] = _zoom;
			object["classType"] = classType;
			return object;
		}

	}
}