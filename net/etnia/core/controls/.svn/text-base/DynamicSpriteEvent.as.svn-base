package net.etnia.core.controls {

	import flash.events.Event;
	import flash.geom.Rectangle;

	public class DynamicSpriteEvent extends Event {

		protected var _bounds:Rectangle;
		protected var _rotation:Number;

		public function get bounds():Rectangle {
			return _bounds;
		}

		public function get rotation():Number {
			return _rotation;
		}

		public function DynamicSpriteEvent($bounds:Rectangle, $rotation:Number, $type:String, $bubbles:Boolean = false, $cancelable:Boolean = false) {
			super($type, $bubbles, $cancelable);
			_bounds = $bounds;
			_rotation = $rotation;
		}

	}
}