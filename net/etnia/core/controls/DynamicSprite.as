package net.etnia.core.controls {

	import com.display.SpriteContainer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.etnia.core.controls.structures.DynamicSpriteData;
	import net.etnia.core.controls.structures.IDynamicSpriteData;
	import net.etnia.core.interfaces.IObject;
	import net.etnia.graphics.EditorTextButton;

	public class DynamicSprite extends SpriteContainer implements IDynamicSprite, IObject {

		public static const ON_DYNAMIC_SPRITE_INIT:String = "on dynamic sprite init";

		protected var _lastBounds:Rectangle;
		protected var _bounds:Rectangle, _initial:Rectangle;
		protected var _control:DynamicSpriteControl;
		protected var _contentContainer:Sprite, _contentRotateContainer:Sprite, _sizeCont:Sprite;
		protected var _editable:Boolean = true;
		protected var _button:EditorTextButton;
		protected var _controlColor:uint;

		override public function set rotation($value:Number):void {
			_contentRotateContainer.rotation = $value;
			bounds = _bounds;
			_control.rotation = $value;
		}

		override public function get rotation():Number {
			return _contentRotateContainer.rotation;
		}

		public function get lastBounds():Rectangle {
			return _lastBounds;
		}

		public function set limits($value:Rectangle):void {
			_control.limits = $value;
		}

		public function get limits():Rectangle {
			return _control.limits;
		}

		public function get editable():Boolean{ 
			return _editable;
		}

		public function set editable($value:Boolean):void {
			_editable = $value;
			addChilds();
		}

		public function set data($data:IDynamicSpriteData):void {
			setData($data);
		}

		public function get data():IDynamicSpriteData {
			return getData();
		}

		public function set bounds($bounds:Rectangle):void {
			if($bounds == null) {
				return;
			}
			if(!_initial) {
				_initial = $bounds;
			}
			_lastBounds = _bounds;
			_bounds = $bounds;
			setScale($bounds);
			_contentContainer.x = $bounds.x + ($bounds.width / 2);
			_contentContainer.y = $bounds.y + ($bounds.height / 2);
			_sizeCont.x = - $bounds.width / 2;
			_sizeCont.y = - $bounds.height / 2;
			setInitButtonBounds($bounds);
			addSpriteControl();
		}

		public function get bounds():Rectangle {
			return _bounds;
		}

		public function get classType():String {
			return "net.etnia.core.controls.DynamicSprite";
		}

		public function get control():DynamicSpriteControl {
			return _control;
		}

		public function DynamicSprite($bounds:Rectangle = null, $controlColor:uint = 0xADD628) {
			_controlColor = $controlColor;
			$bounds = $bounds == null ? new Rectangle(0, 0, 1, 1) : $bounds;
			super();
			init($bounds);
		}

		override public function addChild($child:DisplayObject):DisplayObject {
			_sizeCont.addChild($child);
			return $child;
		}

		override public function removeChild($child:DisplayObject):DisplayObject {
			_sizeCont.removeChild($child);
			return $child;
		}
		
		public function hasChild($child:DisplayObject):Boolean {
			var has: Boolean = false;
			for(var index: uint = 0; index < _sizeCont.numChildren; index++)
				if(_sizeCont.getChildAt(index) == $child)
					return true;
			return has;
		}

		public function getData():IDynamicSpriteData {
			var data:DynamicSpriteData = new DynamicSpriteData("", _bounds, _contentRotateContainer.rotation); 
			return data;
		}

		public function setData($data:IDynamicSpriteData):void {
			setBounds($data.bounds);
			rotation = $data.rotation;
		}

		public function toObject():Object {
			var object:Object = new Object();
			object["classType"] = classType;
			object["data"] = getData();
			return object;
		}

		public function destroy():void {
			_control.destroy();
		}

		protected function init($bounds:Rectangle = null):void {
			_contentContainer = new Sprite();
			_contentRotateContainer = new Sprite();
			_sizeCont = new Sprite();
			super.addChild(_contentContainer);
			_contentContainer.addChild(_contentRotateContainer);
			_contentRotateContainer.addChild(_sizeCont);
			if($bounds) {
				bounds = $bounds;
			}
			onInitButtonClick(null);
		}

		protected function setBounds($bounds:Rectangle):void {
			bounds = $bounds;
			if(_control) {
				_control.bounds = $bounds;
			}
		}

		protected function setScale($bounds:Rectangle):void {
			_sizeCont.scaleX = $bounds.width / _initial.width;
			_sizeCont.scaleY = $bounds.height / _initial.height;
		}

		protected function addSpriteControl():void {
			if(_control) {
				_control.bounds = _bounds.clone();
				return;
			}
			_control = getControl(_bounds.clone());
			addControlListeners();
			addChilds();
		}

		protected function addControlToStage():void {
			if(!_control) {
				return;
			}
			if(_editable) {
				super.addChild(_control);
			} else if(_control.parent == this) {
				super.removeChild(_control);
			}
		}

		protected function addChilds($controlFirst:Boolean = false):void {
			if($controlFirst) {
				addControlToStage();
				super.addChild(_contentContainer);
			} else {
				super.addChild(_contentContainer);
				addControlToStage();
			}
		}

		protected function getControl($bounds:Rectangle):DynamicSpriteControl {
			return new DynamicSpriteControl($bounds, false, _controlColor);
		}

		protected function addControlListeners($add:Boolean = true):void {
			addListener(_control, DynamicSpriteControl.ON_MOVE_BORDER, onMoveControl, $add);
			addListener(_control, DynamicSpriteControl.ON_RESIZE_BORDER, onResizeControl, $add);
			addListener(_control, DynamicSpriteControl.ON_ROTATE_BORDER, onRotateControl, $add);
			addListener(_control, DynamicSpriteControl.ON_CLOSE_SPRITE, onCloseSprite, $add);
		}

		protected function onMoveControl($event:DynamicSpriteEvent):void {
			bounds = $event.bounds;
			dispatchEvent(new DynamicSpriteEvent($event.bounds, $event.rotation, $event.type));
		}

		protected function onResizeControl($event:DynamicSpriteEvent):void {
			bounds = $event.bounds;
		}

		protected function onRotateControl($event:DynamicSpriteEvent):void {
			rotation = $event.rotation;
		}

		protected function onCloseSprite($event:Event):void {
			addControlListeners(false);
			dispatchEvent(new Event(ON_DYNAMIC_SPRITE_INIT));
			dispatchEvent(new Event(DynamicSpriteControl.ON_CLOSE_SPRITE));
			destroy();
		}

		protected function addInitButton($text:String):void {
			_button = new EditorTextButton($text, _bounds);
			_button.addEventListener(MouseEvent.CLICK, onInitButtonClick);
			_button.addEventListener(MouseEvent.MOUSE_OVER, onInitButtonMouseOver);
			_button.addEventListener(MouseEvent.MOUSE_OUT, onInitButtonMouseOut);
			addChild(_button);
		}

		protected function onInitButtonMouseOver($event:MouseEvent):void {
			_control.alpha = 1;
		}

		protected function onInitButtonMouseOut($event:MouseEvent):void {
			_control.alpha = 0;
		}

		protected function setInitButtonBounds($bounds:Rectangle):void {
			if(_button) {
				_button.bounds = $bounds;
			}
		}

		protected function onInitButtonClick($event:MouseEvent):void {
			removeInitButton();
			dispatchEvent(new Event(ON_DYNAMIC_SPRITE_INIT));
		}

		protected function removeInitButton():void {
			if(_button && _button.parent == _sizeCont) {
				removeChild(_button);
			}
		}
	}
}