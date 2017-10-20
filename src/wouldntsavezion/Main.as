package wouldntsavezion {
	import flash.display.Sprite;
	import starling.core.Starling;
	import wouldntsavezion.rwg.GridMaker;
	
	[SWF(width = "768", height = "768", frameRate = "60", backgroundColor = "#000000")]
	
	public class Main extends Sprite {
		private var starling:Starling;
		
		public function Main() {
			starling = new Starling(GridMaker, stage);
            starling.start();
		}
	}
}