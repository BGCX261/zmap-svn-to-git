package com.redbaby.game.module.map.astar{
	public class MoveDirection {
		public static const LEFT:String = "4";
		public static const BOTTOM_RIGHT:String = "3";
		public static const BOTTOM:String = "2";
		public static const TOP_LEFT:String = "7";
		public static const TOP_RIGHT:String = "9";
		public static const TOP:String = "8";
		public static const BOTTOM_LEFT:String = "1";
		public static const RIGHT:String = "6";
		
		public function MoveDirection():void{
			
		}
		
		public static function compute(x1:Number, y1:Number, x2:Number, y2:Number):String {
			var hd:Number;
			var jd :Number;
			hd = Math.atan2(y2 - y1, x2 - x1);
			jd = hd * 180 / Math.PI;
			if (jd <= -22.5 && jd >= -67.5){
                return MoveDirection.TOP_RIGHT;
            }
            if (jd <= -67.5 && jd >= -112.5){
                return MoveDirection.TOP;
            }
            if (jd <= -112.5 && jd >= -157.5){
                return MoveDirection.TOP_LEFT;
            }
            if (jd <= -157.5 && jd >= -180 || jd <= 180 && jd >= 157.5){
                return MoveDirection.LEFT;
            }
            if (jd <= 157.5 && jd >= 112.5){
                return MoveDirection.BOTTOM_LEFT;
            }
            if (jd <= 112.5 && jd >= 67.5){
                return MoveDirection.BOTTOM;
            }
            if (jd <= 67.5 && jd >= 22.5){
                return MoveDirection.BOTTOM_RIGHT;
            }
            if (jd <= 22.5 && jd >= 0 || jd <= 0 && jd >= -22.5){
                return MoveDirection.RIGHT;
            }
            return "0";
		}
	}
}
