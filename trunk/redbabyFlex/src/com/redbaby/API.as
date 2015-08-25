/*********************************************
 * @usage Application
 * @author Z.eR
 * @version 0.1
 * @since 09.09.24
 * @see 09.09.24将core.API整合到redbaby.API中去
 *********************************************/
package com.redbaby {
	import com.adobe.serialization.json.JSON;
	import com.redbaby.game.allInterface.*;
	import com.redbaby.game.config.SysHost;
	import com.redbaby.game.core.net.AMFServer;
	import com.redbaby.game.data.DataManager;
	import com.redbaby.game.data.UserData;
	import com.redbaby.game.debug.Debug;
	import com.redbaby.game.events.*;
	import com.redbaby.game.system.*;
	import com.redbaby.game.view.ViewManager;
	import com.redbaby.game.view.ViewPredef;
	import com.redbaby.game.view.compDebug.DebugUI;
	import com.redbaby.game.view.resource.ResManager;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.events.FlexEvent;
	
	public class API extends AbstractGame {
		
		private static var _system:ISystem;//系统
		
		private static var _server:IServer;//服务(连接)
		
		private static var _roomFLV:Object;//房间FLV流
		
		private static var _newRoom:Object;//新房间
		
		private static var _roomMP3:Array = [];//房间MP3列表
		
		private static var _map:IMapEngine;//地图引擎
		
		private static var _avatar:IAvatar;//人物形象
		
		private static var _userData:UserData;//用户数据
		
		private var _app:Object;//Application
		
		private var _sc:*;//
		private var _ui:*;//
		
		private var _stageContainer:Object;
		private var _uiContainer:Object;
		
		private var _core:Core;//核心引用
		private var _view:ViewManager;//视图管理器
		private var _data:DataManager;//数据管理器
		
		private var _stage:Stage;//stage引用
		
		private var _info:Object;
		
		private var _stageComplete:Boolean;
		private var _uiComplete:Boolean;
		private var _configComplete:Boolean;
		
		public function API(app:Object,sc:Object,ui:Object):void {
			_app=app;
			_stageContainer=sc;
			_uiContainer=ui;
			_stageComplete=false;
			_uiComplete=false;
			_configComplete=false;
			_app.addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			CommonEventDispatcher.getInstance().addEventListener(AMFServer.RPC_OK,onRpcOK);
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
			if(Debug.DEBUG_MODE==Debug.NET){
				Server.connect("192.168.1.53");
			}
		}
		
		private function errorHandel(e:IOErrorEvent):void{
			trace(e.toString());
		}
		
		private function addedToStage(e:Event):void{
			_app.removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			_stage=_app.stage;
            _stage.frameRate=30;
            initGame();
		}
		
		/**
		 * getter & setter
		 */
		public static function get Server():IServer {
			return _server;
		}
		
		public static function set Server(x:IServer):void {
			if(_server){
			 	throw new Error("服务连接已设置,请删除冗余设置"); return;
			}
			
			_server = x;
		}
		
		public static function get System():ISystem{
			return _system;
		}
		
		public static function set System(x:ISystem):void {
			if(_system){
				throw new Error("系统已设置,请删除冗余设置"); return;
			}
			_system = x;
		}
	}
	
}
