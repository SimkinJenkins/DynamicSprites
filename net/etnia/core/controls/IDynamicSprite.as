package net.etnia.core.controls {

	import com.interfaces.ISprite;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import net.etnia.core.controls.structures.IDynamicSpriteData;

	public interface IDynamicSprite extends ISprite {

		function set data($data:IDynamicSpriteData):void;
		function get data():IDynamicSpriteData;
		function set bounds($bounds:Rectangle):void;
		function get bounds():Rectangle;
		function get lastBounds():Rectangle;
		function get control():DynamicSpriteControl;
		function get classType():String;
		function set editable($value:Boolean):void;
		function get editable():Boolean;

		function getData():IDynamicSpriteData;
		function setData($data:IDynamicSpriteData):void;
		function destroy():void;

	}
}