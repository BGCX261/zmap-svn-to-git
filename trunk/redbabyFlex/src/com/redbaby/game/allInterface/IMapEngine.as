package com.redbaby.game.allInterface{
	import flash.display.IBitmapDrawable;
	
	public interface IMapEngine extends IBitmapDrawable{
		public function IMapEngine():void;
		
		function load(id:uint,url:String):void;
		
		function get avatar():IAvatar;
		
		function get user():IPlayer;
		
		function loadUserRoom(id:uint):void;
	}
}
