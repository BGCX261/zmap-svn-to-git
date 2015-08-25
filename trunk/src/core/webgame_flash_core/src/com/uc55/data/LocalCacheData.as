package com.uc55.data{
	public class LocalCacheData{
		import flash.net.SharedObject;
		
		public static const LOGIN_CACHE:String="login_cache";
		public static const SWF_CACHE:String="swf_cache";
		
		public static const HEAD_SWF:String="head_swf";
		
		public function LocalCacheData():void{
			
		}
		
		public function addSWFCache(swf:*,type:String):void{
			var so:SharedObject=SharedObject.getLocal(SWF_CACHE);
			so.data[type]=swf;
		}
		
		public function addLoginCache(n:String,p:String):void{
			var so:SharedObject=SharedObject.getLocal(LOGIN_CACHE);
			so.data.user=n;
			so.data.pwd=p;
		}
		
		public static function getInstance():LocalCacheData{
			if(instance==null){
				instance=new LocalCacheData();
			}
			return instance;
		}
		
		private static var instance:LocalCacheData;
	}
}