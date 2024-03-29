package net.etnia.core.controls {

	import com.core.system.System;
	import com.display.SpriteContainer;
	
	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;
	import net.etnia.utils.GeomUtils;
	import net.etnia.utils.MathUtils;

	public class DynamicSpriteControl extends SpriteContainer {

		public static const ON_RESIZE_BORDER:String = "on resize border";
		public static const ON_MOVE_BORDER_START:String = "onMoveStart";
		public static const ON_MOVE_BORDER:String = "onMoveEnd";
		public static const ON_ROTATE_BORDER:String = "on rotate border";
		public static const ON_CLOSE_SPRITE:String = "on close sprite";

		protected var _bounds:Rectangle;
		protected var _autoHide:Boolean = false;
		protected var _lastPosition:ComplexPoint;
		protected var _mousePosition:Point;
		protected var _rotation:Number = 0, _tempRotation:Number, _deltaRotation:Number;
		protected var _borderSize:Number = 4;
		protected var _borderGraphic:Sprite, _resizeButton:Sprite, _rotationButton:Sprite;
		protected var _closeButton:SimpleButton;
		protected var _rotateCont:Sprite, _posCont:Sprite, _sizeCont:Sprite;
		protected var _resizeGraphic:SimpleButton, _rotateGraphic:SimpleButton;
		protected var _transparent:Boolean;
		protected var _isDragging:Boolean = false;

		protected var _resizing:Boolean = false;
		protected var _anchor:ComplexPoint;

		protected var _resizeEnabled:Boolean = true;
		protected var _rotateEnabled:Boolean = true;

		protected var _borderColor:uint = 0xADD628;

		protected var _limits:Rectangle;

		public function set limits($value:Rectangle):void {
			_limits = $value;
		}

		public function get limits():Rectangle {
			return _limits;
		}

		public function set borderColor($value:uint):void {
			_borderColor = $value;
		}

		public function set autoHide($value:Boolean):void {
			_autoHide = $value;
			alpha = $value ? 0 : alpha;
			addListener(this, MouseEvent.ROLL_OVER, onBorderMouseRollOver, $value);
			addListener(this, MouseEvent.ROLL_OUT, onBorderMouseRollOut, $value);
		}

		public function set resizeEnabled($value:Boolean):void {
			_resizeEnabled = $value;
			_resizeButton.visible = $value;
		}

		public function set rotateEnabled($value:Boolean):void {
			_rotateEnabled = $value;
			_rotationButton.visible = $value;
		}

		override public function set rotation($value:Number):void {
			_rotateCont.rotation = $value;
		}

		public function set bounds($bounds:Rectangle):void {
			_bounds = $bounds;
			refresh($bounds);
			setContainersPosition();
		}

		public function set transparent($value:Boolean):void {
			_transparent =  $value;
			setBorderGraphic(_borderGraphic, _bounds);
		}

		public function DynamicSpriteControl($bounds:Rectangle, $transparent:Boolean = false, $borderColor:uint = 0xADD628) {
			super();
			_transparent = $transparent;
			_bounds = $bounds;
			_borderColor = $borderColor;
			init();
		}

		public function destroy():void {
			if(_closeButton && _closeButton.hasEventListener(MouseEvent.CLICK)) {
				_closeButton.removeEventListener(MouseEvent.CLICK, onCloseClick);
			}
		}

		protected function init():void {
			setContainers();
			_borderGraphic = getBorder();
			_sizeCont.addChild(_borderGraphic);
			_resizeButton = getResizeButton();
			_sizeCont.addChild(_resizeButton);
			_rotationButton = getRotationButton();
			_sizeCont.addChild(_rotationButton);
			_closeButton = getCloseButton();
			setContainersPosition();
			addChild(_posCont);
			_posCont.addChild(_rotateCont);
			_rotateCont.addChild(_sizeCont);
		}

		protected function getCloseButton():SimpleButton {
			var closeButton:SimpleButton = new DreamEditorCloseButton();
			closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			setCloseButtonPosition(closeButton, _bounds);
			_sizeCont.addChild(closeButton);
			return closeButton;
		}

		protected function onCloseClick($event:MouseEvent):void {
			dispatchEvent(new Event(ON_CLOSE_SPRITE));
		}

		protected function setCloseButtonPosition($closeButton:SimpleButton, $bounds:Rectangle):void {
			$closeButton.x = $bounds.width + (_borderSize * 4);
			$closeButton.y = -_borderSize * 4;
		}

		protected function setContainers():void {
			_posCont = new Sprite();
			_rotateCont = new Sprite();
			_sizeCont = new Sprite();
		}

		public function setContainersPosition():void {
			if(!_resizing) {
				_sizeCont.x = -_bounds.width / 2;
				_posCont.x = _bounds.x + (_bounds.width / 2);
				_sizeCont.y = -_bounds.height / 2;
				_posCont.y = _bounds.y + (_bounds.height / 2);
			}
		}

		protected function onBorderMouseRollOver($event:MouseEvent):void {
			alpha = 1;
		}

		protected function onBorderMouseRollOut($event:MouseEvent):void {
			alpha = 0;
		}

		protected function onBorderMouseDown($event:MouseEvent):void {
			trace("onBorderMouseDown");
			var border:InteractiveObject = $event.target as InteractiveObject;
			addListener(border, MouseEvent.MOUSE_DOWN, onBorderMouseDown, false);
			addListener(System.stageRoot, MouseEvent.MOUSE_UP, onBorderMouseUp, true, true);
			if(_isDragging) {
				return;
			}
			_isDragging = true;
			if(_limits) {
				var tempLimits:Rectangle = new Rectangle(_limits.x + (_bounds.width / 2), _limits.y + (_bounds.height / 2),
																_limits.width - _bounds.width, _limits.height - _bounds.height);
			}
			_posCont.startDrag(false, tempLimits);
			_lastPosition = new ComplexPoint(this.parent.mouseX, this.parent.mouseY);

			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onBorderMouseUp, true, true);

			dispatchEvent(new DynamicSpriteEvent(_bounds, _rotation, ON_MOVE_BORDER_START));
		}

		protected function onBorderMouseUp($event:MouseEvent):void {
			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onBorderMouseUp, false);

			addListener(_borderGraphic, MouseEvent.MOUSE_DOWN, onBorderMouseDown);
			if(_lastPosition == null) {
				return;
			}
			_posCont.stopDrag();
			var currentPos:Point = getCurrentPosition();
			_bounds.x = currentPos.x;
			_bounds.y = currentPos.y;
			_isDragging = false;
			dispatchEvent(new DynamicSpriteEvent(_bounds, _rotation, ON_MOVE_BORDER));
		}

		protected function getCurrentPosition():Point {
			var actualPos:ComplexPoint = new ComplexPoint(this.parent.mouseX, this.parent.mouseY);
			var newPos:ComplexPoint = _lastPosition.minus(actualPos);
			return new Point(_bounds.x - newPos.x, _bounds.y - newPos.y);
		}

		protected function onResizeBtnMouseDown($event:MouseEvent):void {
			_resizeButton.addEventListener(Event.ENTER_FRAME, onResizeBorder);
			addBorderListeners(_borderGraphic, false);
			_anchor = getAnchorPoint(_bounds);
			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onResizeBtnMouseUp, true, true);
			_resizing = true;
		}

		protected function getAnchorPoint($bounds:Rectangle):ComplexPoint {
			var h:Number = GeomUtils.getHypotenuse($bounds.width / 2, $bounds.height / 2);
			var anclaAngle:Number = MathUtils.radiansToDegrees(Math.atan2($bounds.height / 2, $bounds.width / 2)) + _rotateCont.rotation + 180;
			return GeomUtils.getPolarCoordinate(new ComplexPoint($bounds.x + ($bounds.width / 2), $bounds.y + ($bounds.height / 2)), h, anclaAngle, false);
		}

		protected function onResizeBtnMouseUp($event:Event):void {
			addBorderListeners(_borderGraphic);
			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onResizeBtnMouseUp, false);
			_resizeButton.removeEventListener(Event.ENTER_FRAME, onResizeBorder);
//			addEventListener(MouseEvent.ROLL_OUT, onBorderMouseRollOut);
			_resizing = false;
			updateResizeValues();
////////////////////
			var newAnchor:ComplexPoint = getAnchorPoint(_bounds);
			_bounds.x += _anchor.x - newAnchor.x;
			_bounds.y += _anchor.y - newAnchor.y;
			bounds = _bounds;
////////////////////
			dispatchEvent(new DynamicSpriteEvent(_bounds, _rotation, ON_RESIZE_BORDER));
		}

		protected function onResizeBorder($event:Event):void {
			updateResizeValues();
		}

		protected function updateResizeValues($deltaX:Number = 0, $deltaY:Number = 0):void {
			var actualWidth:Number = Math.min(Math.max(20, _sizeCont.mouseX - (_borderSize / 2)), 760);
			var actualHeight:Number = Math.min(Math.max(20, _sizeCont.mouseY - (_borderSize / 2)), 1035);
			bounds = new Rectangle(_bounds.x - $deltaX, _bounds.y - $deltaY, actualWidth, actualHeight);
		}

		protected function refresh($bounds:Rectangle):void {
			clearGraphic();
			setGraphics($bounds);
		}

		protected function setGraphics($bounds:Rectangle):void {
			setBorderGraphic(_borderGraphic, $bounds);
			setResizeButtonGraphic(_resizeButton, $bounds);
			setRotateButtonGraphic(_rotationButton, $bounds);
			setCloseButtonPosition(_closeButton, $bounds);
		}

		protected function clearGraphic():void {
			_borderGraphic.graphics.clear();
			_resizeButton.graphics.clear();
			_rotationButton.graphics.clear();
		}

		protected function getMouseAngle():Number {
			return - new ComplexPoint(0, 0).getAngle(new ComplexPoint(_posCont.mouseX, _posCont.mouseY));
		}

		protected function onRotateBtnMouseDown($event:MouseEvent):void {
			_rotationButton.addEventListener(Event.ENTER_FRAME, onRotateBorder);
			_tempRotation = getMouseAngle();
			_deltaRotation = _rotateCont.rotation;
			addBorderListeners(_borderGraphic, false);
			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onRotateBtnMouseUp, true, true);
		}

		protected function onRotateBtnMouseUp($event:Event):void {
			addBorderListeners(_borderGraphic);
			addListener(System.stageRoot.root, MouseEvent.MOUSE_UP, onRotateBtnMouseUp, false);
			_rotationButton.removeEventListener(Event.ENTER_FRAME, onRotateBorder);
			rotation = getCurrentRotation();
			bounds = _bounds;
			dispatchEvent(new DynamicSpriteEvent(_bounds, _rotateCont.rotation, ON_ROTATE_BORDER));
		}

		protected function getCurrentRotation():Number {
			return _deltaRotation + (_tempRotation - getMouseAngle());
		}

		protected function onRotateBorder($event:Event):void {
			_rotateCont.rotation = getCurrentRotation();
		}

		protected function getBorder():Sprite {
			var border:Sprite = new Sprite();
			setBorderGraphic(border, _bounds);
			border.useHandCursor = true;
			border.buttonMode = true;
			addBorderListeners(border);
			return border;
		}

		protected function addBorderListeners($border:Sprite, $add:Boolean = true):void {
			addListener($border, MouseEvent.MOUSE_DOWN, onBorderMouseDown, $add);
		}

		protected function setBorderGraphic($sprite:Sprite, $bounds:Rectangle):void {
			$sprite.graphics.clear();
			$sprite.graphics.lineStyle(_borderSize, _borderColor);
			$sprite.filters = [new BlurFilter(2, 2)];
//			var blur:BlurFilter = new BlurFilter(_borderSize / 2, _borderSize / 2);
//			$sprite.filters = [blur];
			if(!_transparent) {
				$sprite.graphics.beginFill(0x000000, 0);
			}
			$sprite.graphics.drawRect(-_borderSize, -_borderSize, $bounds.width + (_borderSize * 2), $bounds.height + (_borderSize * 2));
			if(!_transparent) {
				$sprite.graphics.endFill();
			}
//			$sprite.removeAllChilds();
		}

		protected function getResizeButton():Sprite {
			var resizeButton:Sprite = new Sprite();
			resizeButton.useHandCursor = true;
			resizeButton.buttonMode = true;
			resizeButton.addEventListener(MouseEvent.MOUSE_DOWN, onResizeBtnMouseDown);
			setResizeButtonGraphic(resizeButton, _bounds);
			return resizeButton;
		}

		protected function setResizeButtonGraphic($sprite:Sprite, $bounds:Rectangle):void {
			if(!_resizeGraphic) {
				_resizeGraphic = new ResizeButton();
			}
			_resizeGraphic.x = $bounds.width - (_resizeGraphic.width / 3);
			_resizeGraphic.y = $bounds.height - (_resizeGraphic.height / 3);
			$sprite.addChild(_resizeGraphic);
		}

		protected function setRotateButtonGraphic($sprite:Sprite, $bounds:Rectangle):void {
			if(!_rotateGraphic) {
				_rotateGraphic = new RotateButton();
			}
			_rotateGraphic.x = - (_rotateGraphic.width / 1.5);
			_rotateGraphic.y = - (_rotateGraphic.height / 1.5);
			$sprite.addChild(_rotateGraphic);
		}

		protected function getRotationButton():Sprite {
			var rotateButton:Sprite = new Sprite();
			rotateButton.useHandCursor = true;
			rotateButton.buttonMode = true;
			rotateButton.addEventListener(MouseEvent.MOUSE_DOWN, onRotateBtnMouseDown);
			setRotateButtonGraphic(rotateButton, _bounds);
			return rotateButton;
		}
	}
}