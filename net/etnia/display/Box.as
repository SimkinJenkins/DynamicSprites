package net.etnia.display {
	/**
	 * Crea una rectángulo gráfico, idéntico al método nativo graphics.drawRoundRect pero  encapsulando el codigo, haciendo la creación  de cajas mas sencilla, y práctica para  los usos mas comunes.
	 * @example Creando una caja naranja:<BR><BR>
	 * var caja1:Box = new Box (150,50,20,0xFF9900);<BR>
	 * this.addChild (caja1)<BR>
	 * @author jgomez
	 * 
	 */
	
	public class Box extends GenericBox {		
		private var _alpha:Number;
		/**
		 * Constructor
		 * @param $boxWidth Ancho en pixeles.
		 * @param $height Alto en pixeles.
		 * @param $radius Curvatura de las esquinas del rectángulo.
		 * @param $color Color hexadecimal de rectángulo.
		 * @param $lineStyle Objeto LineStyle que determina el estilo de la linea.
		 * @return
		 * @see com.arcww.display.LineStyle
		 */
		public function Box ($boxWidth:Number,$height:Number, $radius:Number,$color:uint,$lineStyle:LineStyle = null, $alpha:Number = 1.0){
			this._alpha = $alpha;
			super ($boxWidth,$height, $radius,$color,$lineStyle);
		}
		/**
		 * Determina la forma de llenar la caja. En caso de necesitar un llenado particular puede generarse una subclase y recargar esta función.
		 * 
		 */
		protected override function beginFill ():void{
			this.graphics.beginFill(this._color,this._alpha);
		}

	}	

}
