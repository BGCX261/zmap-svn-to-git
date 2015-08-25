/**
* @author Z.eR
* @version 0.1
*/


package com.redbaby {
	import flash.display.Sprite;
	
	import com.redbaby.game.module.map.Map;
	
	public class RedPark extends Sprite {
		private var map:Map;
		public function RedPark() {
			var map:Map = new Map();
			this.addChild(map);
		}
		
	}
	
}
