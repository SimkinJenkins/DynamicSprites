package net.etnia.display {
	
	import flash.display.Sprite;
	/**
	 * Clase base para encapsular la generación de rectangulos gráficos.
	 * @author jgomez
	 * 
	 */
	internal class GenericBox extends Sprite {
		protected var _fillType:String;
		protected var _boxWidth:Number;
		protected var _boxHeight:Number;
		protected var _radius:Number;
		protected var _color:uint;
		protected var _lineStyle:LineStyle;
		public function get fillType ():String{
			return this._fillType
		}
		public function get boxWidth ():Number{
			return this._boxWidth
		}
		public function get boxHeight ():Number{
			return this._boxHeight
		}
		public function get radius  ():Number{
			return this._radius
		}
		public function get color ():uint{
			return this._color
		}
		public function GenericBox ($boxWidth:Number,$boxHeight:Number, $radius:Number, $color:uint,$lineStyleParams:LineStyle = null){
				this._boxWidth = $boxWidth;
				this._boxHeight = $boxHeight;
				this._radius = $radius;
				this._color = $color;
				this._lineStyle = $lineStyleParams;
				if ($boxWidth == 0 || $boxHeight == 0){
//					throw new GenericBoxError (GenericBoxError.ZEROVALUE);
				}	
				this.beginFill();
				if ($lineStyleParams != null){
					this.graphics.lineStyle($lineStyleParams.thickness,$lineStyleParams.color,$lineStyleParams.alpha,$lineStyleParams.pixelHinting,$lineStyleParams.scaleMode,$lineStyleParams.caps,$lineStyleParams.joints,$lineStyleParams.miterLimit)
				}
				this.drawBox (0,0,$boxWidth,$boxHeight,$radius);
				this.graphics.endFill();
				
		}
		/**
		 * Genera el relleno del rectángulo.
		 * 
		 */
		protected function beginFill ():void{
			this.graphics.beginFill(this._color);
		}
		/**
		 * Genera el rectángulo.
		 * @param $x
		 * @param $y
		 * @param $boxWidth
		 * @param $boxHeight
		 * @param $ellipseWidth
		 * @param $ellipseHeight
		 * 
		 */
		protected function drawBox ($x:Number,$y:Number,$boxWidth:Number,$boxHeight:Number,$ellipseWidth:Number,$ellipseHeight:Number=0):void{
			this.graphics.drawRoundRect ($x,$y,$boxWidth,$boxHeight,$ellipseWidth);	
		}
		
		
	}	
	
	
	
	
	
	
	
}