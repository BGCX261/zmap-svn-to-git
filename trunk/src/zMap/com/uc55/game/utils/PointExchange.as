package com.uc55.game.utils
{
	import flash.geom.Point;
	import Math;

	public class PointExchange
	{
		private static var TileWidth : int = 80;
		private static var TileHeigth : int = 40;
		public function PointExchange()
		{
			//this Class not allow init!
		}
		
		public static function StageToLogic(stage:Point):Point
		{
			var logic : Point = new Point;
			logic.y = ( 2 * stage.y ) / TileHeigth;
			logic.x = ( stage.x / TileWidth ) - ( logic.y & 1 ) * ( TileWidth / 2 );
			return logic;
		}
		
		public static function LogicToStage(logic:Point):Point
		{
			var stage : Point = new Point;
			stage.x = logic.x * TileWidth + ( logic.y & 1) * ( TileWidth / 2 );
			stage.y = logic.y * TileHeigth / 2;
			return stage;
		}
	}
}