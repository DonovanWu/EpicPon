package  
{
	import org.flixel.*;
	
	public class PonGame extends FlxState
	{
		public const WID:Number = 480;
		public const HEI:Number = 480;
		
		public const MV_SPD:Number = 5;
		public var ct_wait:Number = 0;
		public var gameover:Boolean = false;
		
		public var player1:FlxSprite = new FlxSprite();
		public var player2:FlxSprite = new FlxSprite();
		
		public static var score1:int = 0;
		public static var score2:int = 0;
		public var sc1:FlxText;
		public var sc2:FlxText;
		
		public var balls:FlxGroup = new FlxGroup();
		
		public override function create():void {
			super.create();
			
			player1.loadGraphic(Resource.IMPORT_RACKET);
			player1.x = 60 - player1.width;
			player1.y = (HEI - player1.height) / 2;
			this.add(player1);
			
			player2.loadGraphic(Resource.IMPORT_RACKET);
			player2.x = WID - 60;
			player2.y = (HEI - player1.height) / 2;
			this.add(player2);
			
			var ball:Ball = new Ball(player1.x + player1.width,
									 player1.y + player1.height / 2,
									 random_float(3, 5),
									 random_float( -4, 4));
			balls.add(ball);
			this.add(balls);
			
			sc1 = new FlxText(player1.x, 20, 64, score1 + "");
			sc1.size = 20;
			this.add(sc1);
			sc2 = new FlxText(player2.x - 16, 20, 64, score2 + "");
			sc2.size = 20;
			this.add(sc2);
		}
		
		public override function update():void {
			super.update();
			
			if (!gameover) {
				update_control();
				update_balls();
				
				FlxG.collide(player1, balls, function(player:FlxSprite, ball:Ball) {
					ball.bounceX();
					FlxG.camera.shake(0.02);
				});
				
				FlxG.collide(player2, balls, function(player:FlxSprite, ball:Ball) {
					ball.bounceX();
					FlxG.camera.shake(0.02);
				});
			} else {	// gameover
				if (ct_wait == 0) {
					FlxG.camera.shake();
					FlxG.flash();
				} else if (ct_wait >= 120) {
					FlxG.switchState(new PonGame());
				}
				ct_wait++;
			}
		}
		
		private function update_control():void {
			// player 1 control
			if (FlxG.keys.pressed("W")) {
				player1.y -= MV_SPD;
				if (player1.y < 0) {
					player1.y = 0;
				}
			} else if (FlxG.keys.pressed("S")) {
				player1.y += MV_SPD;
				if (player1.y > HEI - player1.height) {
					player1.y = HEI - player1.height;
				}
			}
			
			// player 2 control
			if (FlxG.keys.pressed("UP")) {
				player2.y -= MV_SPD;
				if (player2.y < 0) {
					player2.y = 0;
				}
			} else if (FlxG.keys.pressed("DOWN")) {
				player2.y += MV_SPD;
				if (player2.y > HEI - player2.height) {
					player2.y = HEI - player2.height;
				}
			}
		}
		
		private function update_balls():void {
			for (var i = 0; i < balls.members.length; i++ ) {
				var ball:Ball = balls.members[i];
				ball.update_position(this);
				
				// gameover handling
				if (ball.x < -ball.width) {
					gameover = true;
					trace("Player2 wins!");
					score2++;
				} else if (ball.x > WID) {
					gameover = true;
					trace("Player1 wins!");
					score1++;
				}
			}
		}
		
		private function random_float(min:Number, max:Number):Number {
			return Math.random() * (max - min) + min;
		}
	}

}