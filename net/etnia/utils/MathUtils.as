package net.etnia.utils {
	import flash.geom.Rectangle;
	
	/**
	 * Contienen funciones estáticas para realizar conversiones matematicas comunes utilizadas frecuentemente en programación.
	 * @author Juan Ramon Gomez (Xquizo)
	 * 
	 */
	public class MathUtils{

		public static function randomRange ($min:Number, $max:Number):Number{
			var randomNum:Number = Math.floor(Math.random() * ($max - $min + 1)) + $min;
    		return randomNum;	
		}

		public static function orDecompress ($param:Number):Array{
			var counter:Number = 1;
			var finalArray:Array = new Array ();
			for (var i:int=0; $param >counter;i++){
				//var valid:Boolean = ($param | counter) == $param;
				var valid:Boolean = orMatch ($param, counter)
				if (valid){
					finalArray.push (counter)
				}
				counter = counter << 1;
			}
			return finalArray;
		}
		public static function orMatch ($composedNumber:int, $searchNumber:int):Boolean{
			return ($composedNumber | $searchNumber) == $composedNumber
		}
		/**
		 * Transforma grados a radianes.
		 * @param $degrees
		 * @return 
		 * 
		 */
		public static function degreesToRadians($degrees:Number):Number{
			//1 degreee = 0.0174532925 radian
			//1 radian = 57.2957795 degree
			var radians:Number = $degrees *Math.PI /180;
			return radians;
		}	
		/**
		 * Transforma radianes a grados.
		 * @param $radians
		 * @return 
		 * 
		 */
		public static function  radiansToDegrees($radians:Number):Number{
			//1 degreee = 0.0174532925 radian
			//1 radian = 57.2957795 degree
			var degrees:Number = $radians * 180/Math.PI
			return degrees;
		}
		/**
		 * Transforma un valor de color de forma RGB a HSV. Conversion necesaria cuando se quiere aplicar un cambio
		 * de color a traves de la clase flash.geom.ColorTransform
		 * 
		 * @param $rgb Valor del color a convertir, puede ser de tipo hexadecimal (0xRRGGBB) o un numero entero.
		 * @return Array con los valores del color en formato HSV. Donde array[0] = red multiplier, array[1] = green multiplier
		 * y array[2] = blue multiplier
		 * 
		 */
		public static function colorRGBToHSV($rgb:uint):Array
		{
			var hsvColor:Array = new Array();
			var hexValue:String = $rgb.toString(16);
			var appendIndex:uint = 6 - hexValue.length
			for(var i:uint = 0; i < appendIndex; i++)
			{
				hexValue = "0" + hexValue;
			}
			////trace("r",hexValue.substr(0,2))
			////trace("g",hexValue.substr(2,2))
			////trace("b",hexValue.substr(4,2))
			var redMultiplier:Number = (parseInt("0x"+hexValue.substr(0,2)))/255;
			var greenMultiplier:Number = (parseInt("0x"+hexValue.substr(2,2)))/255;
			var blueMultiplier:Number = (parseInt("0x"+hexValue.substr(4,2)))/255;
			hsvColor.push(redMultiplier, greenMultiplier, blueMultiplier);
			return hsvColor;
		}
		
		/**
		 * Transforma un valor de color de forma HSV a RGB.
		 * 
		 * @param $hsv Arreglo con los valores de color, array[0] = redMultiplier, array[1] = greenMultiplier,
		 * array[2] =  blueMultiplier.
		 * @return Numero entero del valor del color en formato RGB.
		 * 
		 */
		public static function colorHSVToRGB($hsv:Array):uint
		{
			var rgbColor:uint;
			var redMultiplier:uint = $hsv[0] * 255;
			var greenMultiplier:uint = $hsv[1] * 255;
			var blueMultiplier:uint = $hsv[2] * 255;
			var redColor:String = twoDigits(redMultiplier.toString(16));
			var greenColor:String = twoDigits(greenMultiplier.toString(16));
			var blueColor:String = twoDigits(blueMultiplier.toString(16));
			rgbColor = parseInt("0x" + redColor + greenColor + blueColor);
			return rgbColor;
		}
		protected static function twoDigits($value:String):String
		{
			if($value.length < 2)
			{
				$value = "0"+$value
			}
			return $value;
		}
		
		public static function colorSaturation($value:uint):int
		{
			var saturation:int = $value - 250;
			return saturation;
		}
		
		public static function uintToHexString($number:uint):String
		{
			var hex:String = $number.toString(16);
			var zeroMissing:uint = 6 - hex.length;
			for(var i:uint = 0; i < zeroMissing; i++)
			{
				hex = "0" + hex;
			}
			hex = "0x" + hex;
			return hex;
		}
		
		public static function hexToUint($hex:String):uint
		{
			var number:uint = parseInt($hex, 16);
			return number;
		}
		
		public static function getTranspolateBetweenRanges ($currentValueOfRange1:Number, $range1Init:Number, $range1End:Number, $range2Init:Number, $range2End:Number):Number{
			return $range2End - ( ($range1End-$currentValueOfRange1)*($range2End-$range2Init)  ) / ($range1End-$range1Init) ;  
		}	

		public static function hitTest($a:Rectangle, $b:Rectangle):Boolean {
			if(MathUtils.isValueBetween($a.x, $b.left, $b.right) || MathUtils.isValueBetween($a.right, $b.left, $b.right) ||
					$a.left == $b.left && $a.right == $b.right) {
				trace("Si esta entre Xs");
				trace($a + " ::: " + $b);
				if(MathUtils.isValueBetween($a.y, $b.top, $b.bottom) || MathUtils.isValueBetween($a.bottom, $b.top, $b.bottom) ||
						$a.bottom == $b.top && $a.bottom == $b.bottom) {
					trace("Si esta entre Ys");
					return true;
				}
			}
			return false;
		}

		public static function isValueBetween($value:Number, $a:Number, $b:Number):Boolean {
			if($value > $a && $value < $b) {
				return true;
			}
			return false;
		}

	}
}