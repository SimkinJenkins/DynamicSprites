package net.etnia.core.controls {

	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	import net.etnia.core.controls.structures.IDynamicSpriteData;
	import net.etnia.core.interfaces.IObject;

	public class DynamicUploadedImage extends DynamicImage implements IDynamicSprite, IObject {

		protected var _initButton:String;

		public function DynamicUploadedImage($URL:String = "", $bounds:Rectangle = null, $initButton:String = "") {
			super($URL, $bounds, $initButton);
		}

		override public function get classType():String {
			return "net.arc.dreameditor.core.controls.DynamicUploadedImage";
		}

		override public function getData():IDynamicSpriteData {
			return super.getData();
		}

		override public function setData($data:IDynamicSpriteData):void {
			super.setData($data);
		}
		
		override protected function init($bounds:Rectangle = null, $initButton:String = ""):void {
			_initButton = $initButton;
			super.init($bounds, $initButton);
		}

		override public function destroy():void {
			super.destroy();
		}

		protected function addElements():void {}

	}
}