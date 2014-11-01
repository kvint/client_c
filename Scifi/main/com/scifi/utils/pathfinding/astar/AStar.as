package com.scifi.utils.pathfinding.astar
{
	import flash.geom.Point;

	public class AStar
	{
		private var
			_openHeap : BinaryHeap,
			_touched : Vector.<AStarNode>,
			_grid : Vector.<Vector.<AStarNode>>,
			tcur : AStarNode,
			currentNode : AStarNode,
			ret : Vector.<AStarNode>,
			neighbors : Vector.<AStarNode>,
			neighbor : AStarNode,
			newG : uint,
			i : uint, j : uint;
			
		
		public function AStar( grid : Vector.<Vector.<AStarNode>> ){
			_touched = new Vector.<AStarNode>(grid.length * grid.length+1, true);
			_grid = grid;
			_openHeap = new BinaryHeap( function(node:AStarNode):Number { return node.f; } );
			
			for each (var row:Vector.<AStarNode> in _grid)
				for each(var node:AStarNode in row) {
					node.neighbors = new Vector.<AStarNode>();
					for each(var neighbor:AStarNode in getNeighbors(_grid, node)) {
						if (neighbor == null)
							break;
						if (!neighbor.isWall)
							node.neighbors.push(neighbor);	// in demo i focus only on query optimization
					}
				}
		}

		/**
		 * 
		 * DEBUG ONLY.
		 */
		public function get evaluatedTiles () : Vector.<AStarNode> {
			return _touched;
		}

		public function path(from:Point, to:Point):Vector.<Point>
		{
			var nodes:Vector.<AStarNode> = search(_grid[from.x][from.y],_grid[to.x][to.y]);
			var pts:Vector.<Point> = new Vector.<Point>(nodes.length, true);

			for(var i:uint = 0; i < nodes.length; ++i)
				pts[i] = nodes[i].position;

			return pts;
		}
		
		public function search( start : AStarNode, end:AStarNode ) : Vector.<AStarNode>
		{
			i = 0;
			tcur = _touched[0];
			while(tcur) {
				tcur.f=0;
				tcur.g=0;
				tcur.h=0;
				tcur.closed = false;
				tcur.visited = false;
				tcur.parent = null;
				tcur.next = null;
				_touched[i] = null;
				
				i++;
				tcur = _touched[i];
			}
			_openHeap.reset();
			i = 0;	// touched count -- lol, imperative programming (optimizer :()
			
			
			_openHeap.push(start);
			
			while( _openHeap.size > 0 ){
				currentNode = _openHeap.pop();
				
				if (currentNode == end) {
					i = 0;
					while (currentNode.parent) {
						currentNode.parent.next = currentNode;
						i++;
						currentNode = currentNode.parent;
					}
					ret = new Vector.<AStarNode>(i+1, true);
					for (j = 0; currentNode; j++) {
						ret[j] = currentNode;
						currentNode = currentNode.next;
					}
					return ret;
				}
				
				currentNode.closed = true;
				_touched[i++] = currentNode;
				
				for each(neighbor in currentNode.neighbors)	{
					if (neighbor.closed)
						continue;
					
					newG = currentNode.g + currentNode.cost;
					
					if ( !neighbor.visited ) {
						
						_touched[i++] = neighbor;
						
						neighbor.visited = true;
						neighbor.parent = currentNode;
						neighbor.g = newG;
						neighbor.h = heuristic(neighbor.position, end.position);
						neighbor.f = newG + neighbor.h;
						_openHeap.push(neighbor);
						
					} else if ( newG < neighbor.g) {
						
						neighbor.parent = currentNode;
						neighbor.g = newG;
						neighbor.f = newG + neighbor.h;
						
						_openHeap.rescoreElement(neighbor);
					}
					
				}
			}
			
			return ret;
		}
		
		
		private function getNeighbors( grid : Vector.<Vector.<AStarNode>> , node : AStarNode) : Vector.<AStarNode> {
			var ret : Vector.<AStarNode> = new Vector.<AStarNode>(8, true),
				x : uint = node.position.x,
				y : uint = node.position.y,
				gridWidth : uint = grid.length,
				gridHeight : uint = grid[x].length,
				id : uint;
			
			if (x > 0) {
				ret[id++] = grid[x - 1][y];
				if (y > 0)
					ret[id++] = grid[x - 1][y - 1];
				if (y < gridHeight - 1)
					ret[id++] = grid[x - 1][y + 1];
			}
			if (x < gridWidth - 1) {
				ret[id++] = grid[x + 1][y];
				if (y > 0)
					ret[id++] = grid[x + 1][y - 1];
				if (y < gridHeight - 1)
					ret[id++] = grid[x + 1][y + 1];
			}
			if (y > 0)
				ret[id++] = grid[x][y - 1];
			if (y < gridHeight - 1)
				ret[id++] = grid[x][y + 1];
			
			return ret;
		}
		
		private function heuristic( pos0 : Point, pos1 : Point ) : uint{
			var d1 : int = pos1.x - pos0.x,
				d2 : int = pos1.y - pos0.y;
			d1 = d1 < 0 ? -d1 : d1;
			d2 = d2 < 0 ? -d2 : d2;
			//diag = d1 < d2 ? d1 : d2;
			//return  Math.SQRT2 * diag + d1 + d2 - 2 * diag;
			return d1 + d2;
		}

		public function getNode(x:int, y:int): AStarNode
		{
			return _grid[x][y];
		}
	}
}