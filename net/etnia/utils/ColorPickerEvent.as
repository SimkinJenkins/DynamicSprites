package net.etnia.utils {

	import flash.events.Event;

	public class ColorPickerEvent extends Event {

		protected var _color:uint;

		public function get color():uint {
			return _color;
		}

		public function ColorPickerEvent($color:uint, $type:String, $bubbles:Boolean = false, $cancelable:Boolean = false) {
			super($type, $bubbles, $cancelable);
			_color = $color;
		}
		
	}
}