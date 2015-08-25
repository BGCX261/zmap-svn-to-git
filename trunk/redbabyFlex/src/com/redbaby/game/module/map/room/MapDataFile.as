package com.redbaby.game.module.map.room {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class MapDataFile extends EventDispatcher{
		
		private var fr:FileReference;
		private var loader:URLLoader;
		public var fileData:ByteArray;
		
		public function MapDataFile()	{
			fr = new FileReference();
			loader = new URLLoader();
			loader.dataFormat = "binary"; 
		}
		
		public function save(data:ByteArray,fileName:String):void{
			//fr.save(data,fileName);
		}
		public function load(url:String=null):void{
			if (url){
				loader.addEventListener(Event.COMPLETE,onLoadComplete);
				loader.addEventListener(ProgressEvent.PROGRESS,onProgress)
				loader.load(new URLRequest(url));
			} else {
				//fr.addEventListener(Event.SELECT,onSelect);
				//fr.browse();
			}
		}
		private function onSelect(e:Event):void{
			fr.removeEventListener(Event.SELECT,onSelect);
			fr.addEventListener(Event.COMPLETE,onLoadComplete);
			fr.addEventListener(ProgressEvent.PROGRESS,onProgress);
			//fr.load();
		}
		private function onLoadComplete(e:Event):void{
			e.target.removeEventListener(Event.COMPLETE,onLoadComplete);
			e.target.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			fileData = e.target.data as ByteArray;
			dispatchEvent(e);
		}
		private function onProgress(e:ProgressEvent):void{
			trace(e.bytesLoaded,"/",e.bytesTotal);
		}
		
		
		public function get rectData():Array{
			var arr:Array = new Array();
			fileData.position = 0;
			var w:uint = fileData.readUnsignedByte();
			var h:uint = fileData.readUnsignedByte();
			for (var i:uint=0; i<h; i++){
				arr[i] = new Array();
				for (var j:uint=0; j<w; j++){
					arr[i][j] = fileData.readByte();
				}
			}
			return arr;
		}
		public function get rhombicData():Array{
			var rect:Array = rectData;   var arr:Array = new Array();
			//var len:uint = Math.min(rect.length>>1,rect[0].length)&0xFFFE;
			var len:uint=6;
			var x:int,y:int;
			for (var i:uint=0; i<len; i++){
				arr[i] = new Array();
//				var str:String = "";
				for (var j:uint=0; j<len; j++){
					y = i+j;
					x = (len>>1)-(j>>1)-1+(i>>1) //偶
					if (i&(1-j&1)) y++;
//					str += x+""+y+" ";				
					arr[i][j] = rect[y][x];
				}
//				trace(str);
			}
			return arr;
		}
		
		
	}
}