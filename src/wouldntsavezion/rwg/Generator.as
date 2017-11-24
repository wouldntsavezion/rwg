package wouldntsavezion.rwg {
	import starling.display.Sprite;
	import wouldntsavezion.rtp.Vector2;
	import starling.display.Quad;
	import flash.utils.setTimeout;
	
	public class Generator extends Sprite{
		private const DISPLAY_SCALE:uint = 16;
		private const DEFAULT_SETTINGS:Object = {
			GRID_WIDTH: 	32,
			GRID_HEIGHT: 	32,
			ROOM_SIZES: 	[
				[1, 1], [1, 2], [2, 1], [2, 2], [2, 3], [3, 2], [3, 3]
			],
			ROOM_AMOUNT: 100
		};
		
		public function Generator() {
			var grid:Grid = new Grid(DEFAULT_SETTINGS);
			var planifier:Planifier = new Planifier(grid);
			var plan:Vector.<GridRoom> = planifier.plan(DEFAULT_SETTINGS.ROOM_AMOUNT);
			displayRoomsOneByOne(grid, plan);
		}
		
		private function displayNodes(_grid:Grid):void{
			var offset:Vector2 = new Vector2((768 - _grid.width * DISPLAY_SCALE) / 2, (768 - _grid.height * DISPLAY_SCALE) / 2);
			for (var i:uint = 0; i < _grid.getNodeAmount(); i++){
				var node:GridNode = _grid.getNodeFromIndex(i);
				var quad:Quad = new Quad(DISPLAY_SCALE, DISPLAY_SCALE, Math.random() * 0xFFFFFF);
				quad.x = node.getX() * DISPLAY_SCALE + offset.x;
				quad.y = node.getY() * DISPLAY_SCALE + offset.y;
				addChild(quad);
			}
		}
		
		private function displayRooms(_grid:Grid):void {
			for (var i:uint = 0; i < _grid.rooms.length; i++){
				var room:GridRoom = _grid.rooms[i];
				displayRoom(_grid, room);
			}
		}
		
		private function displayRoomsOneByOne(_grid:Grid, _rooms:Vector.<GridRoom>):void {
			var room:GridRoom = _rooms[0];
			displayRoom(_grid, room);
			_rooms.splice(0, 1);
			if(_rooms.length)
				setTimeout(displayRoomsOneByOne, 1, _grid, _rooms);
		}
		
		private function displayRoom(_grid:Grid, _room:GridRoom):void{
			var color:uint = getRandomColor();
			var offset:Vector2 = new Vector2((768 - _grid.width * DISPLAY_SCALE) / 2, (768 - _grid.height * DISPLAY_SCALE) / 2);
			var quad:Quad = new Quad(DISPLAY_SCALE * _room.getWidth(), DISPLAY_SCALE * _room.getHeight(), color);
			quad.x = _room.getX() * DISPLAY_SCALE + offset.x;
			quad.y = _room.getY() * DISPLAY_SCALE + offset.y;
			addChild(quad);
		}
		
		private function getRandomColor():uint{
			var s_max:uint = 64, b_o:uint = 128, b_var:uint = 128;
			var r:uint = Math.min(255, b_o + Math.floor(Math.random() * b_var) - b_var / 2);
			var g:uint = Math.min(255, b_o + Math.floor(Math.random() * b_var) - b_var / 2);
			var b:uint = Math.min(255, b_o + Math.floor(Math.random() * b_var) - b_var / 2);
			r = (g >= r && g >= b) ? r + Math.max(0, g - r - s_max) : (b >= g && b >= r) ? r + Math.max(0, b - r - s_max) : r;
			g = (r >= g && r >= b) ? g + Math.max(0, r - g - s_max) : (b >= g && b >= r) ? g + Math.max(0, b - g - s_max) : g;
			b = (r >= g && r >= b) ? b + Math.max(0, r - b - s_max) : (g >= r && g >= b) ? b + Math.max(0, g - b - s_max) : b;
			return parseInt('0x' + r.toString(16) + g.toString(16) + b.toString(16));
		}
	}
}