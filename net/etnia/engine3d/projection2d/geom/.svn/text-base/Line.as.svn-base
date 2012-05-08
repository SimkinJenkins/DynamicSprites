package net.etnia.engine3d.projection2d.geom {
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;
	import net.etnia.utils.MathUtils;


	
	/**
	 * Clase que guarda los valores de una linea en un plano xy
	 * 
	 * @example 
	 * 
			_yAxis = new Line();
			_yAxis.setLineValues(new ComplexPoint(_screenBack.left, _screenBack.bottom), new ComplexPoint(_screen.x, _screen.y + _screen.height));
	 * 
	 * @author Simkin
	 * 
	 */

	public class Line {

		//Pendiente de la linea o recta
		protected var _slope:Number;
		//Punto en el que se intercepta con el ejeY
		protected var _yIntercept:Number;
		//Angulo de la recta con respecto al ejeX
		protected var _O:Number;

		/** Getters y Setters */
		public function get slope():Number {
			return _slope;
		}

		public function get yIntercept():Number {
			return _yIntercept;
		}

		public function get O():Number {
			return _O;
		}

		/** Constructor
		*
		*	Los valores iniciales pueden ser inicializados directamente
		*	o mediante setLineValues(), proporcionando dos puntos de la
			linea
		*/
		public function Line($slope:Number = 0, $yIntercept:Number = 0) {
			_slope = $slope;
			_yIntercept = $yIntercept;
			if($slope != 0) {
				_O = getO();
			}
		}

		public function setLineAngle($angle:Number):void {
			var origin:ComplexPoint = new ComplexPoint();
			_O = MathUtils.degreesToRadians($angle);
			setLineValues(origin, getPolarCoordinateFrom(origin, 50));
//			_O = MathUtils.degreesToRadians($angle);
//			
		}

		/** 
 		*	Función para inicializar los valores de la recta proporcionando dos puntos
 		 * que sean parte de la recta
		*/
		public function setLineValues($a:ComplexPoint, $b:ComplexPoint):void {
			_slope = getSlope($a, $b);
			_yIntercept = getYIntercept($a, _slope);
			_O = getO();
		}

		/** 
 		*	Función que sirve para obtener un punto medio entre los dos puntos dados
 		 * de la recta 
 		 * 
 		 * @parameters:
 		 * 
 		 * $a: Punto A del segmento que debe pertenecer a la recta
 		 * $a: Punto B del segmento que debe pertenecer a la recta
 		 * $step: Porcetaje de la distancia entre los puntos, debe
 		 * 			estar entre 0 y 1.
 		 * 		  Donde 0 el valor regresado será igual a $a y 1
 		 * 			a $b, y .5 el punto medio entre estos puntos.
		*/

		public function getPointFromSegment($a:ComplexPoint, $b:ComplexPoint, $step:Number):ComplexPoint {
			var deltaX:Number = $b.x - $a.x;
			var x1:Number = $a.x + (deltaX * $step);
			return getPointAtX(x1);
		}

		/** 
 		*	Función que sirve para simular un movimiento polar de un punto a otro
 		 * 
 		 * @parameters:
 		 * $origin: Punto perteneciente a la recta que sirve como origen para el movimiento polar.
 		 * $r:		Distancia que hay entre el punto dado $origin y el punto a regresar.
 		 * 
		*/

		public function getPolarCoordinateFrom($origin:ComplexPoint, $r:Number):ComplexPoint {
			var x:Number = $origin.x + ($r * Math.cos(_O));
			var y:Number = $origin.y + ($r * Math.sin(_O));
			trace(MathUtils.radiansToDegrees(_O));
			return new ComplexPoint(x, y);
		}

		/** 
 		*	Regresa el angulo de la recta con respecto a X
 		 * 
		*/

		protected function getO():Number {
			return Math.atan(_slope);
		}

		/** 
 		*	Regresa la intersección de la recta con el ejeY
 		 * 
		*/
		protected function getYIntercept($point:ComplexPoint, $slope:Number):Number {
			return $point.y - ($slope * $point.x);
		}

		/** 
 		*	Regresa la pendiente de la recta formada por estos dos puntos
 		 * 
		*/
		protected function getSlope($a:ComplexPoint, $b:ComplexPoint):Number {
			return ($b.y - $a.y) / ($b.x - $a.x);
		}

		/** 
 		*	Regresa el punto perteneciente a la recta, para el valor de X dado
 		 * 
		*/
		public function getPointAtX($x:Number):ComplexPoint {
			return new ComplexPoint($x, (_slope * $x) + _yIntercept);
		}

		/** 
 		*	Regresa el punto perteneciente a la recta, para el valor de Y dado
 		 * 
		*/
		public function getPointAtY($y:Number):ComplexPoint {
			return new ComplexPoint(($y - _yIntercept) / _slope, $y);
		}

	}
}