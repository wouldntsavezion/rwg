package wouldntsavezion {
	import flash.display.Sprite;
	import starling.core.Starling;
	import wouldntsavezion.rwg.Generator;
	
	[SWF(width = "768", height = "768", frameRate = "60", backgroundColor = "#000000")]
	
	public class Main extends Sprite {
		private var starling:Starling;
		
		public function Main() {
			starling = new Starling(Generator, stage);
			starling.showStats = true;
            starling.start();
		}
	}
}