/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map {
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Tile extends Sprite {
		
		public function Tile(color:uint = 0xffffff, w:int = 10, h:int = 10) {
			this.addEventListener(MouseEvent.CLICK, onTileClick);
			with (this.graphics) {
				lineStyle(1, 0x666666);
				beginFill(color);
				drawRect(0, 0, w, h);
				endFill();
			}
		}
		
		private function onTileClick(e:MouseEvent):void {
			
		}
		
	}
	
}
