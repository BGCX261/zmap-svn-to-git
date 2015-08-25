/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.data {
	import com.redbaby.game.allInterface.IMapTileModel;
	import com.redbaby.game.module.map.Tile;
	
	import com.redbaby.game.module.avatar.Avatar;
	public class MapData implements IMapTileModel{
		private var m_mapData:Array;
		public var avatar:Avatar;
		public function MapData() {
			
		}
		
		public function isBlock(sx:int,sy:int,ex:int,ey:int):int {
			var xlen:int;
			var ylen:int;
			xlen = m_mapData.length;
			ylen = m_mapData[0].length;
			
			if (ex < 0 || ex == xlen || ey < 0 || ey == ylen) {
				return 0;
			}
			
			return m_mapData[ex][ey];
		}
		
		public function reset(w:int, h:int, target:*):void {
			var wlen:int;
			var hlen:int;
			m_mapData = new Array();
			wlen = 0;
			var tile:Tile;
			var isClog:Boolean;
			for (var i:int = 0; i < h;i++ ){
				m_mapData[i] = new Array();
				hlen = 0;
				for (var j:int = 0; j < w; j++ ) {
					isClog = Math.random() < 0.3;
					tile = new Tile(isClog?0x000000:0xffffff);
					target.addChild(tile);
					tile.x = hlen * 10;
					tile.y = wlen * 10;
					m_mapData[wlen][hlen] = isClog?0:1;
					if (!hlen) {
						avatar = new Avatar();
						target.addChild(avatar);
					}
					hlen++;
				}
				wlen++;
			}
		}
		
		public function get mapData():Array {
			return m_mapData;
		}
		
		public function set mapData(x:Array):void {
			this.m_mapData = x;
		}
	}
	
}
