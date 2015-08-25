package com.uc55.view{
	import mx.containers.Canvas;
	
	public class SimpleCanvas extends Canvas{
		public function SimpleCanvas():void{
			verticalScrollPolicy="off";
			horizontalScrollPolicy="off";
			clipContent=false;
			creatingContentPane=false;
			mouseEnabled=false;
			tabChildren=false;
			return;
		}
		
		public function hide():void{
			visible=false;
		}
		
		public function show():void{
			visible=true;
		}
	}
}
