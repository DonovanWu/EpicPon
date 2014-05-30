package  
{
	import org.flixel.FlxSprite;
	
	public class Ball extends FlxSprite
	{
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public function Ball(x:Number = 0, y:Number = 0, vx:Number = 0, vy:Number = 0) {
			this.vx = vx;
			this.vy = vy;
			
			this.loadGraphic(Resource.IMPORT_BALL);
			this.x = x;
			this.y = y;
		}
		
		public function update_position(game:PonGame):void {
			this.x += vx;
			this.y += vy;
			
			if (this.y < 0) {
				this.y = 0;
				bounceY();
			} else if (this.y > game.HEI - this.height) {
				this.y = game.HEI - this.height;
				bounceY();
			}
		}
		
		public function bounceX():void {
			vx = -vx;
		}
		
		public function bounceY():void {
			vy = -vy;
		}
	}

}