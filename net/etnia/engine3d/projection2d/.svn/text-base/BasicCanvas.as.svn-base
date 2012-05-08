package net.etnia.engine3d.projection2d {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.etnia.engine3d.projection2d.display.ComplexGraphics;
	import net.etnia.engine3d.projection2d.geom.Point3D;
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;

	/**
	 * Clase que añade algunas funciones a la clase Sprite.
	 * 
	 * @author Simkin
	 * 
	 */
	public class BasicCanvas extends Sprite {

		/** Limites del sprite */
		protected var _bounds:Rectangle;
		/** Posición en un ambiente 3D
		 * Nota: únicamente lógicamente hablando, no gráficamente
		 */
		protected var _point3D:Point3D;
		/** Graficos complejos */
		protected var _complexGraphics:ComplexGraphics;

		/** Getters y Setters */
		public function get complexGraphics():ComplexGraphics {
			return _complexGraphics;
		}

		public function set pos3D($value:Point3D):void {
			_point3D = $value;
		}

		public function get pos3D():Point3D {
			return _point3D;
		}

		public function set scale($value:Number):void {
			this.scaleX = this.scaleY = $value;
		}

		public function set bounds($value:Rectangle):void {
			if($value == null) {
				$value = new Rectangle();
			}
			_bounds = $value;
		}

		public function get bounds():Rectangle {
			return _bounds;
		}

		/** Constructor */
		public function BasicCanvas($bounds:Rectangle = null) {
			this.bounds = $bounds;
			_complexGraphics = new ComplexGraphics(this);
		}

		/** Setter de tamaño para hacer resize en un sólo paso */
		public function setSize($width:Number, $height:Number):void {
			_bounds.width = $width;
			_bounds.height = $height;
		}

		/** Setter de posición para mover éste en un sólo paso */
		public function move($x:Number, $y:Number):void {
			this.x = $x;
			this.y = $y;
		}

		/** Setter de posición sólo que ahora pasando como parametro un ComplexPoint */
		public function moveTo($point:ComplexPoint):void {
			this.x = $point.x;
			this.y = $point.y;
		}

		/** Settea posición y tamaño */
		public function setBounds($x:Number, $y:Number, $width:Number, $height:Number):void {
			move($x, $y);
			setSize($width, $height);
		}

		/** Destructor */
		public function destroy():void {
//			removeAllEventListeners();
//			removeAllChilds();
		}

		/** Añade un contenedor dentro de este objeto */
		public function addBasicCanvas():BasicCanvas {
			var sprite:BasicCanvas = new BasicCanvas();
			addChild(sprite);
			return sprite;
		}

		/** Hace este objeto drageable dentro de todo el stage*/
		public function setDragable():void {
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		/** Draguea este objeto */
		protected function onMouseDown($event:MouseEvent):void {
			this.startDrag();
		}

		/** Deja de draggear este objeto */
		protected function onMouseUp($event:MouseEvent):void {
			this.stopDrag();
		}

	}
}