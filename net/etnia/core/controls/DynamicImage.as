package net.etnia.core.controls {

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import net.etnia.core.controls.structures.DynamicImageData;
	import net.etnia.core.controls.structures.IDynamicSpriteData;
	import net.etnia.core.interfaces.IObject;

	public class DynamicImage extends DynamicSprite implements IDynamicSprite, IObject {

		protected static const GRAPHIC_ID:String = "graphic";

		protected var _URL:String;
		protected var _graphicName:String;
		protected var _image:DisplayObject;

		override public function get classType():String {
			return "net.etnia.core.controls.DynamicImage";
		}

		public function get image():DisplayObject {
			return _image;
		}
		
		public function get URL():String {
			return _URL;
		}

		public function set URL($value:String):void {
			_URL = $value;
			loadImage(_URL);
		}

		public function DynamicImage($URL:String = "", $bounds:Rectangle = null, $controlColor:uint = 0xADD628) {
			_URL = $URL;
			super($bounds, $controlColor);
		}

		override public function getData():IDynamicSpriteData {
			var data:DynamicImageData = new DynamicImageData("", _URL, _bounds, _contentRotateContainer.rotation); 
			return data;
		}

		override public function setData($data:IDynamicSpriteData):void {
			_initial = null;
			var data:DynamicImageData = $data as DynamicImageData;
			URL = data.URL;
			super.setData($data);
		}

		override public function destroy():void {
			super.destroy();
		}

		override protected function init($bounds:Rectangle = null):void {
			super.init($bounds);
			if(_URL != "") {
				loadImage(_URL);
			}
		}

		override protected function addChilds($controlFirst:Boolean = true):void {
			super.addChilds(!$controlFirst);
		}

		protected var _imageLoader:Loader;
		protected var _imageLoaded:Boolean;

		protected function loadImage($imageURL:String):void {
			trace("loadImage :: " + $imageURL);
			if(!$imageURL) {
				return;
				throw new Error("Thumbnail: No se puede cargar un $imageURL nulo");
			}
			var urlReq:URLRequest = new URLRequest($imageURL);
			var context:LoaderContext = new LoaderContext(true);
			_imageLoader = new Loader();
			createLoadImageListeners();
			_imageLoader.load(urlReq, context);
		}

		protected function createLoadImageListeners($create:Boolean = true):void {
			if(_imageLoader) {
				addListener(_imageLoader.contentLoaderInfo, Event.INIT, onLoadImage, $create);
				addListener(_imageLoader.contentLoaderInfo, ProgressEvent.PROGRESS, onProgress, $create);
				addListener(_imageLoader.contentLoaderInfo, IOErrorEvent.IO_ERROR, onLoadImageIOError, $create);
			}
		}

		protected function onLoadImage($event:Event):void {
			createLoadImageListeners(false);
			if(_imageLoader.content) {
				if(_imageLoader.content is Bitmap) {
					(_imageLoader.content as Bitmap).smoothing = true;
				}
				addChild(_imageLoader.content);
				_image = _imageLoader.content;
			}
			trace("onLoadImage");
			_imageLoaded = true;
			setGraphic(_image);
			dispatchEvent(new Event(ON_DYNAMIC_SPRITE_INIT));
		}

		protected function onProgress($event:ProgressEvent):void {
//			trace($event.bytesLoaded + " ::: " + $event.bytesTotal);
		}

		protected function onLoadImageIOError($event:IOErrorEvent):void {
			createLoadImageListeners(false);
//			dispatchEvent(new Event(ThumbnailEventType.ON_THUMBNAIL_LOAD_ERROR));
		}

		protected function setGraphic($graphic:DisplayObject):void {
			addChild($graphic);
			if(_bounds.width == 1 && _bounds.height == 1) {
				setBounds(new Rectangle(_bounds.x, _bounds.y, $graphic.width, $graphic.height));
				_initial = _bounds;
			} else {
				$graphic.width = _bounds.width;
				$graphic.height = _bounds.height;
				setBounds(_bounds);
			}
		}

	}
}