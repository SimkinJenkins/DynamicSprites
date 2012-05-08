package net.etnia.graphics {
	
	import com.etnia.core.system.EtniaSystem;
//	import com.facebook.commands.stream.AddLike;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.etnia.core.controls.structures.CanvasData;
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;

	public class Canvas extends Sprite {

		protected var _mask:Sprite;
		protected var _border:Sprite;
		protected var _container:Sprite;
		protected var _width:Number;
		protected var _height:Number;
		protected var _source:Sprite;
		protected var _draggable:Boolean;
		protected var _parseSize:Boolean = true;
		protected var _borderFactor:Number = 1;
		protected var _editable:Boolean = true;

		public function get editable():Boolean {
			return _editable;
		}

		public function set editable($value:Boolean):void {
			_editable = $value;
			if(_editable) {
				_container.addEventListener(MouseEvent.MOUSE_DOWN, dragContainerStart);
			} else {
				_container.removeEventListener(MouseEvent.MOUSE_DOWN, dragContainerStart);
			}
		}

		public function Canvas($width:Number, $height:Number, $mask:Sprite = null):void {
			_width = $width;
			_height = $height;
			createContainer($mask);
		}

		public function setBorder($border:Sprite, $factor:Number = 1):void {
			if(_border && _border.parent == this) {
				removeChild(_border);
			}
			_border = $border;
			addChild(_border);
			_borderFactor = $factor;
			width = _width;
			height = _height;			
		}
		
		public function bgAppearence($color:int, $alpha:Number):void{
			var bgEdit:Sprite = getChildAt(1) as Sprite;
			bgEdit.graphics.clear();
			bgEdit.graphics.beginFill($color, $alpha);
			bgEdit.graphics.drawRect(0, 0, width, height);
			bgEdit.graphics.endFill();
		}
		
		public function getData():CanvasData {
			return new CanvasData(_source.x, _source.y, zoom);
		}

		public function setData($data:CanvasData):void {
			zoom = $data.zoom;
			_source.x = $data.sourceX;
			_source.y = $data.sourceY;
		}

		public function setMask($mask:Sprite):void {
			if(_mask && _mask.parent == this) {
				removeChild(_mask);
			}
			_mask = $mask;
			addChild(_mask);
			_container.mask = _mask;
			width = _width;
			height = _height;
		}

		protected function createBackground():void {
			addChild(getBox());
		}

		protected function getBox():Sprite {
			var back:Sprite = new Sprite();
			back.graphics.beginFill(0, 0);
			back.graphics.drawRect(0, 0, width, height);
			back.graphics.endFill();
			return back;
		}

		protected function createContainer($mask:Sprite = null):void {
			_container = new Sprite();
			setMask($mask == null ? getBox() : $mask);
			addChild(_container);
			setDraggeable();
		}

		override public function set width($width:Number):void {
//			_mask.width = $width;
			_width = $width;
			if(_border) {
				_border.width = $width * _borderFactor;
			}
		}

		override public function get width():Number {
			return _width;
		}

		override public function set height($height:Number):void {
//			_mask.height = $height;
			_height = $height;
			if(_border) {
				_border.height = $height * _borderFactor;
			}
		}

		override public function get height():Number {
			return _height;
		}

		public function set source($source:Sprite):void {
			if(_container.numChildren > 0) {
				_container.removeChild(_container.getChildAt(0));
			}
			parseCanvasSize($source);
			_source = $source;
			_container.addChild($source);
		}

		public function parseCanvasSize($sprite:Sprite):void {
			if($sprite.width > width || $sprite.height > height) {
				_draggable = true;
			} else {
				_draggable = !_parseSize;
				$sprite.x = (width - $sprite.width) / 2;
				$sprite.y = (height - $sprite.height) / 2;
			}
		}

		public function get source():Sprite {
			return _source;
		}

		protected function setDraggeable():void {
			_container.addEventListener(MouseEvent.MOUSE_DOWN, dragContainerStart);
		}

		protected function dragContainerStart($event:MouseEvent):void {
			if(!_draggable) {
				return;
			}
			EtniaSystem.stageRoot.addEventListener(MouseEvent.MOUSE_UP, dragContainerStop);
			var bounds:Rectangle = new Rectangle(0, 0, -_container.width + width, -_container.height + height);
			_source.startDrag(false);
		}

		protected function dragContainerStop($event:MouseEvent):void {
			EtniaSystem.stageRoot.removeEventListener(MouseEvent.MOUSE_UP, dragContainerStop);
			_source.stopDrag();
		}

		public function set zoom($scale:Number):void {
			if(zoom == $scale) {
				return;
			}
			if(_source) {
				var imageAnchor:ComplexPoint = new ComplexPoint((_width / 2) - _source.x, (_height / 2) - _source.y);
				var lastScale:Number = _source.scaleX;
				_source.scaleX = _source.scaleY = $scale;
				_source.x = (_width / 2) - (($scale * imageAnchor.x) / lastScale);
				_source.y = (_height / 2) - (($scale * imageAnchor.y) / lastScale);
			}
		}

		public function get zoom():Number {
			return _source.scaleX;
		}

		public function set draggable($draggable:Boolean):void {
			_draggable = $draggable;
		}

		public function set parseSize($parseSize:Boolean):void {
			_parseSize = $parseSize;
		}

		override public function set rotation($rotation:Number):void {
			_source.rotation = $rotation;
		}

		override public function get rotation():Number {
			return _source.rotation;
		}

		public function resetSourcePosition():void {
			_source.x = (width - _source.width) / 2;
			_source.y = (height - _source.height) / 2;
		}

	}
}
