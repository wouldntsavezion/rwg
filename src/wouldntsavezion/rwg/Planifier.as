package wouldntsavezion.rwg {
	import flash.events.DRMReturnVoucherCompleteEvent;
	import wouldntsavezion.hrd.Pathfinder;
	import wouldntsavezion.hrd.PathfinderNode;
	import wouldntsavezion.rtp.Vector2;
	public class Planifier {
		private var grid:Grid = null;
		
		public function Planifier(_grid:Grid) {
			grid = _grid;
		}
		
		public function plan(_roomAmount:uint):Vector.<GridRoom> {
			var actualAmount:uint = Math.min(_roomAmount, grid.rooms.length);
			calcRoomNeighbors();
			Pathfinder.world = getPathfinderNodes();
			
			var start:PathfinderNode = Pathfinder.world[Math.floor(Math.random() * Pathfinder.world.length)];
			var end:PathfinderNode = null;
			do {
				end = Pathfinder.world[Math.floor(Math.random() * Pathfinder.world.length)];
			} while (start == end);
			
			var path:Array = Pathfinder.FindPath(start, end, true, int.MAX_VALUE);
			
			var path_rooms:Vector.<GridRoom> = spawnMore(getChosenRoomsFromPath(path), _roomAmount);
			
			trace(path_rooms.length);
			
			return path_rooms;
		}
		
		private function spawnMore(_rooms:Vector.<GridRoom>, _roomAmount:uint):Vector.<GridRoom> {
			var more:uint = _roomAmount - _rooms.length;
			for (var i:uint = 0; i < more; i++){
				var random_spawner:GridRoom = _rooms[Math.floor(Math.random() * _rooms.length)];
				var spawner_neighbors:Vector.<GridRoom> = random_spawner.getNeighboringRooms();
				var possible_spawns:Vector.<GridRoom> = new Vector.<GridRoom>();
				for (var j:uint = 0; j < spawner_neighbors.length; j++){
					if (!spawner_neighbors[j].used) possible_spawns.push(spawner_neighbors[j]);
				}
				if(possible_spawns.length){
					var spawn:GridRoom = possible_spawns[Math.floor(Math.random() * possible_spawns.length)];
					spawn.used = true;
					_rooms.push(spawn);
				} else {
					i--;
				}
			}
			
			return _rooms;
		}
		
		private function calcRoomNeighbors():void {
			for (var i:uint = 0; i < grid.rooms.length; i++) {
				grid.rooms[i].pathfinderNode.Children = new Array();
				var rooms:Vector.<GridRoom> = grid.rooms[i].getNeighboringRooms();
				for (var j:uint = 0; j < rooms.length; j++) {
					grid.rooms[i].pathfinderNode.Children.push(rooms[j].pathfinderNode);
				}
			}
		}
		
		private function getPathfinderNodes():Array {
			var pathfinderNodes:Array = new Array();
			for (var i:uint = 0; i < grid.rooms.length; i++) {
				pathfinderNodes.push(grid.rooms[i].pathfinderNode);
			}
			return pathfinderNodes;
		}
		
		private function getChosenRoomsFromPath(_path:Array):Vector.<GridRoom> {
			var rooms:Vector.<GridRoom> = new Vector.<GridRoom>();
			for (var i:uint = 0; i < grid.rooms.length; i++) {
				if (_path.indexOf(grid.rooms[i].pathfinderNode) != -1){
					grid.rooms[i].used = true;
					rooms.push(grid.rooms[i]);
				}
			}
			return rooms;
		}
	}
}