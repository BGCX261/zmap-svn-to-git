package com.redbaby.game.core.net{
	import flash.events.Event;
	import com.redbaby.game.core.net.pack.*;
	public class CodeEvent extends Event{
		public var data:SimplePackage;
		public function CodeEvent(id:String,bytes:SimplePackage){
			super(id); this.data = bytes;
		}
	}
}