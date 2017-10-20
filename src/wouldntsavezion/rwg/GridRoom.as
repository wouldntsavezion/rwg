package wouldntsavezion.rwg {
	import wouldntsavezion.rtp.Vector2;
	public class GridRoom {
		private var position:Vector2 = null;
		private var size:Vector2 = null;
		private var grid:Grid = null;
		
		public function GridRoom(_grid:Grid, _position:Vector2, _size:Vector2) {
			grid = _grid;
			position = _position;
			size = _size;
		}
		
		public function checkPossible():Boolean {
			for (var i:uint = 0; i < getHeight(); i++) {
				for (var j:uint = 0; j < getWidth(); j++) {
					var node:GridNode = grid.getNodeFromPosition(new Vector2(getX() + j, getY() + i));
					if (!node.isOpen) return false;
				}
			}
			
			return true;
		}
		
		public function closeNodes():void {
			for (var i:uint = 0; i < getHeight(); i++) {
				for (var j:uint = 0; j < getWidth(); j++) {
					var node:GridNode = grid.getNodeFromPosition(new Vector2(getX() + j, getY() + i));
					node.isOpen = false;
				}
			}
		}
		
		public function getNodes():Vector.<GridNode> {
			var nodes:Vector.<GridNode> = new Vector.<GridNode>;
			for (var i:uint = 0; i < getHeight(); i++) {
				for (var j:uint = 0; j < getWidth(); j++) {
					var node:GridNode = grid.getNodeFromPosition(new Vector2(getX() + j, getY() + i));
					nodes.push(node);
				}
			}
			return nodes;
		}
		
		public function getNeighboringNodes():Vector.<GridNode> {
			var i:uint = 0;
			var x:uint = getX();
			var y:uint = getY();
			var width:uint = getWidth();
			var height:uint = getHeight();
			
			var neighbor_nodes:Vector.<GridNode> = new Vector.<GridNode>;
			
			for (i = x; i < x + width; i++){
				var node_top:GridNode = grid.getNodeFromPosition(new Vector2(i, y - 1));
				var node_bottom:GridNode = grid.getNodeFromPosition(new Vector2(i, y + height));
				if (node_top && getY() > 0) neighbor_nodes.push(node_top);
				if (node_bottom && getY() + getHeight() < grid.height) neighbor_nodes.push(node_bottom);
			}
			
			for (i = y; i < y + height; i++){
				var node_right:GridNode = grid.getNodeFromPosition(new Vector2(x + width, i));
				var node_left:GridNode = grid.getNodeFromPosition(new Vector2(x - 1, i));
				if (node_right && getX() + getWidth() < grid.width) neighbor_nodes.push(node_right);
				if (node_left && getX() > 0) neighbor_nodes.push(node_left);
			}
			
			return neighbor_nodes;
		}
		
		public function getX():uint {
			return position.x;
		}
		
		public function getY():uint {
			return position.y;
		}
		
		public function getWidth():uint {
			return size.x;
		}
		
		public function getHeight():uint {
			return size.y;
		}
		
		public function toString():String {
			return 'GridRoom(' + getX() + ', ' + getY() + ', ' + getWidth() + ', ' + getHeight() + ')';
		}
	}
}