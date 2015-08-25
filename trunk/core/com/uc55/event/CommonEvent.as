package com.uc55.event
{
	import flash.events.Event;

	public class CommonEvent extends Event
	{
		private var _object:Object;
		
		public function CommonEvent(type:String,obj:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			this._object=obj;
			
			super(type, bubbles, cancelable);
		}
		public function get  getobject():Object{
			
			return _object
		
		}
		
		
	}
}