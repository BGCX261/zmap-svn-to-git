/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import com.redbaby.game.module.map.RCS;

	public class Map extends Sprite {
		private var grid:Grid;
		public function Map() {
			this.addEventListener(MouseEvent.CLICK, onMapClick);
			grid = new Grid();
			this.addChild(grid);
		}
		
		private function onMapClick(e:MouseEvent):void {
			var pto:Point = RCS.ScreenToPoint(mouseX, mouseY);
			var pfrom:Point = RCS.ScreenToPoint(grid.mapData.avatar.x, grid.mapData.avatar.y);
			trace("from", pfrom, "to", pto);
			var path:Array = grid.astar.find(pfrom.x, pfrom.y, pto.x, pto.y);
			trace(path);
		}
		
	}
	
}
