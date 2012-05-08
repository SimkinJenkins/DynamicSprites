package net.etnia.engine3d.projection2d.geom.engines {

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.etnia.engine3d.projection2d.BasicCanvas;
	import net.etnia.engine3d.projection2d.geom.Point3D;
	import net.etnia.engine3d.projection2d.geom.engines.phisics.ParabolicMovement;
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;
	import net.interalia.etnia.ui.theme.SimpleButtonFactory;
	
	/**
	 * Tester gráfico para el engine para simular una perspectiva 3D
	 * 
	 * Dibuja un area 2D, con limits2D del engine
	 * dibuja el area de trabajo y dibuja la simulación de dos jugadores capaces,
	 * de tirar un objeto mediante un tiro parabolico de uno de los puntos al otro.
	 * 
	 * Para activar:
	 * 
	 * @example 
	 * 
			var engine3D:Perspective3DEngine = new Perspective3DEngine(screenSize);

 			//Para inicializar los valores.

			engine3D.setTestingMode(container);
			engine3D.cameraPosition = new Point3D(450, 400, 400);
			engine3D.limits2D = new Rectangle(10, 10, 880, 380);

	 * 
	 * @author Simkin
	 * 
	 */
	public class Perspective3DEngineTester extends BasicCanvas {

		protected var _container:Sprite;
		protected var _limits:BasicCanvas;
		protected var _camera:BasicCanvas;
		protected var _perspective:BasicCanvas;
		protected var _limitGraphicXY:BasicCanvas;

		protected var _player1:BasicCanvas;
		protected var _player2:BasicCanvas;

		protected var _engine:Perspective3DEngine;

		public function set container($container:Sprite):void {
			_container = $container;
			_container.addChild(this);
		}

		public function Perspective3DEngineTester($engine:Perspective3DEngine) {
			_limits = addBasicCanvas();
			_camera = addBasicCanvas();
			_engine = $engine;
			_perspective = addBasicCanvas();
		}

		public function on2DLimitsSetted($event:Event):void {
			var point1:Point3D = _engine.getPointProjection(new Point3D(_engine.limits2D.left, _engine.limits2D.top, 0));
			var point2:Point3D = _engine.getPointProjection(new Point3D(_engine.limits2D.right, _engine.limits2D.top, 0));
			var point3:Point3D = _engine.getPointProjection(new Point3D(_engine.limits2D.right, _engine.limits2D.bottom, 0));
			var point4:Point3D = _engine.getPointProjection(new Point3D(_engine.limits2D.left, _engine.limits2D.bottom, 0));
			_limits.graphics.beginFill(0x00FF00, .3);
			_limits.complexGraphics.lineFrom(point1.get2DPoint(), point2.get2DPoint());
			_limits.complexGraphics.lineTo(point3.get2DPoint());
			_limits.complexGraphics.lineTo(point4.get2DPoint());
			_limits.complexGraphics.lineTo(point1.get2DPoint());
			_limits.graphics.endFill();
			_limitGraphicXY = _limits.addBasicCanvas();
			_limitGraphicXY.x = _engine.limits2D.x;
			_limitGraphicXY.y = _engine.limits2D.y;
			_limitGraphicXY.graphics.beginFill(0x000000, 1);
			_limitGraphicXY.graphics.lineStyle(1, 0x0FF0FF, 1);
			_limitGraphicXY.graphics.drawRect(0, 0, _engine.limits2D.width, _engine.limits2D.height);
			_limitGraphicXY.graphics.endFill();
			_limitGraphicXY.scale = .3
			var button:SimpleButton = SimpleButtonFactory.getButton("Probar tiro Parabolico");
			button.x = 200;
			button.y = 300;
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
//			button.x = 400;
//			button.y = 100;
			_limits.addChild(button);
			_player1 = addTestElement(new Point3D(100, 0, 0), "la");
			_player2 = addTestElement(new Point3D(600, 400, 0), "lala");
		}

		public function onCameraPositionSetted($event:Event):void {
			drawInitState($event);
		}

		public function drawInitState($event:Event):void {
			_perspective = null;
			_perspective = addBasicCanvas();
			_perspective.graphics.lineStyle(1, 0x0000FF, 1);
			_perspective.complexGraphics.drawRect(_engine.screenBack);
			_perspective.graphics.lineStyle(1, 0xFF0000, 1);
			_perspective.complexGraphics.drawRect(_engine.screen);
			_perspective.complexGraphics.lineFrom(new ComplexPoint(_engine.screenBack.left, _engine.screenBack.bottom), new ComplexPoint(_engine.screen.x, _engine.screen.y + _engine.screen.height));
			_perspective.complexGraphics.lineFrom(new ComplexPoint(_engine.screenBack.left, _engine.screenBack.top), new ComplexPoint(_engine.screen.x, _engine.screen.y));
			_perspective.complexGraphics.lineFrom(new ComplexPoint(_engine.screenBack.right, _engine.screenBack.top), new ComplexPoint(_engine.screen.x + _engine.screen.width, _engine.screen.y));
			_perspective.complexGraphics.lineFrom(new ComplexPoint(_engine.screenBack.right, _engine.screenBack.bottom), new ComplexPoint(_engine.screen.x + _engine.screen.width, _engine.screen.y + _engine.screen.height));
		}

		public function drawPoint($point:ComplexPoint, $color:uint = 0x0000FF):void {
			_perspective.graphics.lineStyle(1, $color, 1);
//			trace($point);
			_perspective.complexGraphics.drawCircle($point, 1);
		}

		public function addTestElement($initialPos:Point3D, $ID:String):BasicCanvas {
			var circle:BasicCanvas = _limitGraphicXY.addBasicCanvas();
			circle.graphics.beginFill(0x234523);
			circle.x = $initialPos.x;
			circle.y = $initialPos.y;
			circle.pos3D = $initialPos;
			circle.graphics.drawCircle(0, 0, 20);
			circle.graphics.endFill();
			circle.addEventListener(MouseEvent.MOUSE_DOWN, onTestMouseDown);
			circle.addEventListener(MouseEvent.CLICK, onTestClick);
			circle.name = $ID;

			var circle3D:BasicCanvas = _perspective.addBasicCanvas();
			circle3D.graphics.beginFill(0x234523);
			circle3D.graphics.drawCircle(0, 0, 5);
			circle3D.graphics.endFill();
			circle3D.pos3D = $initialPos;
			circle3D.name = $ID + "bis3D";
			
			setTestElementPosition(circle);
			return circle;
		}

		protected function setTestElementPosition($object:BasicCanvas):void {
			var bis:BasicCanvas = _perspective.getChildByName($object.name + "bis3D") as BasicCanvas;
			bis.pos3D = $object.pos3D;
			var pos3D:Point3D = _engine.getPointProjection(bis.pos3D);
			bis.x = pos3D.x;
			bis.y = pos3D.y;
			bis.scaleX = bis.scaleY = pos3D.scaleFactor;
		}

		protected function onTestMouseDown($event:MouseEvent):void {
			var target:BasicCanvas = $event.target as BasicCanvas;
			target.addEventListener(Event.ENTER_FRAME, onTestEnterFrame);
			target.startDrag(false, _engine.limits2D);
		}

		protected function onTestClick($event:MouseEvent):void {
			var target:BasicCanvas = $event.target as BasicCanvas;
			target.removeEventListener(Event.ENTER_FRAME, onTestEnterFrame);
			target.stopDrag();
			setTestElementPosition(target);
		}

		protected function onTestEnterFrame($event:Event):void {
			var target:BasicCanvas = $event.target as BasicCanvas;
			target.pos3D.x = target.x;
			target.pos3D.y = target.y;
			setTestElementPosition(target);
		}

		protected function moveBall():void {
			var parabolicMov:ParabolicMovement = _engine.phisics.getParabolicMovement();
			parabolicMov.init3DMovementBetween(_player1.pos3D.clone3DPoint(), _player2.pos3D.clone3DPoint(), 60);

			var ball:BasicCanvas = _perspective.addBasicCanvas();
			ball.graphics.beginFill(0x234523);
			ball.graphics.drawCircle(0, 0, 5);
			ball.graphics.endFill();
			ball.name = "ball";
			ball.x = _player1.x;
			ball.y = _player1.y;
			ball.scaleX = ball.scaleY = _player1.scaleX;

			_engine.throwElement(ball, parabolicMov);
			_engine.addEventListener(Perspective3DEngine.ELEMENT_THROW, onElementThrow);

		}

		protected function onElementThrow($event:Event):void {
			var ball:BasicCanvas = _perspective.getChildByName("ball") as BasicCanvas;
			_perspective.removeChild(ball);
		}

		protected function onButtonClick($event:MouseEvent):void {
			moveBall();
		}

	}
}