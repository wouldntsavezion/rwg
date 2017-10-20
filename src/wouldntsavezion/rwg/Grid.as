package wouldntsavezion.rwg {
	import flash.display3D.IndexBuffer3D;
	import wouldntsavezion.rtp.Vector2;
	public class Grid {
		public var width:uint = 0;
		public var height:uint = 0;
		public var room_sizes:Array = null;
		
		private var nodes:Vector.<GridNode> = null;
		
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
			var node:GridNode = getNodeFromIndex(5000);
			var room_vector:Vector2 = nodeToRoom(node);
			trace(room_vector);
		}
		
		private function nodeToRoom(_node:GridNode):Vector2 {
			var possible_rooms:Array = [];
			for (var i:uint = 0; i < room_sizes.length; i++){
				var room_vector:Vector2 = new Vector2(room_sizes[i][0], room_sizes[i][1]);
				var j:uint = 4;
				do {
					if (testRoom(_node, room_vector)) possible_rooms.push(room_vector.clone());
					room_vector.rotate90cw();
				} while (j--);
			}
			return possible_rooms[Math.floor(Math.random() * possible_rooms.length)];
		}
		
		private function testRoom(_node:GridNode, _roomVector:Vector2):Boolean {
			var i:uint = 0;
			var x:uint = _node.getX();
			var y:uint = _node.getY();
			var width:int = _roomVector.x;
			var height:int = _roomVector.y;
			
			for (i = x; i < x + width; i++){
				if (!getNodeFromPosition(new Vector2(i, y - 1)).isOpen()) return false;
				if (!getNodeFromPosition(new Vector2(i, y + height)).isOpen()) return false;
			}
			
			for (i = y; i < y + height; i++){
				if (!getNodeFromPosition(new Vector2(x + width, i)).isOpen()) return false;
				if (!getNodeFromPosition(new Vector2(x - 1, i)).isOpen()) return false;
			}
			
			return true;
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