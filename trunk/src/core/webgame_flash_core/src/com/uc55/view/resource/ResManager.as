package com.uc55.view.resource{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	public class ResManager{
		
		private static var d:Object;
		
		public static const HERO_HEAD:String="herohead";
		public static const CREATOR:String="creator";
		public static const CITY:String="city";
		public static const BUILD_TREE:String="buildtree";
		public static const SKIN:String="skin";
		public static const ICON:String="icons";
		
		public static const SWF_SO:String="swf_so";
		
		public function ResManager():void{
			
		}
		
		public static function init():void{
			d=[];
		}
		
		public function addClassRes(t:String,r:*):void{
			var so:SharedObject=SharedObject.getLocal(SWF_SO);
			
			so.data[t]=r;
			
			var byteArray:ByteArray = so.data[t];
            var l:Loader = new Loader();
            l.name=t;
            l.loadBytes(byteArray, new LoaderContext(false));
            l.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoaded);
            
			so.flush();
		}
		
		public function setData(t:String):void{
			var so:SharedObject=SharedObject.getLocal(SWF_SO);
			
			var byteArray:ByteArray = so.data[t];
            var l:Loader = new Loader();
            l.name=t;
            l.loadBytes(byteArray, new LoaderContext(false));
            l.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoaded);
		}
		
		private function onSWFLoaded(e:Event):void{
			e.currentTarget.removeEventListener(Event.COMPLETE,onSWFLoaded);
			var type:String=e.currentTarget.loader.name;
			d[type]=e.currentTarget;
		}
		
		public function has(t:String):Boolean{
			var so:SharedObject=SharedObject.getLocal(SWF_SO);
			if(so.data[t]!=null){
				return true;
			}
			return false;
		}
		
		public static function getSwf(t:String):*{
			return d[t].loader.content;
		}
		
		public static function getClass(t:String,c:String):*{
			return d[t].applicationDomain.getDefinition(c) as Class;
		}
		
		public static function getInstance():ResManager{
			if(instance==null){
				instance=new ResManager();
			}
			return instance;
		}
		
		private static var instance:ResManager;
	}
}
