package net.etnia.engine3d.projection2d.geom.engines.phisics {
	import net.etnia.engine3d.projection2d.geom.Point3D;

	/**
	 * Simula en tiro parabolico, de acuerdo a los valores dados.
	 * @example 
	 * 
			var parabolicMov:ParabolicMovement = engine3D.phisics.getParabolicMovement();
			parabolicMov.init3DMovementBetween(new Point3D(100, 0, 0), new Point3D(600, 400, 0), 60);

			for(var i:Number = 0; i < 20;) {
				var iPoint:Point3D = parabolicMov.getStep(i);
				engine3D.get2DPoint(iPoint);
				i += .2;
			}
	 * 
	 * @author Simkin
	 * 
	 */
	public class ParabolicMovement {

		//Gravedad
		protected var _g:Number = 9.81;
		//Punto inicial para el TP(Tiro Parabolico)
		protected var _initialPoint:Point3D;
		//Velocidad inicial
		protected var _speed:Number;
		//Angulo vertical
		protected var _O:Number;
		//Angulo horizontal
		protected var _B:Number;
		//Factores
		protected var _xyVFact:Number;
		protected var _xHFact:Number;
		protected var _yHFact:Number;
		protected var _zVFact:Number;
		//Velocidad horizontal
		protected var _VoH:Number;
		//Velocidad en X
		protected var _VoX:Number;
		//Velocidad en Y
		protected var _VoY:Number;
		//Velocidad en Z
		protected var _VoZ:Number;
		//Tiempo para alcanzar altura maxima
		protected var _tMaxZ:Number;
		//Altura maxima
		protected var _zMax:Number;
		//Tiempo total
		protected var _tTotal:Number;
		//Maxima distancia horizontal
		protected var _maxHDistance:Number;
		//Valor de la mitad de la gravedad
		protected var _halfG:Number;

		/*Setters*/
		public function set gravity($value:Number):void {
			_g = $value;
			_halfG = _g / 2;
		}

		/*Constructor*/
		public function ParabolicMovement() {
			_halfG = _g / 2;
		}

		/*
			Función para settear los valores iniciales para el TP
			de acuerdo a una posición inicial, Vo, AnguloVertical
			y AnguloHorizontal.
			El anguloVertical tiene un rango de 1 a 89;
		*/
		public function init3DMovement($pos0:Point3D, $speed:Number, $verticalAngle:Number, $horizontalAngle:Number):void {
			_initialPoint = $pos0;
			_speed = $speed;
			//Angulo teta
			_O = $verticalAngle;
			//Angulo beta
			_B = $horizontalAngle;
			//Factores
			_xyVFact = Math.cos(degToRad(_O));
			_xHFact = Math.cos(degToRad(_B));
			_yHFact = Math.sin(degToRad(_B));
			_zVFact = Math.sin(degToRad(_O));
			//Velocidad horizontal
			_VoH = _speed * _xyVFact;
			//Velocidad en X
			_VoX = _VoH * _xHFact;
			//Velocidad en Y
			_VoY = _VoH * _yHFact;
			//Velocidad en Z
			_VoZ = _speed * _zVFact;
			//Tiempo para alcanzar altura maxima
			_tMaxZ = getTMaxZ();
			//Altura maxima
			_zMax = getZMax();
			//Tiempo total
			_tTotal = _tMaxZ * 2;
			//Maxima distancia horizontal
			_maxHDistance = getMaxDistanceH();
		}

		/*
			Función para settear los valores iniciales para el TP
			de acuerdo a dos posiciones a una posición inicial y
			donde se desee terminar el TP, ademas de un anguloV
			El anguloVertical tiene un rango de 1 a 89;
		*/
		public function init3DMovementBetween($posI:Point3D, $posF:Point3D, $verticalAngle:Number):void {
			//Calculo de angulo teta1, para los casos en los que se tiene altura se le tiene que restar al angulo vertical dado.
			//Nota sólo se hacen calculos para puntos que esta
			var distanceXYZ:Number = $posI.getDistance($posF);
//			var distanceXY:Number = $posI.getDistance(new Point3D($posF.x, $posF.y, $posI.z));
//			var angleO1:Number = (new EtniaPoint(0, 0)).getAngle(new EtniaPoint(distanceXY, $posF.z - $posI.z));
			//Calculo Velocidad inicial
			var dG:Number = distanceXYZ * _g;
			var dGSenO:Number = dG / Math.sin(2 * $verticalAngle * Math.PI / 180);
			var v0:Number = Math.sqrt(Math.abs(dGSenO));
			//Calculo Angulo entre dos puntos.
			var horizontalAngle:Number = $posI.get2DPoint().getAngle($posF.get2DPoint());
			init3DMovement($posI, v0, $verticalAngle, horizontalAngle);
		}

		/*
			Función para obtener un punto del movimiento en el
			momento $t.
		*/
		public function getStep($t:Number):Point3D {
			var x:Number = _initialPoint.x + (_VoX * $t);
			var y:Number = _initialPoint.y + (_VoY * $t);
			var z:Number = _initialPoint.z + (_VoZ * $t) - (_halfG * Math.pow($t, 2));
			return new Point3D(x, y, z);
		}

		/*
			Función para obtener la velocidad vertical en el momento $t;
		*/

		public function getVerticalSpeedAt($t:Number):Number {
			return (-_g * $t) + _VoZ;
		}


		/*
			Función para obtener el tiempo que tarda el movimiento
			en llegar a la altura maxima
		*/
		protected function getTMaxZ():Number {
			return -_VoZ / _g;
		}

		/*
			Función para obtener la altura maxima
		*/
		protected function getZMax():Number {
			return (_VoZ * _tMaxZ) + ((_g * Math.pow(_tMaxZ, 2)) / 2);
		}

		/*
			Función para obtener el alcance del TP
		*/
		protected function getMaxDistanceH():Number {
			return _VoH * _tTotal;
		}

		protected function degToRad($degree:Number):Number {
			return $degree * Math.PI / 180;
		}
/*
		protected function radToDeg($rad:Number):Number {
			
		}
*/
	}
}