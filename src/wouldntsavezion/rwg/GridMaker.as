package wouldntsavezion.rwg {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import wouldntsavezion.rtp.Vector2;
	public class GridMaker extends Sprite {
		private const DISPLAY_SCALE:uint = 16;
		
		private const DEFAULT_SETTINGS:Object = {
			GRID_WIDTH: 	20,
			GRID_HEIGHT: 	20,
			ROOM_SIZES: 	[
				[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]
			]
		};
		
		private var grid:Grid = null;
		
		public function GridMaker() {
			generateNew();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function generateNew():void {
			grid = new Grid(DEFAULT_SETTINGS);
			displayNodes();
			displayRooms();
		}
		
		private function onTouch(e:TouchEvent):void{
			var touches:Vector.<Touch> = e.getTouches(this, TouchPhase.ENDED);
			if(touches.length == 0) return;
			generateNew();
		}
		
		private function displayNodes():void{
			var offset:Vector2 = new Vector2((768 - grid.width * DISPLAY_SCALE) / 2, (768 - grid.height * DISPLAY_SCALE) / 2);
			for (var i:uint = 0; i < grid.getNodeAmount(); i++){
				var node:GridNode = grid.getNodeFromIndex(i);
				var quad:Quad = new Quad(DISPLAY_SCALE, DISPLAY_SCALE, Math.random() * 0xFFFFFF);
				quad.x = node.getX() * DISPLAY_SCALE + offset.x;
				quad.y = node.getY() * DISPLAY_SCALE + offset.y;
				addChild(quad);
			}
		}
		
		private function displayRooms():void {
			var offset:Vector2 = new Vector2((768 - grid.width * DISPLAY_SCALE) / 2, (768 - grid.height * DISPLAY_SCALE) / 2);
			for (var i:uint = 0; i < grid.rooms.length; i++){
				var room:GridRoom = grid.rooms[i];
				var quad:Quad = new Quad(DISPLAY_SCALE * room.getWidth(), DISPLAY_SCALE * room.getHeight(), Math.random() * 0xFFFFFF);
				quad.x = room.getX() * DISPLAY_SCALE + offset.x;
				quad.y = room.getY() * DISPLAY_SCALE + offset.y;
				addChild(quad);
			}
		}
	}
}