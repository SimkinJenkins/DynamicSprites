package net.etnia.utils {
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;
	import net.etnia.utils.MathUtils;
	

	public class GeomUtils {

		/* a^2 = b^2 + c^2 Obtener a, la hipotenusa */
		static public function getHypotenuse($b:Number, $c:Number):Number {
			return Math.sqrt(Math.pow($b, 2) + Math.pow($c, 2));
		}

		/* a^2 = b^2 + c^2 */
		static public function getPolarCoordinate($init:ComplexPoint, $r:Number, $angle:Number, $useRadians:Boolean = true):ComplexPoint {
			return new ComplexPoint(getPolarX($init.x, $r, $angle, $useRadians), getPolarY($init.y, $r, $angle, $useRadians));
		}

		static public function getPolarX($initX:Number, $r:Number, $angle:Number, $useRadians:Boolean = true):Number {
			if(!$useRadians) {
				$angle = MathUtils.degreesToRadians($angle);
			}
			return $initX + ($r * Math.cos($angle));
		}

		static public function getPolarY($initY:Number, $r:Number, $angle:Number, $useRadians:Boolean = true):Number {
			if(!$useRadians) {
				$angle = MathUtils.degreesToRadians($angle);
			}
			return $initY + ($r * Math.sin($angle));
		}

	}
}