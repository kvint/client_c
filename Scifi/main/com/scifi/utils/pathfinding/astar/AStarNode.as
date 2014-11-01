package com.scifi.utils.pathfinding.astar
{
	import flash.geom.Point;
	
	public class AStarNode
	{
		public var	h 		:uint = 0;
		public var	f 		:uint = 0;
		public var	g 		:uint = 0;
		public var	cost	:uint;
		public var	visited	:Boolean = false;
		public var	closed	:Boolean = false;
		public var	isWall	:Boolean;
		public var	position:Point;
		public var	parent	:AStarNode = null;
		public var	next	:AStarNode;
		public var	neighbors:Vector.<AStarNode>;
		
		public function AStarNode(cost:uint = 1)
		{
			this.cost = cost;
		}
	}
}