package com.redbaby.game.system{
	import com.redbaby.game.data.DataManager;
	import com.redbaby.game.view.ViewManager;
	
	public class Core{
		
		private var _app:Object;
		
		public var view:ViewManager;
		public var data:DataManager;
		
		
		public function Core():void{
			
		}
		
		public static function getInstance():Core{
			if(instance==null){
				instance=new Core();
			}
			return instance;
		}
		
		private static var instance:Core;
	}
}
