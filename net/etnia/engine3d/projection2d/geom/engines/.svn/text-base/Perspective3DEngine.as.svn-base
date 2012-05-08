package net.etnia.engine3d.projection2d.geom.engines {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import net.etnia.engine3d.projection2d.geom.Line;
	import net.etnia.engine3d.projection2d.geom.Point3D;
	import net.etnia.engine3d.projection2d.geom.engines.phisics.ParabolicMovement;
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;

	/**
	 * Engine que hace los calculos matematicos para simular una perspectiva en 3D
	 * de acuerdo a la posición de la camara (con una camara siempre viendo a 90°
	 * con respecto a los ejes xz
	 * 
	 * @example 
	 * 
			var engine3D:Perspective3DEngine = new Perspective3DEngine(screenSize);

 			//Para inicializar los valores.

			engine3D.setTestingMode(box);
			engine3D.cameraPosition = new Point3D(450, 400, 400);
			engine3D.limits2D = new Rectangle(10, 10, 880, 380);

			//Para obtener un punto
			
			engine3D.get2DPoint(new Point3D(0, 0, 0));
			engine3D.get2DPoint(new Point3D(0, 30, 0));

			//Para obtener un movimiento parabolico con perspectiva en 3D.

			var parabolicMov:ParabolicMovement = engine3D.phisics.getParabolicMovement();
			parabolicMov.init3DMovementBetween(new Point3D(100, 0, 0), new Point3D(600, 400, 0), 60);

			for(var i:Number = 0; i < 20;) {
				var iPoint:Point3D = parabolicMov.getStep(i);
				trace("t=" + i + " = " + iPoint);
				engine3D.get2DPoint(iPoint);

				i += .2;
			}

	 * 
	 * @author Simkin
	 * 
	 */
	public class Perspective3DEngine extends EventDispatcher {

		/** Eventos */
		/** Evento que se tira cuando se settean limites en 3D 
		 */
		public static const ON_2D_LIMITS_SETTED:String = "on 2d limits setted";
		/**Evento que se tira cuando se settea la camara;
		 */
		public static const ON_CAMERA_POSITION_SETTED:String = "on camera position setted";
		/**Evento que se tira cuando el engina a terminado de ser inicializado
		 */
		public static const ON_ENGINE_INIT:String = "on engine init";
		/**Evento que funciona cuando se hace dinamica mediante phisics y se sirve cuando
		 * esté a terminado
		 */
		public static const ELEMENT_THROW:String = "element throw";

		/**Rectangle que sirve para delimitar el espacio principal
		 */
		protected var _2DLimits:Rectangle;
		/**Posición de la camara
		 */
		protected var _cameraPos:Point3D;
		/**Tester, sirve para hacer una simulación gráfica de los parametros y movimientos.
		 */
		protected var _tester:Perspective3DEngineTester;

		/**Tamaño inicial del Screen de trabajo
		 */
		protected var _initSize:Rectangle;
		/**Tamaño actual del BackScreen de trabajo
		 */
		protected var _screen:Rectangle;
		/**Tamaño actual del Screen de trabajo
		 */
		protected var _screenBack:Rectangle;

		/**Lineas que sirven de referencia para el ejeY
		 */ 
		protected var _yAxis:Line;
		protected var _yAxisBis:Line;

		/**Clase que alberga movimiento preprogramados para este Engine
		 */
		protected var _phisics:Phisics;

		/**Factor de profundidad;
		 */
		protected var _depthFactor:Number = 1;

		/**Lapso de tiempo que se usa para los movimientos dinamicos,
		 * en otras palabras cada cuanto tiempo se va a ejecutar un movimiento
		 * Valor en milisegundos
		 */
		protected var _throwTimerDelay:Number = 10;

		/**Avance en el tiempo para la simulación del movimiento dinamico.
		 */
		protected var _throwStep:Number = .04;

		/**Movimiento dinamico, en un momento se puede cambiar por una interfaz
		 * que represente un movimiento para así poder incluir mas movimientos.
		 */
		protected var _parabolicMovement:ParabolicMovement;

		/**Variable que guarda el elemento que esta siendo movido atraves de este
		 * engine
		 */
		protected var _elementThrow:DisplayObject;

		protected var _stopAt:Number;
//		protected var _timers:Array;

		/** Getters y Setters */
		public function set throwStep($value:Number):void {
			_throwStep = $value;
		}

		public function set throwTimerDelay($value:Number):void {
			_throwTimerDelay = $value;
		}

		public function get tester():Perspective3DEngineTester {
			return _tester;
		}

		public function get phisics():Phisics {
			return _phisics;
		}

		public function get limits2D():Rectangle {
			return _2DLimits;
		}

		public function set limits2D($limits:Rectangle):void {
			_2DLimits = $limits;
			dispatchEvent(new Event(ON_2D_LIMITS_SETTED));
		}

		public function get cameraPosition():Point3D {
			return _cameraPos;
		}

		public function set cameraPosition($position:Point3D):void {
			_cameraPos = $position;
			_depthFactor = (_screenBack.width - $position.z) / _screenBack.width;
			setScreenPosition();
			dispatchEvent(new Event(ON_CAMERA_POSITION_SETTED));
		}

		public function get screenBack():Rectangle {
			return _screenBack;
		}

		public function get screen():Rectangle {
			return _screen;
		}

		/** Constructor */
 		public function Perspective3DEngine($screenSize:Rectangle) {
			_initSize = new Rectangle($screenSize.x, $screenSize.y, $screenSize.width, $screenSize.height);
			_screenBack = new Rectangle($screenSize.x, $screenSize.y, $screenSize.width, $screenSize.height);
			_screen = new Rectangle($screenSize.x, $screenSize.y, $screenSize.width, $screenSize.height);
			_phisics = new Phisics();
			//_timers = new Array();
		}

		/**
		*	Funcion que realiza el posicionamiento de un objeto en una simulación 3D, de acuerdo
		*	a la cordenada dada, y además de su escala, la cual cree o decrese de acuerdo a los
		*	parametros y al scaleFactor
		*/
		public function setPosition($target:DisplayObject, $position:Point3D):void {
			var position3D:Point3D = getPointProjection($position);
			$target.x = position3D.x;
			$target.y = position3D.y;
			$target.scaleX = $target.scaleY = $target.scaleX * position3D.scaleFactor;
		}

		/**
		*	Funcion que regresa el punto en la pantalla en donde se situa el punto3D dado.
		*/

		public function getPointProjection($point:Point3D):Point3D {
			var factY:Number = (_screen.bottom - _screenBack.bottom) / (_cameraPos.z / $point.y);
			var Yintercect:ComplexPoint = _yAxis.getPointAtY(_screenBack.bottom + factY);
			var YintercectBis:ComplexPoint = _yAxisBis.getPointAtY(Yintercect.y);
			var factor:Number = (YintercectBis.x - Yintercect.x) / _initSize.width;
			var factX:Number = (YintercectBis.x - Yintercect.x) / (_initSize.width / $point.x);
			var XYintercect:ComplexPoint = Yintercect.clonePoint().sum(new ComplexPoint(factX, 0));
			var XYintercectBis:ComplexPoint = Yintercect.clonePoint().sum(new ComplexPoint(factX, 0));
			var finalPoint:ComplexPoint = XYintercect.clonePoint().sum(new ComplexPoint(0, ($point.z * factor * -1)));

/**
//Descomentar en caso de que se quiera ver los puntos calculados en pantalla
			_tester.drawPoint(Yintercect, 0xFF0000);
			_tester.drawPoint(YintercectBis, 0xFF0000);
			_tester.drawPoint(XYintercect, 0x0FF000);
*/
/**Descomentar en caso de que se requiera ver el punto calculado graficamente
*/

//			if($point.z < 0) {
//				_tester.drawPoint(finalPoint, 0xFF0000);
//			} else {
//				_tester.drawPoint(finalPoint);
//			}

			return new Point3D(finalPoint.x, finalPoint.y, 0, factor);
		}
		/**
		*	Funcion que regresa el punto 3D con altura 0 de un punto xy.
		*/

		public function get3DPoint($2DPoint:ComplexPoint):Point3D {
			//_tester.drawPoint($2DPoint, 0xFF0000);
			var yIntercect:ComplexPoint = _yAxis.getPointAtY($2DPoint.y);
			var yIntercectBis:ComplexPoint = _yAxisBis.getPointAtY($2DPoint.y);
			//_tester.drawPoint(yIntercect, 0xFFFF00);
			//_tester.drawPoint(yIntercectBis, 0xFFFF00);
			var y3D:Number = ((yIntercect.y - _screenBack.bottom) * _cameraPos.z) / (_screen.bottom - _screenBack.bottom);
			var x3D:Number = (($2DPoint.x - yIntercect.x) * _initSize.width) / (yIntercectBis.x - yIntercect.x);
			//trace((_screen.bottom - _screenBack.bottom) + " ::: " + _screen.bottom  + " ::: " + yIntercect.y + " ::: " + x3D);
			return new Point3D(x3D, y3D);
		}
		/**
		*	Función para activar el modo de pruebas se tiene que pasar un container para
			poder dibujar todos los elementos.
		*/

		public function setTestingMode($testContainer:Sprite):void {
			_tester = new Perspective3DEngineTester(this);
			_tester.container = $testContainer;
			addEventListener(ON_2D_LIMITS_SETTED, _tester.on2DLimitsSetted);
			addEventListener(ON_CAMERA_POSITION_SETTED, _tester.onCameraPositionSetted);
			addEventListener(ON_ENGINE_INIT, _tester.drawInitState);
			dispatchEvent(new Event(ON_ENGINE_INIT));
		}

		/**
		*	Función que sirve para iniciar un movimiento dinamico atraves de este engine
		*   al terminar el movimiento de acuerdo a los parametros dados tirará un evento
		*	ELEMENT_THROW;
		
		@parameters
		$element: Objeto que tendra movimiento
		$movement: Movimiento que tendrá el objeto, en algún momento se puede utilizar
					una interfaz para hacer mas versatil este engine
		$stopAt: 	Valor en el cual se termina el movimiento, para el caso del Movimiento Parabolico,
					por default, termina al Z ser cero, o al llegar a lo que sería el suelo;
						//Pienso que si se realiza la interfaz de movimientos, sería bueno que este
						//valor debería estar dentro de esa interfaz.
						//Nota este valor sólo es valido para una velocidadVertical es negativa,
						//dicho de otra manera cuando el objeto tirado va cayendo.
		*/

		public function throwElement($element:DisplayObject, $movement:ParabolicMovement, $stopAt:Number = 0):void {
			_parabolicMovement = $movement;
			_stopAt = $stopAt;
			var timer:Timer = new Timer(_throwTimerDelay, 50000);
//			_timers.push(timer);
			timer.addEventListener(TimerEvent.TIMER, onElementThrowTimer);
			_elementThrow = $element;
			timer.start();
		}

		public function destroy():void {
			// Añadir el removeAllListeners();
			_parabolicMovement = null;
			_elementThrow = null;
			_tester = null;
		}

		/**
		*	Función que realiza el movimiento del objeto, de acuerdo al tiempo establecido.
		t = _throwStep * _throwTimerDelay * timer.currentCount;
		
		*/
		protected function onElementThrowTimer($event:Event):void {
			var timer:Timer = $event.target as Timer;
			if(_parabolicMovement == null) {
				timer.stop();
				return;
			}
			var timeFactor:Number = _throwStep * _throwTimerDelay * timer.currentCount;
			var pos3D:Point3D = _parabolicMovement.getStep(timeFactor);
			var pos2D:Point3D = getPointProjection(pos3D);
			_elementThrow.x = pos2D.x;
			_elementThrow.y = pos2D.y;
			_elementThrow.scaleX = _elementThrow.scaleY = pos2D.scaleFactor;
			if(pos3D.z < _stopAt && _parabolicMovement.getVerticalSpeedAt(timeFactor) < 0) {
				timer.stop();
				dispatchEvent(new Event(ELEMENT_THROW));
			}
		}

		/**
		*	Función que settea todos los parametros para la simulación 3D de acuerdo a la
			posición de la camara.
		*/

		protected function setScreenPosition():void {
			_screenBack.width = _initSize.width * _depthFactor;
			_screenBack.height = _initSize.height * _depthFactor;
			_screenBack.x = (_initSize.width / 2) - (_cameraPos.x * _depthFactor);
			_screenBack.y = ((_initSize.height / 2) + (_cameraPos.y * _depthFactor)) - _screenBack.height;
			_screen.x = (_initSize.width / 2) - (_cameraPos.x);
			_screen.y = (_initSize.height / 2) + _cameraPos.y - _screen.height;
			setYAxis();
		}

		/**
		*	Settea valores iniciales.
		*/
		protected function setYAxis():void {
			_yAxis = new Line();
			_yAxisBis = new Line();
			_yAxis.setLineValues(new ComplexPoint(_screenBack.left, _screenBack.bottom), new ComplexPoint(_screen.x, _screen.y + _screen.height));
			_yAxisBis.setLineValues(new ComplexPoint(_screenBack.right, _screenBack.bottom), new ComplexPoint(_screen.x + _screen.width, _screen.y + _screen.height));
		}
	}
}