/**
* ...
* @author Default
* @version 0.1
*/

package com.redbaby.game.module.map {
	import com.redbaby.game.data.MapData;
	import flash.display.Sprite;
	
	import com.redbaby.game.module.map.astar.AStar;

	public class Grid extends Sprite {
		public var mapData:MapData;
		public var astar:AStar;
		public function Grid() {
			mapData = new MapData();
			mapData.reset(100, 60, this);
			astar = new AStar(mapData, 1500);
		}
	}
	
}
