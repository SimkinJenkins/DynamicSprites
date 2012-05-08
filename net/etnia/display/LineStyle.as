package net.etnia.display {
	/**
	 * Contiene las propiedades necesarias para encapsular, representar y almacenar y estilo determinado de linea.
	 * @author Juan Ramón Gomez
	 * 
	 */
	public class LineStyle{
		private var _thickness:Number;
		private var _color:uint;
		private var _alpha:Number;
		private var _pixelHinting:Boolean;
		private var _scaleMode:String;
		private var _caps:String;
		private var _joints:String;
		private var _miterLimit:Number;
		//////////////////////////////////////////////////////////////////////////////
		/**
		 *Constructor 
		 * @param $thickness
		 * @param $color
		 * @param $alpha
		 * @param $pixelHinting
		 * @param $scaleMode
		 * @param $caps
		 * @param $joints
		 * @param $miterLimit
		 * 
		 */
		public function LineStyle ($thickness:Number=0,$color:uint=0.0,$alpha:Number=1.0,$pixelHinting:Boolean=false,$scaleMode:String="normal",$caps:String=null,$joints:String=null,$miterLimit:Number = 0){
			this.thickness = $thickness;
			this.color =$color;
			this.alpha =$alpha;
			this.pixelHinting = $pixelHinting;
			this.scaleMode = $scaleMode;
			this.caps = $caps;
			this.joints = $joints;
			this.miterLimit = $miterLimit;
		}
		public function get thickness ():Number{
			return _thickness;
		}
		public function get color ():uint{
			return _color;
		}
		public function get alpha ():Number{
			return _alpha;
		}
		public function get pixelHinting ():Boolean{
			return _pixelHinting;
		}
		public function get scaleMode ():String{
			return _scaleMode; 
		}
		public function get caps ():String{
			return _caps; 
		}
		public function get joints ():String{
			return _joints;
		}
		public function get miterLimit ():Number{
			return _miterLimit; 
		}
		//////////////////////////////////////////////////////////////////////////////
		public function set thickness($thickness:Number):void{
			this._thickness = $thickness;
		}
		public function set color($color:uint):void{
			this._color = $color;
		}
		public function set alpha($alpha:Number):void{
			this._alpha = $alpha;
		}
		public function set pixelHinting($pixelHinting:Boolean):void{
			this._pixelHinting = $pixelHinting;
		}
		public function set scaleMode($scaleMode:String):void{
			this._scaleMode = $scaleMode;
		}
		public function set caps($caps:String):void{
			this._caps = $caps;
		}
		public function set joints($joints:String):void{
			this._joints = $joints;
		}
		public function set miterLimit($miterLimit:Number):void{
			this._miterLimit = $miterLimit;
		}
	}	
	
	
	
	
	
	
	
}