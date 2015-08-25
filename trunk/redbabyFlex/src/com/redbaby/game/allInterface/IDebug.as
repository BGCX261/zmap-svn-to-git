package com.redbaby.game.allInterface{
	import com.redbaby.game.view.compDebug.DebugUI;
	
	public interface IDebug{
		public function IDebug():void;
		
		function log(tag:String,msg:Object,clr:String="#288005"):void;
	}
}
