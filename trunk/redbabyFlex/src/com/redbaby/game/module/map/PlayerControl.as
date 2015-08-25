package com.redbaby.game.module.map{
	import flash.display.Sprite;
	import flash.geom.Point;
	public class PlayerControl {
		private var view:Sprite;
		private static var instance:PlayerControl;
		private static var self:Player;
		
		public function PlayerControl(spr:Sprite):void{
			view = spr;
			instance = this;
		}
		
		public function initMapPlayer():void {
			var u:Player;
			var uPoint:Point;
			var uID:String;
			var xy:String;
			var guest:int;
			if (!self) {
				u = new Player(true);
				self = u;
			}
			self.setXY(300, 200);
			
			view.addChild(self);
		}
		
		public static function get user():Player {
			return self;
		}
	}
}
