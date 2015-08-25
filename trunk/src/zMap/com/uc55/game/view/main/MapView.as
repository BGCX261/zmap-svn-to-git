package com.uc55.game.view.main{
	import com.uc55.game.utils.PointExchange;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import mx.controls.Image;
	
	public class MapView extends Image{
		
		private var pointGroup:Array;
		private var itemGroup:Array;
		
		public function MapView():void{
			pointGroup=[];
			itemGroup=[];
			initMap();
		}
		
		private function initMap():void{
			for(var i:int=0;i<32;i++){
				for(var j:int=0;j<14;j++){
					var p:Point=PointExchange.LogicToStage(new Point(j,i));
					var s:Sprite=item(p);
					var t:TextField=pointTxt(j,i,s.x,s.y)
					
	        		s.addChild(t);
	        		addChild(s);
	        		
	        		pointGroup.push(t);
	        		itemGroup.push(s);
				}
			}
		}
		
		private function pointTxt(rol:int,row:int,x:int,y:int):TextField{
			var txt:TextField=new TextField();
			txt.text=rol+","+row;
			txt.x=30;
			txt.y=10;
	        txt.selectable=false;
	        return txt;
		}
		
		private function item(p:Point):Sprite{
			var sprite:Sprite=new Sprite();
			var myClass:Class=grass;
			var bitmapData:BitmapData=new myClass(60,60) as BitmapData;
	        var bitmap:Bitmap=new Bitmap(bitmapData);
	        sprite.x=p.x+50;
	        sprite.y=p.y+125;
	        sprite.addChild(bitmap);
	        return sprite;
		}
	}
}
