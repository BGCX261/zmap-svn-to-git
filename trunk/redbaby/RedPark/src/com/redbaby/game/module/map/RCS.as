/**
* 相对坐标系
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map {
	import flash.geom.Point;

	public class RCS {
		
		private var w:int = 10;
		private var h:int = 10;
		
		public function RCS() {
			
		}
		
		public static function ScreenToPoint(x:Number, y:Number):Point {
			var _p:Point = new Point();
			var _xPoint:int = Math.floor(x / 10);
			var _yPoint:int = Math.floor(y / 10);
			_p.x = _xPoint;
			_p.y = _yPoint;
			return _p;
		}
		
	}
	
}
