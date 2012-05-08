package net.etnia.engine3d.projection2d.display {
	
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import net.etnia.engine3d.projection2d.math3d.ComplexPoint;

	/**
	 * Clase que simplifica el uso de Graphics de Adobe se crea en el BasicCanvas.
	 * 
	 * @author Simkin
	 * 
	 */
	public class ComplexGraphics {

		//Sprite creador del Graphics que se va a simplificar
		protected var _container:Sprite;
		//Variable que permite invertir los valores de los ejes.
		protected var _invertAxis:Boolean = false;

		/* Getter y Setters */
		public function set invertAxis($value:Boolean):void {
			_invertAxis = $value;
		}

		public function get invertAxis():Boolean {
			return _invertAxis;
		}

		public function ComplexGraphics($container:Sprite) {
			_container = $container;
		}

		//Funcion que simplifica el uso de la función drawRect.
		//De esta manera sólo se le pasa el parametro Rectangle.
		/*
		@example
			Para crear un Rectangulo relleno, en la posición 400, 100 de 50x50

			var button:BasicCanvas = new BasicCanvas;
			button.graphics.beginFill(0x000000);
			button.complexGraphics.drawRect(new Rectangle(400, 100, 50, 50));
	
		*/
		public function drawRect($bounds:Rectangle):void {
			if(_invertAxis) {
				_container.graphics.drawRect($bounds.x, -$bounds.y, $bounds.width, $bounds.height);
			} else {
				_container.graphics.drawRect($bounds.x, $bounds.y, $bounds.width, $bounds.height);
			}
		}

		//Funcion que simplifica el uso de la función drawCircle.
		//De esta manera sólo se le pasa el parametro $position y el radio.
		/*
		@example
			Para crear un Circulo relleno, en la posición 400, 100 de 50x50

			var button:BasicCanvas = new BasicCanvas;
			button.graphics.beginFill(0x000000);
			button.complexGraphics.drawRect(new ComplexPoint(400, 100), 50);
	
		*/
		public function drawCircle($position:ComplexPoint, $radius:Number):void {
			if(_invertAxis) {
				_container.graphics.drawCircle($position.x, -$position.y, $radius);
			} else {
				_container.graphics.drawCircle($position.x, $position.y, $radius);
			}
		}

		//Funcion que simplifica el MoveTo.
		//De esta manera se pasa un ComplexPoint en vez de xy por separado.
		public function moveTo($point:ComplexPoint):void {
			if(_invertAxis) {
				_container.graphics.moveTo($point.x, -$point.y);
			} else {
				_container.graphics.moveTo($point.x, $point.y);
			}
		}

		//Funcion que simplifica el lineTo.
		//De esta manera se pasa un ComplexPoint en vez de xy por separado.
		public function lineTo($point:ComplexPoint):void {
			if(_invertAxis) {
				_container.graphics.lineTo($point.x, -$point.y);
			} else {
				_container.graphics.lineTo($point.x, $point.y);
			}
		}

		//Funcion que implementa en un sólo comando el moveTo y lineTo
		//De esta manera se pasan los dos puntos ComplexPoint para dibujar una
		//linea de un punto a otro.
		public function lineFrom($a:ComplexPoint, $b:ComplexPoint):void {
			moveTo($a);
			lineTo($b);
		}

	}
}