/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import com.redbaby.game.data.MapData;

	public class Tile extends Sprite {
		
		private var content:DisplayObject;
		public var pointY:Number = 0.001;
		
		public function Tile(md:MapData,dt:Object) {
			var mapData:*= md;
			var data:*= dt;
			pointY = 0.001;
			content = mapData.getLib(data.link);
			this.addChild(content);
			try {
				(content as Object).showTarget = this;
			}catch (e) {
				
			}
			this.x = data.x;
			this.y = data.y;
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public function addTo(cont:DisplayObjectContainer):void {
			cont.addChild(this);
		}
		
		public function get depth():Number {
			if (content["z_mc"] != null) {
				return this.y + content["z_mc"].y;
			}
			if (pointY != 0.001) {
				return this.y + pointY;
			}
			return this.y + this.height;
		}
	}
	
}
