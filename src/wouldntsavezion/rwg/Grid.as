package wouldntsavezion.rwg {
	import flash.display3D.IndexBuffer3D;
	import wouldntsavezion.rtp.Vector2;
	public class Grid {
		private var nodes:Vector.<GridNode> = null;
		
		public var width:uint = 0;
		public var height:uint = 0;
		public var room_sizes:Array = null;
		public var rooms:Vector.<GridRoom> = null;
		
		public function Grid(_settings:Object) {
			width = 		_settings.GRID_WIDTH;
			height = 		_settings.GRID_HEIGHT;
			room_sizes = 	_settings.ROOM_SIZES;
			
			nodes = new Vector.<GridNode>();
			initNodes();
			processRooms();
		}
		
		private function initNodes():void {
			for (var i:uint = 0; i < height; i++){
				for (var j:uint = 0; j < width; j++){
					var position:Vector2 = new Vector2(j, i);
					nodes.push(new GridNode(this, position));
				}
			}
			for (i = 0; i < nodes.length; i++){
				nodes[i].computeNeighbors();
			}
		}
		
		private function processRooms():void {
			rooms = new Vector.<GridRoom>;
			var node:GridNode = getNodeFromIndex(Math.floor(Math.random() * getNodeAmount()));
			var room:GridRoom = nodeToRoom(node);
			room.closeNodes();
			rooms.push(room);
			var open_nodes:Vector.<GridNode> = getNeighboringOpenNodes(rooms);
			while (open_nodes.length){
				node = open_nodes[Math.floor(Math.random() * open_nodes.length)];
				room = nodeToRoom(node);
				room.closeNodes();
				rooms.push(room);
				open_nodes = getNeighboringOpenNodes(rooms);
			}
		}
		
		private function getNeighboringOpenNodes(_rooms:Vector.<GridRoom>):Vector.<GridNode>{
			var neighboringOpenNodes:Vector.<GridNode> = new Vector.<GridNode>;
			for (var i:uint = 0; i < _rooms.length; i++) {
				var open_nodes:Vector.<GridNode> = _rooms[i].getNeighboringOpenNodes();
				for (var j:uint = 0; j < open_nodes.length; j++) {
					if (neighboringOpenNodes.indexOf(open_nodes[j]) == -1) neighboringOpenNodes.push(open_nodes[j]);
				}
			}
			return neighboringOpenNodes;
		}
		
		private function nodeToRoom(_node:GridNode):GridRoom {
			var possible_rooms:Vector.<GridRoom> = new Vector.<GridRoom>;
			for (var i:uint = 0; i < room_sizes.length; i++){
				var room_vector:Vector2 = new Vector2(room_sizes[i][0], room_sizes[i][1]);
				var j:uint = 4;
				do {
					var x:int = room_vector.x > 0 ? _node.getX() : _node.getX() + room_vector.x;
					var y:int = room_vector.y > 0 ? _node.getY() : _node.getY() + room_vector.y;
					var out_of_bounds:Boolean = false;
					if (x < 0) out_of_bounds = true;
					if (y < 0) out_of_bounds = true;
					if (x + Math.abs(room_vector.x) > width) out_of_bounds = true;
					if (y + Math.abs(room_vector.y) > height) out_of_bounds = true;
					if(!out_of_bounds) {
						var room:GridRoom = new GridRoom(this, new Vector2(x, y), new Vector2(Math.abs(room_vector.x), Math.abs(room_vector.y)));
						if (room.checkPossible()) possible_rooms.push(room);
					}
					room_vector.rotate90cw();
				} while (j--);
			}
			return possible_rooms[Math.floor(Math.random() * possible_rooms.length)];
		}
		
		public function getNodeFromIndex(_index:uint):GridNode {
			return nodes[_index];
		}
		
		public function getNodeFromPosition(_position:Vector2):GridNode {
			var index:uint = _position.x + width * _position.y;
			if (index < 0 || index >= width * height) return null;
			return nodes[index];
		}
		
		public function getNodeAmount():uint {
			return nodes.length;
		}
	}
}