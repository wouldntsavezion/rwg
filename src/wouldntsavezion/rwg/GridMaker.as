package wouldntsavezion.rwg {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import wouldntsavezion.rtp.Vector2;
	import flash.utils.setTimeout;
	public class GridMaker extends Sprite {
		private const DISPLAY_SCALE:uint = 16;
		
		private const DEFAULT_SETTINGS:Object = {
			GRID_WIDTH: 	32,
			GRID_HEIGHT: 	32,
			ROOM_SIZES: 	[
				[2, 3], [3, 3], [5, 5], [2, 6], [3, 3], [3, 4]
			]
		};
		
		private var grid:Grid = null;
		private var nodeSprite:Sprite = null;
		private var roomSprite:Sprite = null;
		
		public function GridMaker() {
			nodeSprite = new Sprite();
			roomSprite = new Sprite();
			
			addChild(nodeSprite);
			addChild(roomSprite);
			
			generateNew();
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function generateNew():void {
			grid = new Grid(DEFAULT_SETTINGS);
			nodeSprite.removeChildren();
			roomSprite.removeChildren();
			//displayNodes();
			displayRooms();
			//displayRoomsOneByOne(grid.rooms);
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
			for (var i:uint = 0; i < grid.rooms.length; i++){
				var room:GridRoom = grid.rooms[i];
				displayRoom(room);
			}
		}
		
		private function displayRoomsOneByOne(_rooms:Vector.<GridRoom>):void {
			var room:GridRoom = _rooms[0];
			displayRoom(room);
			_rooms.splice(0, 1);
			if(_rooms.length)
				setTimeout(displayRoomsOneByOne, 1000, _rooms);
		}
		
		private function displayRoom(_room:GridRoom):void{
			var offset:Vector2 = new Vector2((768 - grid.width * DISPLAY_SCALE) / 2, (768 - grid.height * DISPLAY_SCALE) / 2);
			var quad:Quad = new Quad(DISPLAY_SCALE * _room.getWidth(), DISPLAY_SCALE * _room.getHeight(), Math.random() * 0xFFFFFF);
			quad.x = _room.getX() * DISPLAY_SCALE + offset.x;
			quad.y = _room.getY() * DISPLAY_SCALE + offset.y;
			roomSprite.addChild(quad);
		}
	}
}