package com.uc55.view{
	import mx.containers.Canvas;
	
	public class UICanvas extends Canvas{
		public function UICanvas():void{
			
		}
		
		public function setPos(w:int,h:int):void{
	   		this.x=(1000-w)/2;
	   		this.y=(600-h)/2;
	   		top();
	   	}
	   	
	   	private function top():void{
			this.parent.setChildIndex(this,this.parent.numChildren-1);
		}
	}
}