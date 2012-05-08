package net.etnia.engine3d.projection2d.geom {

	
	import flash.geom.Point;
	
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;

	/**
	 * Clase que guarda los valores de un punto en el plano xyz
	 * 
	 * @author Simkin
	 */

	public class Point3D extends Point {

		/** Valor del punto en el plano z */
		protected var _z:Number;
		/** Factor de escala para la posición guardada */
		protected var _scaleFactor:Number;

		/** Setters y getters */
		public function get scaleFactor():Number {
			return _scaleFactor;
		}

		public function set scaleFactor($z:Number):void {
			_scaleFactor = $z;
		}

		public function get z():Number {
			return _z;
		}

		public function set z($z:Number):void {
			_z = $z;
		}

		public function Point3D($x:Number=0, $y:Number=0, $z:Number = 0, $scaleFactor:Number = 1) {
			super($x, $y);
			_z = $z;
			_scaleFactor = $scaleFactor;
		}

		/** Regresa la posición del punto en el plano xy */
		public function get2DPoint():ComplexPoint {
			return new ComplexPoint(super.x, super.y);
		}

		/** toString */
		override public function toString():String {
			return super.toString() + "z=" + _z;
		} 

		/** Obtiene la distancia entre este punto y el punto dado */
		public function getDistance($point:Point3D):Number {
			var dX:Number = Math.pow($point.x - this.x, 2);
			var dY:Number = Math.pow($point.y - this.y, 2);
			var dZ:Number = Math.pow($point.z - this.z, 2);
			return Math.sqrt(dX + dY + dZ);
		}

		/** Clona el punto3D */
		public function clone3DPoint():Point3D {
			return new Point3D(this.x, this.y, this.z, this.scaleFactor);
		}

	}
}