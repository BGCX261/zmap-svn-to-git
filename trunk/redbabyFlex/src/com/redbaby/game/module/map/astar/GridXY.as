package com.redbaby.game.module.map.astar{
	import flash.geom.Point;
	public class GridXY {
		
		public static var startX:Number = 500;
		public static var height:Number = 31;
		public static var width:Number = 64;
		public static var startY:Number = 0;
		
		public function GridXY():void{
			
		}
		
		public static function gridToScreen(w:int, h:int):Point {
			var p:Point = new Point();;
			p.x = ( -width) * 0.5 * h + width * 0.5 * w;
			p.y = height * 0.5 * h + height * 0.5 * w;
			p.x = p.x + startX;
			p.y = p.y + startY;
			return p;
		}
		
		public static function screenToGrid(w:int, h:int):Point {
			var p:Point;
			w = w - startX;
			h = h - startY;
			p = new Point();
			p.x = (2 * h / height + 2 * w / width) * .5;
			p.y = (2 * h / height - 2 * w / width) * .5;
			p.x = Math.round(p.x);
			p.y = Math.round(p.y);
			return p;
		}
	}
}
