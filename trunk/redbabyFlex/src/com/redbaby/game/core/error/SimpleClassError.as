package com.redbaby.game.core.error{
	public class SimpleClassError extends Error {
		public function SimpleClassError(){
			super("单件模式，请访问instance属性获取实例;");
		}
	}
}