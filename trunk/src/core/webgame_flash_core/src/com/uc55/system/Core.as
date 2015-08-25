package com.uc55.system{
	import com.uc55.data.DataManager;
	import com.uc55.view.ViewManager;
	
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
