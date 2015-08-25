package com.uc55.event
{
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;

	public class CommonEventDispatcher extends EventDispatcher
	{
		private static var _instance:CommonEventDispatcher;
		
		public static function getInstance():CommonEventDispatcher{
			if(_instance==null){
				_instance=new CommonEventDispatcher();
			}
			return _instance;
		}
		
	}
}