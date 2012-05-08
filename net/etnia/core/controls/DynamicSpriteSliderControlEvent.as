package net.etnia.core.controls {

	import flash.events.Event;

	public class DynamicSpriteSliderControlEvent extends Event {

		protected var _value:Number;

		public function get value():Number {
			return _value;
		}

		public function DynamicSpriteSliderControlEvent($value:Number, $type:String, $bubbles:Boolean = false, $cancelable:Boolean = false) {
			super($type, $bubbles, $cancelable);
			_value = $value;
		}

	}
}