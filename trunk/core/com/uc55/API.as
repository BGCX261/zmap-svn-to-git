package com.uc55{
	import com.uc55.server.ClientSocket;
	import com.adobe.serialization.json.JSON;
	import com.uc55.config.SysHost;
	import com.uc55.data.DataManager;
	import com.uc55.event.*;
	import com.uc55.server.AMFServer;
	import com.uc55.system.*;
	import com.uc55.view.ViewManager;
	import com.uc55.view.resource.ResManager;
	import com.uc55.config.Debug;
	
	import flash.display.Stage;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.events.FlexEvent;
	
	public class API extends AbstractGame{
		
		private var _app:Object;
		
		private var _sc:*;
		private var _ui:*;
		
		private var _stageContainer:Object;
		private var _uiContainer:Object;
		
		private var _core:Core;
		private var _view:ViewManager;
		private var _data:DataManager;
		
		private var _stage:Stage;
		
		private var _info:Object;
		
		private var _stageComplete:Boolean;
		private var _uiComplete:Boolean;
		private var _configComplete:Boolean;
		
		public function API(app:Object,sc:Object,ui:Object):void{
			_app=app;
			_stageContainer=sc;
			_uiContainer=ui;
			_stageComplete=false;
			_uiComplete=false;
			_configComplete=false;
			CommonEventDispatcher.getInstance().addEventListener(AMFServer.RPC_OK,onRpcOK);
			_app.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		override protected function createCore():void{
			if(_info){
				
			}
			_core=Core.getInstance();
			_view=ViewManager.getInstance();
			_data=DataManager.getInstance();
			_core.view=_view;
			_core.data=_data;
			_view.init(_stage);
			ResManager.init();
		}
		
		override protected function createStage():void{
			_sc=new _stageContainer;
			_sc.addEventListener(FlexEvent.CREATION_COMPLETE, stageCompleteHandler);
			_sc.setStyle("left","0");
			_sc.setStyle("right","0");
			_sc.setStyle("down","0");
			_sc.setStyle("up","0");
			_app.addChild(_sc);
		}
		
		override protected function createUI():void{
			if(!_stageComplete){
				_sc.addEventListener(FlexEvent.CREATION_COMPLETE, createUIAfterStageComplete);
				return;
			}
			
			_ui=new _uiContainer;
			_app.addChild(_ui);
			_uiComplete=true;
		}
		
		override protected function loadConfig():void{
			trace("开始加载");
			var l:URLLoader=new URLLoader();
			l.addEventListener(IOErrorEvent.IO_ERROR,errorHandel);
			l.addEventListener(Event.COMPLETE,onConfigLoaded);
			
			var path:String=SysHost.getInstance().CONFIG_FILE;
			l.load(new URLRequest(path));
		}
		
		private function onRpcOK(e:Event):void{
			createCore();
			createStage();
			createUI();
		}
		
		public function get ui():*{
			return _ui;
		}
		
		private function stageCompleteHandler(e:FlexEvent):void{
			e.currentTarget.removeEventListener(FlexEvent.CREATION_COMPLETE, stageCompleteHandler);
			_stageComplete=true;
		}
		
		private function createUIAfterStageComplete(e:FlexEvent):void{
			e.currentTarget.removeEventListener(FlexEvent.CREATION_COMPLETE, createUIAfterStageComplete);
			_stageComplete=true;
			createUI();
		}
		
		private function onConfigLoaded(e:Event):void{
			var obj:Object=JSON.decode(e.currentTarget.data);
			SysHost.getInstance().init(obj);
			
			_configComplete=true;
			
			if(Debug.DEBUG_MODE){
				var cs:ClientSocket=new ClientSocket("192.168.1.53");
			}
		}
		
		private function errorHandel(e:IOErrorEvent):void{
			trace(e.toString());
		}
		
		private function addedToStage(e:Event):void{
			_app.removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			_stage=_app.stage;
            _stage.frameRate=24;
            initGame();
		}
	}
}
