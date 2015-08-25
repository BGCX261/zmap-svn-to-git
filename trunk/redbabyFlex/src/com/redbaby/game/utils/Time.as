package com.redbaby.game.utils{
	public class Time{
		public function Time():void{
			
		}
		
		public static function getClientTimeStr():String{
			var date:Date=new Date();
			return date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
		}
		
		public static function getClientTimeNum():Number{
			var date:Date=new Date();
			
			return date.getTime();
		}
	}
}
