package wouldntsavezion.rwg {
	import starling.display.Quad;
	import starling.display.Sprite;
	import wouldntsavezion.rtp.Vector2;
	public class GridMaker extends Sprite {
		private const DISPLAY_SCALE:uint = 6;
		
		private const DEFAULT_SETTINGS:Object = {
			GRID_WIDTH: 	100,
			GRID_HEIGHT: 	100,
			ROOM_SIZES: 	[
				[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]
			]
		};
		
		private var grid:Grid = null;
		
		public function GridMaker() {
			grid = new Grid(DEFAULT_SETTINGS);
			displayGrid();
		}
		
		private function displayGrid():void{
			var offset:Vector2 = new Vector2((768 - grid.width * DISPLAY_SCALE) / 2, (768 - grid.height * DISPLAY_SCALE) / 2);
			for (var i:uint = 0; i < grid.getNodeAmount(); i++){
				var node:GridNode = grid.getNodeFromIndex(i);
				var quad:Quad = new Quad(DISPLAY_SCALE, DISPLAY_SCALE, Math.random() * 0xFFFFFF);
				quad.x = node.getX() * DISPLAY_SCALE + offset.x;
				quad.y = node.getY() * DISPLAY_SCALE + offset.y;
				addChild(quad);
			}
		}
	}
}