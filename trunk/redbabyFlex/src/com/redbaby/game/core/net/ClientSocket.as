package com.redbaby.game.core.net{
	import com.redbaby.game.core.net.pack.*;
	import com.redbaby.game.debug.DebugBuff;
	import com.redbaby.game.debug.DebugColor;
	import com.redbaby.game.view.compDebug.DebugUI;
	
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.Endian;
	
	public final class ClientSocket extends EventDispatcher{
		
		//报文固定http头,在80端口模拟普通网页协议穿越防火墙
		public static const HTTP_HEAD:String = "POST HTTP/1.1\r\n" + 
		"Host:redbaby.com.cn:80000\r\n" + 
		"Content-Type:text/plain;charset=UTF-8\r\n" + 
		"Connection:Keep-Alive\r\nContent-length:4096\r\n\r\n";
		//报文固定http头长度
		public static const HTTP_LEN:uint = HTTP_HEAD.length;
		//包体包头长度
		private static const HEAD_LEN:uint = PackageBytes.HEAD_LENGTH;
		
		//效验码 服务端与客户端的加密密钥效验码
		private const CLI_KEY_1:uint = 0xa54da6fc;
		private const CLI_KEY_2:uint = 0xe3d5f1ed;
		private const SER_KEY_1:uint = 0x9daef617;
		private const SER_KEY_2:uint = 0x8d17a063;
		
		//通信密钥存储空间
		private var key1Buffer:uint, key2Buffer:uint;
		//通信数据缓存
		private var sendBuffer:PackageBytes;
		//收包数据缓存
		private var recvBuffer:PackageBytes;
		//收包时的原始流数据缓存
		private var recvCache:SimplePackage;
		
		//通信类
		private var socket:Socket;
		
		//服务器ID
		public var serverID:uint;
		
		
		
		
		/**
		 *	构造函数，初始化客户端与服务端的底层通信
		 * 	使用低位在前规则，报文一律采用加密通信
		 * @param host 服务器地址
		 *  服务器端口，默认采用80端口穿越防火墙
		 * 	此方法主要http应用，注意服务端安全策略文件广播
		 * 
		 */		
		public function ClientSocket(host:String=null){
			if (host) connect(host);
		}
		
		
		public function connect(host:String):void{
			with(socket = new Socket(host, 80)){
				endian = Endian.LITTLE_ENDIAN;
				addEventListener(Event.CONNECT,onConnect);
				addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
				addEventListener(IOErrorEvent.IO_ERROR,onIOError);
				addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
				addEventListener(Event.CLOSE,onClose);
			}
		}
		
		
		
		/**
		 *	连接成功后 生成通信密钥 测试服务器通信
		 * 	密钥为随机 4字节(32bytes)值
		 * @param e 事件对象
		 * 
		 */
		private function onConnect(e:Event):void{
			key1Buffer = uint(Math.random()*uint.MAX_VALUE);
			key2Buffer = uint(Math.random()*uint.MAX_VALUE);
			with(sendBuffer = new PackageBytes()){
				writeUnsignedInt(key1Buffer ^ CLI_KEY_1);//写入客户端KEY1
				writeUnsignedInt(key2Buffer ^ CLI_KEY_2);//写入客户端KEY2
				position = 0;					//指针归零，开始写包头
				writeShort(length);		//(2)写入包体长度
				writeUnsignedInt(0);	//(4)写入空校验码
				writeShort(1);				//(2)写入报文版本号
				writeByte(1);					//(1)写入客户端类型
				writeByte(1);					//(1)写入服务端类型
				writeShort(100);			//(2)写入报文ID[100:握手包]
				changeCrc(crc);				//置换校验码
			}
			with(socket){
				writeUTFBytes(HTTP_HEAD);  						//添加http头，穿越防火墙
				writeBytes(sendBuffer);   						//写入报文
				flush();															//发送完毕
			}
			recvCache = new SimplePackage();				//接受报文数据缓存
			addEventListener(PackageEvent.PACKAGE,runPackage,false,int.MAX_VALUE);
		}
		
		
		
		
		/**
		 *  发包函数，此函数为核心通信函数，发包接口
		 *  通信协议包体定义：http协议头+报文内容
		 *	包头:数据长度[2],效验码[4],版本号[2],
		 * 		终端类型[1],服务端类型[1]，报文ID[2]
		 * 	报文内容以事件形式发布，包含必要信息和实体数据
		 * 	构造函数建立通信包体，低位在前(littleEndian) 
		 * @param packID 报文ID
		 * @param data 报文数据内容
		 * 
		 */		
		public function sendPackage(packID:uint,
		data:SimplePackage=null):void{
			with(sendBuffer = new PackageBytes()){
				if (data) {
					writeBytes(data);				//写入数据包
					position = 0;						//指针归零，开始写包头
					writeShort(length);			//(2)写入包体长度
				} else {
					position = 0;						//指针归零，开始写包头
					writeShort(HEAD_LEN);		//(2)写入包体长度
				}
				writeUnsignedInt(0);							//(4)写入空校验码
				writeShort(1);										//(2)写入报文版本号
				writeByte(1);											//(1)写入客户端类型
				writeByte(serverID);							//(1)写入服务端类型
				writeShort(packID);								//(2)写入报文ID
				changeCrc(crc);										//置换校验码
				xor(2, key1Buffer, key2Buffer);		//包内容加密
			}
			with(socket){
				try{
					DebugUI.getInstance().log("Socket","发送命令 "+packID,DebugColor.KEY);
				}catch(e:Error){
					var info:Object=new Object();
					info.tag="Socket";
					info.msg="发送命令 "+packID;
					info.clr=DebugColor.KEY;
					DebugBuff.Buff.push(info);
				}
				writeUTFBytes(HTTP_HEAD);   			//添加http头，穿越防火墙
				writeBytes(sendBuffer);   				//写入报文
				flush();													//发送完毕			
			}
		}
		
	
		
		
		
		
		
		/**
		 *	收包解析函数
		 * @param e 事件对象
		 * 
		 */		
		private function onSocketData(e:ProgressEvent):void{
			var bytes:SimplePackage = new SimplePackage();
			var bytesCache:SimplePackage = new SimplePackage();
			socket.readBytes(recvCache,recvCache.length);
			
			var packLen:uint,pCrc:uint;
			while(recvCache.position+HTTP_LEN<recvCache.length){
				with(recvCache){
					position += HTTP_LEN;
					packLen = readShort();
					if (position-2+packLen > length) break;
					recvBuffer = new PackageBytes();
					position -= 2;
					readBytes(recvBuffer,0,packLen);
				}
				with(recvBuffer){
					xor(2,key1Buffer,key2Buffer);	//异或解密
					position = 2;	//长度2,版本号2,终端类型1,校验码4,报文ID2
					pCrc = readUnsignedInt();   changeCrc(0);
//					trace(pCrc>>24,(pCrc>>16)&0xFF,(pCrc>>8)&0xFF,pCrc&0xFF);
//					trace(crc>>24,(crc>>16)&0xFF,(crc>>8)&0xFF,crc&0xFF);
					if (pCrc!=crc) throw new Error("crc校验失败!");
				}
 				dispatchEvent(new PackageEvent(recvBuffer));
			}
			
			//完整读完报文后(若指针为与数据流末端)，清空报文
			if(recvCache.position==recvCache.length) {
				recvCache = new SimplePackage();
			}
			
		}
		
		
		
		
		
		
		/**
		 *  执行函数，仅用在核心连接握手通信的封装上。 
		 * @param e
		 * 
		 */
		private function runPackage(e:PackageEvent):void{
			e.stopImmediatePropagation();
			if (e.id == 101){
				with(e.packageBytes){
					if (readUnsignedInt()!=key1Buffer||readUnsignedInt()!=key2Buffer){
						throw new Error("服务端认证失败！");
					}
				}
			} else if (e.id == 102){
				key1Buffer = e.packageBytes.readUnsignedInt() ^ SER_KEY_1;
				key2Buffer = e.packageBytes.readUnsignedInt() ^ SER_KEY_2;
				var packageBytes:SimplePackage = new SimplePackage();
				packageBytes.writeUnsignedInt(key1Buffer ^ CLI_KEY_1);
				packageBytes.writeUnsignedInt(key2Buffer ^ CLI_KEY_2);
				sendPackage(103,packageBytes);
				removeEventListener(PackageEvent.PACKAGE,runPackage);
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
		}

		private function onIOError(e:IOErrorEvent):void{
			trace(e.text);
		}

		private function onSecurityError(e:SecurityErrorEvent):void{
			trace(e.text);
		}	
			
		private function onClose(e:Event):void{
			trace("连接被断开");
		}	
				
		public function get connected():Boolean{
			return socket&&socket.connected;
		}

	}
}