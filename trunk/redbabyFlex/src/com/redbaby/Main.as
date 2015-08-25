/***********************************************
 * Application主入口
 ***********************************************/ 
package com.redbaby{
	import com.redbaby.game.allInterface.ISystem;
	import com.redbaby.game.core.net.ServiceConnection;
	import com.redbaby.game.debug.Debug;
	import com.redbaby.game.events.*;
	import com.redbaby.game.rpc.SocketManager;
	import com.redbaby.ui.view.StageContainer;
	import com.redbaby.ui.view.UIContainer;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	public class Main extends UIComponent implements ISystem{
		
		public function Main(app:Object):void{
			API.System=this;
			API.Server=ServiceConnection.instance;
			
			var api:API=new API(app,StageContainer,UIContainer);
			if(Debug.DEBUG_MODE==Debug.LOCAL){
				CommonEventDispatcher.getInstance().dispatchEvent(new Event(SocketManager.RPC_OK));
			}
		}
		
		public function roleSelectInit():void{
			
		}
		
		public function showProgress():void{
			
		}
		
		public function hideProgress():void{
			
		}
		
		public function showMessage():void{
			
		}
	}
}
