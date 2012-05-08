package com.arcww.engine3d.projection2d
{
	import com.arcww.display.ArcSprite;
	import com.arcww.display.Box;
	import com.arcww.engine3d.projection2d.geom.Point3D;
	import com.arcww.engine3d.projection2d.geom.engines.Perspective3DEngine;
	
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ProjectionConfigurator extends ArcSprite
	{
		private var _sliderCameraX:Slider = new Slider ();
		private var _sliderCameraY:Slider = new Slider ();
		private var _sliderCameraZ:Slider = new Slider ();
		private var _sliderLimit2DX:Slider = new Slider ();
		private var _sliderLimit2DY:Slider = new Slider ();
		private var _sliderLimit2DWidth:Slider = new Slider ();
		private var _sliderLimit2DHeight:Slider = new Slider ();
		private var _sliderScreenSizeX:Slider = new Slider ();
		private var _sliderScreenSizeY:Slider = new Slider ();
		private var _sliderScreenSizeWidth:Slider = new Slider ();
		private var _sliderScreenSizeHeight:Slider = new Slider ();
		private var _sliderSceneX:Slider = new Slider ();
		private var _sliderSceneY:Slider = new Slider ();
		private var _container:ArcSprite = new ArcSprite ();
		private var _container2dReference:ArcSprite = new ArcSprite ();
		///////////////////////-------------------------->
		private var _screenSizeX:Number = -1336;
		private var _screenSizeY:Number = -1803;
		private var _screenSizeWidth:Number = 1250;
		private var _screenSizeHeight:Number =  504;
		private var _cameraX:Number = 650;
		private var _cameraY:Number = 843;
		private var _cameraZ:Number = 404;
		private var _limits2DX:Number = 3;
		private var _limits2DY:Number = 3;
		private var _limits2DWidth:Number = 1245;
		private var _limits2DHeight:Number = 406;
		private var _sceneX:Number = 134;
		private var _sceneY:Number = -453;
		private var _sliderX:Number = 25;


		public function ProjectionConfigurator()
		{
			var snap:Number = 1;
			var sliderWidth:Number = 800;
			addChild(_container);
			addChild(_container2dReference);
			_sliderCameraX.minimum = -4000;
			_sliderCameraX.width = sliderWidth;
			_sliderCameraX.maximum = 4000;
			_sliderCameraX.liveDragging = true;
			_sliderCameraX.snapInterval = snap;
			_sliderCameraX.value = _cameraX;
			_sliderCameraX.name = "Camera X"
			_sliderCameraX.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderCameraX);
			_sliderCameraY.minimum = -4000;
			_sliderCameraY.width = sliderWidth;
			_sliderCameraY.maximum = 4000;
			_sliderCameraY.liveDragging = true;
			_sliderCameraY.snapInterval = snap;
			_sliderCameraY.value = _cameraY;			
			_sliderCameraY.name = "Camera Y";
			_sliderCameraY.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderCameraY);
			_sliderCameraZ.minimum = -4000;
			_sliderCameraZ.width = sliderWidth;
			_sliderCameraZ.maximum = 4000;
			_sliderCameraZ.liveDragging = true;
			_sliderCameraZ.snapInterval = snap;
			_sliderCameraZ.value = _cameraZ;
			_sliderCameraZ.name = "Camera Z";
			_sliderCameraZ.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderCameraZ);
			_sliderLimit2DX.minimum = -1000;
			_sliderLimit2DX.width = sliderWidth;
			_sliderLimit2DX.maximum = 1000;
			_sliderLimit2DX.liveDragging = true;
			_sliderLimit2DX.snapInterval = snap;
			_sliderLimit2DX.value = _limits2DX;			
			_sliderLimit2DX.name = "Limit 2D X";
			_sliderLimit2DX.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderLimit2DX);
			_sliderLimit2DY.minimum = -1000;
			_sliderLimit2DY.width = sliderWidth;
			_sliderLimit2DY.maximum = 1000;
			_sliderLimit2DY.liveDragging = true;
			_sliderLimit2DY.snapInterval = snap;
			_sliderLimit2DY.value = _limits2DY;			
			_sliderLimit2DY.name = "Limit 2D Y";
			_sliderLimit2DY.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderLimit2DY);
			_sliderLimit2DWidth.minimum = 0;
			_sliderLimit2DWidth.width = sliderWidth;
			_sliderLimit2DWidth.maximum = 5000;
			_sliderLimit2DWidth.liveDragging = true;
			_sliderLimit2DWidth.snapInterval = snap;
			_sliderLimit2DWidth.value = _limits2DWidth;			
			_sliderLimit2DWidth.name = "Limit 2D Width";
			_sliderLimit2DWidth.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderLimit2DWidth);
			_sliderLimit2DHeight.minimum = 0;
			_sliderLimit2DHeight.width = sliderWidth;
			_sliderLimit2DHeight.maximum = 5000;
			_sliderLimit2DHeight.liveDragging = true;
			_sliderLimit2DHeight.snapInterval = snap;
			_sliderLimit2DHeight.value = _limits2DHeight;			
			_sliderLimit2DHeight.name = "Limit 2D Height";
			_sliderLimit2DHeight.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderLimit2DHeight);
			
			_sliderScreenSizeX.minimum = -2000;
			_sliderScreenSizeX.width = sliderWidth;
			_sliderScreenSizeX.maximum = 2000;
			_sliderScreenSizeX.liveDragging = true;
			_sliderScreenSizeX.snapInterval = snap;
			_sliderScreenSizeX.value = _screenSizeX;			
			_sliderScreenSizeX.name = "Screen Size X";
			_sliderScreenSizeX.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderScreenSizeX);
			_sliderScreenSizeY.minimum = -2000;
			_sliderScreenSizeY.width = sliderWidth;
			_sliderScreenSizeY.maximum = 2000;
			_sliderScreenSizeY.liveDragging = true;
			_sliderScreenSizeY.snapInterval = snap;
			_sliderScreenSizeY.value = _screenSizeY;
			_sliderScreenSizeY.name = "Screen Size Y";
			_sliderScreenSizeY.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderScreenSizeY);
			
			_sliderScreenSizeWidth.minimum = -2000;
			_sliderScreenSizeWidth.width = sliderWidth;
			_sliderScreenSizeWidth.maximum = 2000;
			_sliderScreenSizeWidth.liveDragging = true;
			_sliderScreenSizeWidth.snapInterval = snap;
			_sliderScreenSizeWidth.value = _screenSizeWidth;			
			_sliderScreenSizeWidth.name = "ScreenSize Width";
			_sliderScreenSizeWidth.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderScreenSizeWidth);
			_sliderScreenSizeHeight.minimum = -2000;
			_sliderScreenSizeHeight.width = sliderWidth;
			_sliderScreenSizeHeight.maximum = 2000;
			_sliderScreenSizeHeight.liveDragging = true;
			_sliderScreenSizeHeight.snapInterval = snap;
			_sliderScreenSizeHeight.value = _screenSizeHeight;			
			_sliderScreenSizeHeight.name = "ScreenSize Height";
			_sliderScreenSizeHeight.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderScreenSizeHeight);
			_sliderSceneX.minimum = -3000;
			_sliderSceneX.width = sliderWidth;
			_sliderSceneX.maximum = 3000;
			_sliderSceneX.liveDragging = true;
			_sliderSceneX.snapInterval = snap;
			_sliderSceneX.value = _sceneX;	
			_sliderSceneX.name = "Scene X";
			_sliderSceneX.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderSceneX);
			_sliderSceneY.minimum = -3000;
			_sliderSceneY.width = sliderWidth;
			_sliderSceneY.maximum = 3000;
			_sliderSceneY.liveDragging = true;
			_sliderSceneY.snapInterval = snap;
			_sliderSceneY.value = _sceneY;	
			_sliderSceneY.name = "Scene Y";
			_sliderSceneY.addEventListener(SliderEvent.THUMB_DRAG, onValueChange);
			addChild(_sliderSceneY);
			
			
			
		
			
			//----------->
			var sliders:Array = [_sliderCameraX, _sliderCameraY, _sliderCameraZ, _sliderLimit2DX, _sliderLimit2DY, 	_sliderLimit2DWidth, _sliderLimit2DHeight , 	_sliderScreenSizeX, _sliderScreenSizeY, _sliderScreenSizeWidth, _sliderScreenSizeHeight, _sliderSceneX, _sliderSceneY ];
			for (var i:uint = 0; i< sliders.length; i++ ){
				var currentSlider:Slider = sliders[i];
				var textFormat:TextFormat = new TextFormat ("Arial", 12, 0x000000);
				var newText:TextField = new TextField ();
				newText.selectable = false;
				newText.defaultTextFormat = textFormat;
				newText.text = currentSlider.name;
				newText.y = (40*i)+10;
				newText.autoSize = TextFieldAutoSize.LEFT;
				currentSlider.x = 10;
				currentSlider.y = 40*i;
				addChild(newText);
			}
			redraw();
		}
		protected function  onValueChange ($event:SliderEvent):void{
			//trace ("onvaluechange")
			/*_sliderCameraX
			_sliderCameraY
			_sliderCameraZ 
			_sliderLimit2DX
			_sliderLimit2DY
			_sliderLimit2DWidth
			_sliderLimit2DHeight
			_sliderScreenSizeX
			_sliderScreenSizeY
			_sliderScreenSizeWidth
			_sliderScreenSizeHeight
			_sliderSceneX
			_sliderSceneY*/
			if($event.currentTarget == _sliderCameraX){
				_cameraX = $event.value;
			}else if($event.currentTarget == _sliderCameraY){
			 	_cameraY = $event.value;
			}else if($event.currentTarget == _sliderCameraZ){
				_cameraZ = $event.value;
			}else if($event.currentTarget == _sliderLimit2DX){
				 _limits2DX = $event.value;
			}else if($event.currentTarget == _sliderLimit2DY){
				_limits2DY = $event.value;
			}else if($event.currentTarget == _sliderLimit2DWidth){
				_limits2DWidth = $event.value;
			}else if($event.currentTarget == _sliderLimit2DHeight){
				_limits2DHeight = $event.value;
			}else if($event.currentTarget == _sliderScreenSizeX){
				_screenSizeX = $event.value;
			}else if($event.currentTarget == _sliderScreenSizeY){
				_screenSizeY = $event.value;
			}else if($event.currentTarget == _sliderScreenSizeWidth){
				_screenSizeWidth = $event.value;
			}else if($event.currentTarget == _sliderScreenSizeHeight){
				_screenSizeHeight = $event.value;
			}else if($event.currentTarget == _sliderSceneX){
				_sceneX = $event.value;
			}else if($event.currentTarget == _sliderSceneY){	
				_sceneY = $event.value;
				
			}
			redraw();
			
		}
		
		protected function redraw ():void{
			_container.removeAllChilds();
			var container:Sprite = new Sprite ();
			
		

			_container.addChild(container);

			var screenSize:Rectangle = new Rectangle(_screenSizeX, _screenSizeY, _screenSizeWidth, _screenSizeHeight);

			var engine3D:Perspective3DEngine = new Perspective3DEngine(screenSize);

			engine3D.setTestingMode(container);
			engine3D.cameraPosition = new Point3D(_cameraX, _cameraY, _cameraZ);
			engine3D.limits2D = new Rectangle(_limits2DX, _limits2DY, _limits2DWidth, _limits2DHeight);
			container.y = _sceneY;
			container.x = _sceneX;
			
			
			/*var testBox:Box = new Box (400,5,5,0xFF0000);
			container.addChild(testBox);
			
			var p:Point3D = engine3D.getPointProjection(new Point3D (622.5, 406 ));
			testBox.x = p.x-(testBox.height/2);
			testBox.y = p.y-(testBox.height/2);*/
			
			trace ("***************************************************************************************************************************************************************************************************************************************************************************");
			trace (	"private var _screenSizeX =", _screenSizeX , ";\n","private var _screenSizeY =", _screenSizeY , ";\n","private var _screenSizeWidth =", _screenSizeWidth , ";\n","private var _screenSizeHeight =", _screenSizeHeight , ";\n","private var _cameraX =", _cameraX , ";\n","private var _cameraY =", _cameraY , ";\n","private var _cameraZ =", _cameraZ , ";\n","private var _limits2DX =", _limits2DX , ";\n","private var _limits2DY =", _limits2DY , ";\n","private var _limits2DWidth =", _limits2DWidth , ";\n", "private var _limits2DHeight =", _limits2DHeight , ";\n","private var _sceneX =", _sceneX , ";\n",	"private var _sceneY =", _sceneY , ";\n","private var _sliderX =", _sliderX , ";\n")
			trace ("***************************************************************************************************************************************************************************************************************************************************************************");
		}

		
		
		}
}