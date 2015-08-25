package com.redbaby.game.module.map{
	public class Cell {
		public var name:String;
		public var _X:int;
		public var _Y:int;
		public function Cell():void {
			
		}
		
		public function get X():int {
			return _X;
		}
		
		public function get Y():int {
			return _Y;
		}
		
		public function set X(x:int):void {
			_X = X;
		}
		
		public function set Y(y:int):void {
			_Y = Y;
		}
		
		public function setAble(x:Boolean):void {
			
		}
	}
}