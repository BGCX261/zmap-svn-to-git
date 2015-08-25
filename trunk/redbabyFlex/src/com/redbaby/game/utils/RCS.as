/**
* 相对坐标系
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.utils {
	import flash.geom.Point;

	public class RCS {
		public static function ScreenToPoint(x:Number, y:Number, w:int, h:int):Point {
			var _xPoint:int = Math.floor(x / w);
			var _yPoint:int = Math.floor(y / h);
			return new Point(_xPoint, _yPoint);
		}
		
		public static function PointToScreen(x:Number, y:Number, w:int, h:int):Point {
			var _xPoint:int = Math.floor(x * w);
			var _yPoint:int = Math.floor(y * h);
			return new Point(_xPoint, _yPoint);
		}
	}
	
}
