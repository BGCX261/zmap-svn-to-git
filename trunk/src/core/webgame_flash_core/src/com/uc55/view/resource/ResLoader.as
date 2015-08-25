package com.uc55.view.resource{
	import com.adobe.serialization.json.JSON;
	import com.uc55.config.GamePredef;
	import com.uc55.config.SysHost;
	import com.uc55.event.*;
	import com.uc55.data.DataManager;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	public class ResLoader{
		
		public static const RES_LOADED:String="resloaded";
		public static const SET_TITLE:String="settitle";
		
		private var _arr:Array;
		private var _dat:Array;
		private var _cur:int;
		private var _curdat:int;
		
		private var _rn:String;
		
		private var _byteArray:ByteArray;
		
		public function ResLoader():void{
			
		}
		
		public function init():void{
			var l:URLLoader=new URLLoader();
			l.load(new URLRequest(SysHost.getInstance().RES_URL+GamePredef.LOAD_CONFIG));
			l.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function loadDat():void{
			CommonEventDispatcher.getInstance().dispatchEvent(new CommonEvent(SET_TITLE,"加载游戏数据配置"));
			var ld:URLLoader=new URLLoader();
			ld.load(new URLRequest(SysHost.getInstance().RES_URL+GamePredef.DAT_CONFIG));
			ld.addEventListener(Event.COMPLETE,onDatComplete);
		}
		
		private function onDatComplete(e:Event):void{
			if(e.currentTarget.data!=""){
			e.currentTarget.removeEventListener(Event.COMPLETE,onDatComplete);
			var obj:String;
			_dat=String(e.currentTarget.data).split(";");
			for(var i:int=0;i<_dat.length;i++){
				_dat[i]=JSON.decode(_dat[i]);	
			}
			loadNextDat();
			}else{
				CommonEventDispatcher.getInstance().dispatchEvent(new Event(RES_LOADED));
			}
		}
			
		private function onComplete(e:Event):void{
			var obj:String;
			_arr=String(e.currentTarget.data).split(";");
			for(var i:int=0;i<_arr.length;i++){
				_arr[i]=JSON.decode(_arr[i]);	
			}
			e.currentTarget.removeEventListener(Event.COMPLETE,onComplete);
			loadNext();
		}
		
		private function loadNextDat():void{
			if(_curdat>=_dat.length){
				CommonEventDispatcher.getInstance().dispatchEvent(new Event(RES_LOADED));
				return;
			}
			
			var ldat:URLLoader=new URLLoader();
			ldat.addEventListener(Event.COMPLETE,onLoadedDat);
			ldat.load(new URLRequest(SysHost.getInstance().DAT_URL+_dat[_curdat].n));
		}
		
		private function onLoadedDat(e:Event):void{
			e.currentTarget.removeEventListener(Event.COMPLETE,onLoadedDat);
			trace(e.currentTarget.data);
			var d:Array=JSON.decode(e.currentTarget.data);
			for (var i:* in d)
			{
				d[i]=JSON.decode(d[i]);
			}
			DataManager.getInstance().addData(_curdat+6,d);
			_curdat++;
			loadNextDat();
		}
			
		private function loadNext():void{	
			if(_cur>=_arr.length){
				//CommonEventDispatcher.getInstance().dispatchEvent(new Event(RES_LOADED));
				loadDat();
				return;
			}
			
			var str:String=_arr[_cur].n+" 总进度("+(_cur+1)+"/"+_arr.length+")";	
			CommonEventDispatcher.getInstance().dispatchEvent(new CommonEvent(SET_TITLE,str));
				
			if(int(_arr[_cur].t)){
				var loader:URLStream=new URLStream();
				_rn=_arr[_cur].i;
				loader.addEventListener(Event.COMPLETE,onFileLoaded);
				
				loader.load(new URLRequest(SysHost.getInstance().RES_URL+"config/"+_arr[_cur].f));

			}else{
				var urlloader:URLLoader=new URLLoader();
				urlloader.addEventListener(Event.COMPLETE,onFileLoaded);
				urlloader.load(new URLRequest(SysHost.getInstance().RES_URL+"config/"+_arr[_cur].f));
			}
				
			_cur++;
		}

		private function onFileLoaded(e:Event):void{
			if(e.currentTarget is URLStream){
				_byteArray=new ByteArray();
				
				var urlStream:URLStream = e.currentTarget as URLStream;
				while (urlStream.bytesAvailable){
					urlStream.readBytes(_byteArray, _byteArray.length);
				}
				ResManager.getInstance().addClassRes(_rn,_byteArray);
			}else{
				
			}
			e.currentTarget.removeEventListener(Event.COMPLETE,onFileLoaded);
			loadNext();
		}
		
		public static function getInstance():ResLoader{
			if(instance==null){
				instance=new ResLoader();
			}
			return instance;
		}
		
		private static var instance:ResLoader;
	}
}