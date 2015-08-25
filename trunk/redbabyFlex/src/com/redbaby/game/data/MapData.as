/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.data {
	import com.redbaby.game.allInterface.IMapTileModel;
	import com.redbaby.game.module.map.Player;
	import com.redbaby.game.module.map.astar.GridXY;
	
	import flash.display.*;
	import flash.text.TextField;
	public class MapData implements IMapTileModel{
		private var data:Array;
		
		public var player:Player;

		public function MapData() {

		}
		
		public function isBlock(sx:int,sy:int,ex:int,ey:int):int {
			var xlen:int;
			var ylen:int;
			xlen = data.length;
			ylen = data[0].length;
			
			if (ex < 0 || ex == xlen || ey < 0 || ey == ylen) {
				return 0;
			}
			
			return data[ex][ey];
		}
		
		public function setWalkable(x:int,y:int,can:Boolean):void {
			if (can) {
				data[x][y] = 1;
			}else {
				data[x][y] = 0;
			}
		}
		
		public function reset(w:int, h:int, map:Array, target:Sprite):void {
			if(target.numChildren>0){
				target.removeChildAt(0);
			}
			
			var height:int;
			var width:int;
			
			data = new Array();
			
			height = 0;
			
			/*
			while (height < h) {
				data[width] = new Array();
				width = 0;
				while (width < w) {
					if(!width&&!height){
			
						/*player=new Sprite();
						var pClass:BitmapData=new mtile(60,60);
						var pBitmap:Bitmap=new Bitmap(pClass);
						player.x=(64/2)*(width-height)+500;
						player.y = (31/2)*(width+height)+16;
						player.addChild(pBitmap);
						
						player=new Player(true,3);
						player.x=((64/2)*(width-height)+GridXY.startX)+32;
						player.y = ((31/2)*(width+height)+GridXY.startY)-158;
						trace("playerWH:"+player.width,player.height);
					}
					data[height][width] =  map[height][width];
					//data[height][width] =  1;
					if(data[height][width]){
						var myClass:BitmapData=new itile(60,60);
					}else{
						var myClass:BitmapData=new mtile(60,60);
					}
					
					var mapEle:Sprite=new Sprite();
					var bitmap:Bitmap=new Bitmap(myClass);
					var txt:TextField=new TextField();
					txt.text=height+","+width;
					txt.x=17;
					txt.y=5;
					txt.selectable=false;
					mapEle.addChild(bitmap);
					mapEle.addChild(txt);
					mapEle.x = (GridXY.width/2)*(width-height)+GridXY.startX;
					mapEle.y = (GridXY.height/2)*(width+height)+GridXY.startY;
					//trace(mapEle.x,mapEle.y);
					target.addChild(mapEle);
					
					width++;
				}
				height++;
			}
			target.addChild(player);
			*/
		}
		
		public function closeBlock(h:int, w:int):void {
			data[h][w] = 0;
		}
		
		public function getWalkable(h:int, w:int):Boolean{
			if (data[h][w]) {
				return true;
			}
			return false;
		}
		
		public function get mapData():Array {
			return data;
		}
		
		public function set mapData(x:Array):void {
			this.data = x;
		}
	}
	
}
