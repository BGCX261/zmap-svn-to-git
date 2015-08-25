package com.uc55.server{
	import com.uc55.config.SysHost;
	import com.uc55.event.*;
	import com.uc55.message.Message;
	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.controls.Alert;
	
	public class AMFServer extends Proxy implements IServer{
		
		private var _so:Socket;
		private var _domain:Socket;
		
		public static const RPC_OK:String="rpcok";
		
		public function AMFServer():void{
			return;
		}
		
		public function runServer():void{
			//策略文件请求
			_domain=new Socket();
			_domain.connect(SysHost.getInstance().RPC_IP,SysHost.getInstance().DOMAIN_PORT);
			_domain.addEventListener(ProgressEvent.SOCKET_DATA,onDomainData);
			
			//游戏socket连接
			_so=new Socket();
			_so.objectEncoding=3;
			_so.addEventListener(Event.CONNECT,onConnect);
			_so.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_so.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			_so.addEventListener(Event.CLOSE, onClose);
			_so.connect(SysHost.getInstance().RPC_IP,SysHost.getInstance().RPC_PORT);
			//游戏数据请求
		}
		
		public function send(obj:*):void{
			var bt:ByteArray=new ByteArray();
			bt.writeObject(obj);
			_so.writeInt(bt.length);
			_so.writeObject(obj);
			
			_so.flush();
			trace("发送消息:"+obj.commond);
		}
		
		private function onClose(e:Event):void{
			Alert.show("与服务器连接断开","",0);
		}
		
		private function onConnect(e:Event):void{
			trace("服务器已连接");
			CommonEventDispatcher.getInstance().dispatchEvent(new Event(RPC_OK));
		}
		
		private function onSocketData(e:ProgressEvent=null):void{
			
			receiveServerData();

		}
		
		public function receiveServerData():void{
			if(_so.bytesAvailable){
				var len:int = _so.readInt();
				while(_so.bytesAvailable){
					if(_so.bytesAvailable>=len){
						var bt:ByteArray = new ByteArray();
						_so.readBytes(bt,0,len);
						var m:Message = bt.readObject();
						trace("Commond:"+m.commond);
						trace("code:"+m.data[0]);
						trace("data:"+m.data[1]);
						CommonEventDispatcher.getInstance().dispatchEvent(new CommonEvent(m.commond,m.data));
						break;
					}
				}
			}
			
			if(_so.bytesAvailable)
			{
				 receiveServerData();
			}
		}
		
		private function onDomainData(e:ProgressEvent):void{
			_domain.removeEventListener(ProgressEvent.SOCKET_DATA,onDomainData);
			_domain.close();
			_domain=null;
		}
		
		private function onIoError(e:IOErrorEvent):void{
			trace("连接出错!");
		}
		
		public static function getInstance():AMFServer{
			if(instance==null){
				instance=new AMFServer();
			}
			return instance;
		}
		
		private static var instance:AMFServer;
	}
}
