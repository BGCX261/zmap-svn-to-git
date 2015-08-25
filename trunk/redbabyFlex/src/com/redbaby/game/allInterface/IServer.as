package com.redbaby.game.allInterface{
	import com.redbaby.game.core.net.pack.SimplePackage;
	
	import flash.events.IEventDispatcher;
	
	public interface IServer extends IEventDispatcher{
		public function IServer():void;
		
		function sendPackage(id:uint,serverID:uint,pack:SimplePackage=null):void;
		
		/**
		 * 
		 * @param	ip 服务器IP
		 */
		function connect(ip:String):void;
	}
}
