package 
{
	import org.flixel.FlxGame;
	
	[SWF(backgroundColor = "#000000", frameRate = "60", width = "480", height = "480")]
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame {

		public function Main():void {
			super(480, 480, PonGame);
		}
	}
	
}