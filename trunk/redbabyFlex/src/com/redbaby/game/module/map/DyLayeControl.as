package com.redbaby.game.module.map{
	import flash.display.Sprite;
	import flash.events.Event;
	public class DyLayeControl {
		
		private var view:Sprite;
		
		private static var instance:DyLayeControl;
		
		public function DyLayeControl(view:Sprite):void{
			this.view = view;
			view.addEventListener(Event.ENTER_FRAME, updateDepth);
			instance = this;
		}
		
		public function add()
	}
}
