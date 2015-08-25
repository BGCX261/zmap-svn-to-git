package com.redbaby.game.core.net.message{
	
	[RemoteClass(alias="com.uc55.message.Message")]
	[Bindable]
	
	public class Message{
		
		public var commond:String;

		/**
	 	* 数据
	 	*/
		public var data:Array;
		
	}
}