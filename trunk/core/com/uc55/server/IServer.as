package com.uc55.server{
	public interface IServer{
		public function IServer():void;
		
		function runServer():void;
		
		function send(msg:*):void;
		
		function receiveServerData():void;
	}
}
