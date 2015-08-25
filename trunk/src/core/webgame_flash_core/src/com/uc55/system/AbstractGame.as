package com.uc55.system{
	public class AbstractGame extends Object{
		public function AbstractGame():void{
			return;
		}
		
		protected function createCore():void{
			throw new Error("Abstract function");
		}
		
		protected function createStage():void{
			throw new Error("Abstract function");
		}
		
		protected function createUI():void{
			throw new Error("Abstract function");
		}
		
		protected function loadConfig():void{
			throw new Error("Abstract function");
		}
		
		final public function initGame():void{
			loadConfig();
		}
	}
}
