package com.redbaby.game.debug{
	public class DebugBuff{
		private static var _buff:Array;
		public function DebugBuff():void{
			
		}
		
		public static function get Buff():Array{
			if(_buff==null){
				_buff=new Array();
			}
			return _buff;
		}
		
		public static function set Buff(x:Array):void{
			if(_buff==null){
				_buff=new Array();
			}
			_buff=x;
		}
	}
}
