package wouldntsavezion.rwg {
	public class Planifier {
		private var grid:Grid = null;
		
		public function Planifier(_grid:Grid) {
			grid = _grid;
		}
		
		public function plan():Vector.<GridRoom> {
			return grid.rooms;
		}
	}
}