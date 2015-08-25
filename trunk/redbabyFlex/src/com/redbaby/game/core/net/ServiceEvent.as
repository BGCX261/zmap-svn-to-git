package com.redbaby.game.core.net{
	import flash.events.Event;	
	public class ServiceEvent extends Event{
		public var success:Boolean;
		public var info:String;
		public var infoID:uint;
		public function ServiceEvent(type:String){
			super(type);
		}
	}
}