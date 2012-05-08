package net.etnia.core.controls {

	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class DynamicSpriteSliderControl extends DynamicSpriteControl {

		protected var _slider:Slider;
		protected var _maskMenu:MovieClip;
		protected var _sliderContainer:Sprite;

		public function get slider():Slider {
			return _slider;
		}

		public function DynamicSpriteSliderControl($bounds:Rectangle, $transparent:Boolean = false, $borderColor:uint = 0xADD628) {
			super($bounds, $transparent, $borderColor);
		}
		
		public function moveEnableMode($enable:Boolean = true):void {
			_borderGraphic.visible = $enable;
			_resizeButton.visible = $enable;
			_rotationButton.visible = $enable;
			_closeButton.visible = $enable;
		}

		public function update():void {
			onSliderDrag(null);
		}

		override protected function init():void {
			super.init();
			_slider = new Slider();
			_slider.addEventListener(SliderEvent.THUMB_DRAG, onSliderDrag);
			_slider.addEventListener(SliderEvent.CHANGE, onSliderDrag);
			_sliderContainer = new Sprite();
			_sliderContainer.graphics.beginFill(0, 0);
			_sliderContainer.graphics.drawRect(0, 0, _slider.width + 20, _slider.height + 20);
			_sliderContainer.graphics.endFill();
			_slider.x = 10;
			_slider.y = 5;
			_sliderContainer.addChild(_slider);
			_sizeCont.addChild(_sliderContainer);
			setSliderPosition(_sliderContainer, _bounds);
//			setMaskMenuPosition(_maskMenu, _bounds);
//			_sizeCont.addChild(_maskMenu);
		}

		override protected function setGraphics($bounds:Rectangle):void {
			super.setGraphics($bounds);
			setSliderPosition(_sliderContainer, $bounds);
			//			setMaskMenuPosition(_maskMenu, $bounds);
		}

		protected function setSliderPosition($sliderContainer:Sprite, $bounds:Rectangle):void {
			$sliderContainer.x = ($bounds.width / 2) - ($sliderContainer.width / 2);
			$sliderContainer.y = $bounds.height + 6;
		}

		protected function setMaskMenuPosition($maskMenu:MovieClip, $bounds:Rectangle):void {
			$maskMenu.x = $bounds.width + 10;
			$maskMenu.y = Math.max(0, ($bounds.height * .25) - ($maskMenu.height / 2));
		}

		protected function onSliderDrag($event:SliderEvent):void {
			dispatchEvent(new DynamicSpriteSliderControlEvent(_slider.value, SliderEvent.THUMB_DRAG));
		}
		

	}
}