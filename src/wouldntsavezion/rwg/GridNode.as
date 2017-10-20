package wouldntsavezion.rwg {
	import wouldntsavezion.rtp.Vector2;
	public class GridNode {
		private var grid:Grid = null;
		private var neighbors:Vector.<GridNode> = null;
		private var position:Vector2 = null;
		
		public var isOpen:Boolean = true;
		
		public function GridNode(_grid:Grid, _position:Vector2) {
			grid = _grid;
			position = _position;
		}
		
		public function getX():uint {
			return position.x;
		}
		
		public function getY():uint {
			return position.y;
		}
		
		public function getIndex():uint {
			return getX() + grid.width * getY();
		}
		
		public function getNeighbors():Vector.<GridNode> {
			return neighbors;
		}
		
		public function computeNeighbors():void {
			var possible_neighbors:Array = [];
			
			if (position.y != 0) {
				possible_neighbors.push(grid.getNodeFromPosition(new Vector2(position.x, position.y - 1)));
			}
			
			if (position.x != 0) {
				possible_neighbors.push(grid.getNodeFromPosition(new Vector2(position.x - 1, position.y)));
			}
			
			if (position.x + 1 != grid.width) {
				possible_neighbors.push(grid.getNodeFromPosition(new Vector2(position.x + 1, position.y)));
			}
			
			if (position.y + 1 != grid.height) {
				possible_neighbors.push(grid.getNodeFromPosition(new Vector2(position.x, position.y + 1)));
			}
			
			neighbors = new Vector.<GridNode>(possible_neighbors);
		}
		
		public function toString():String {
			return 'GridNode(' + getX() + ', ' + getY() + ')';
		}
	}
}