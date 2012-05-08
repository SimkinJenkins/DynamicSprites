package net.etnia.core.controls {

	import fl.events.SliderEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import net.etnia.core.controls.structures.CanvasData;
	import net.etnia.core.controls.structures.DynamicCanvasData;
	import net.etnia.core.controls.structures.IDynamicSpriteData;
	import net.etnia.core.interfaces.IObject;
	import net.etnia.graphics.Canvas;

	public class DynamicCanvas extends DynamicImage implements IDynamicSprite, IObject {

		protected var _canvas:Canvas;
		protected var _initScale:Number;
		protected var _border:Sprite;
		protected var _maskID:String = "default";
		protected var _canvasData:CanvasData;
		protected var _loadable:Boolean;

		override public function set editable($value:Boolean):void {
			super.editable = $value;
			_canvas.editable = $value;
		}

		public function get source():Sprite {
			return _canvas.source;
		}

		public function set source($source:Sprite):void {
			_canvas.source = $source;
			if($source.width > _canvas.width) {
				_canvas.zoom = (_canvas.width / $source.width);
			}
			_initScale = _canvas.zoom;
			_canvas.resetSourcePosition();
			if(_canvasData) {
				_canvas.setData(_canvasData);
				_canvasData = null;
			}
			addElements();
		}
		
		public function setBGAppearence($color:int = 1, $alpha:int = 0):void{
			if(_canvas){
				_canvas.bgAppearence($color, $alpha);
			}
		}

		override public function get classType():String {
			return "net.etnia.core.controls.DynamicCanvas";
		}

		public function DynamicCanvas($URL:String = "", $bounds:Rectangle = null, $controlColor:uint=0xADD628) {
			$bounds = $bounds == null ? new Rectangle(0, 0, 50, 50) : $bounds;
			super($URL, $bounds, $controlColor);
		}

		override public function getData():IDynamicSpriteData {
			return new DynamicCanvasData("", _bounds, _contentRotateContainer.rotation, 0,
										0, _maskID, _URL,
										_canvas.getData(), (_control as DynamicSpriteSliderControl).slider.value);
		}

		override public function setData($data:IDynamicSpriteData):void {
			var data:DynamicCanvasData = $data as DynamicCanvasData;
			_canvasData = data.canvasData;
			(_control as DynamicSpriteSliderControl).slider.value = data.sliderPos;
			super.URL = data.URL;
			super.setData($data);
		}

		public function setMask($value:Sprite):void {
			_canvas.setMask($value);
		}

		override protected function init($bounds:Rectangle = null):void {
			_canvas = getCanvas($bounds);
			super.init($bounds);
		}

		override protected function setScale($bounds:Rectangle):void {
			_canvas.width = $bounds.width;
			_canvas.height = $bounds.height;
		}

		override protected function getControl($bounds:Rectangle):DynamicSpriteControl {
			return new DynamicSpriteSliderControl($bounds);
		}

		override protected function addControlListeners($add:Boolean = true):void {
			super.addControlListeners($add);
			if($add) {
				_control.addEventListener(SliderEvent.THUMB_DRAG, onSliderDrag);
			} else {
				_control.removeEventListener(SliderEvent.THUMB_DRAG, onSliderDrag);
			}
		}

		override protected function setGraphic($graphic:DisplayObject):void {
			var sourceSprite:Sprite = new Sprite();
			sourceSprite.addChild($graphic);
			source = sourceSprite;
		}

		override protected function addChilds($controlFirst:Boolean = true):void {
			super.addChilds(!$controlFirst);
		}

		protected function getCanvas($bounds:Rectangle):Canvas {
			return new Canvas($bounds.width, $bounds.height);
		}

		protected function addElements():void {
			addChild(_canvas);
		}

		protected function onSliderDrag($event:DynamicSpriteSliderControlEvent):void {
			if(_canvas.source) {
				_canvas.zoom = _initScale + ($event.value * .07);
			}
		}

	}
}