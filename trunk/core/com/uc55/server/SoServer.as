package com.uc55.server{
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.Endian;
	
	
	public class SoServer implements IServer{
		private var socket:Socket;
		
		public static const HTTP_HEAD:String = "POST HTTP/1.1\r\n" + 
		"Host:redbaby.com.cn:80000\r\n" + 
		"Content-Type:text/plain;charset=UTF-8\r\n" + 
		"Connection:Keep-Alive\r\nContent-length:4096\r\n\r\n";
		
		private var key1Buffer:uint;
		private var key2Buffer:uint;
		
		private var serKey1:uint = 0x9daef617;
		private var serKey2:uint = 0x8d17a063;
		private var cliKey1:uint = 0xa54da6fc;
		private var cliKey2:uint = 0xe3d5f1ed;
		
		public function SoServer():void{
			
		}
		
		public function runServer():void{
			socket=new Socket("192.168.1.53",80);
			socket.endian = Endian.LITTLE_ENDIAN;
			socket.addEventListener(Event.CONNECT,onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			socket.addEventListener(Event.CLOSE,onClose);
		}
		
		public function receiveServerData():void{
			
		}
		
		public function send(msg:*):void{
			
		}
		
		private function onConnect(e:Event):void{
			trace("服务器已登录");
			key1Buffer = uint(Math.random()*uint.MAX_VALUE);
			key2Buffer = uint(Math.random()*uint.MAX_VALUE);
			
			trace(key1Buffer,cliKey1);
			trace(key2Buffer,cliKey2);
			
			trace(key1Buffer ^ cliKey1);
			trace(key2Buffer ^ cliKey2);
		}
		
		private function onSocketData(e:ProgressEvent):void{
			receiveServerData()
			trace("有数据返回");
		}
		
		private function onIOError(e:IOErrorEvent):void{
			trace("IOError");
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void{
			trace("安全问题");
		}
		
		private function onClose(e:Event):void{
			trace("服务关闭");
		}
	}
}
