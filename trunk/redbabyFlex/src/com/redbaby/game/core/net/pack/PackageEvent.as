package com.redbaby.game.core.net.pack{
	import flash.events.Event;
	
	public class PackageEvent extends Event	{

		//事件名称当收到报文并解析成功后发布该事件
		public static const PACKAGE:String = "package";
		//明文报文实体(不包含头部信息)
		public var packageBytes:SimplePackage;
		//长度2,校验码4,版本号2,终端类型1,报文ID2
		public var ver:uint;
		public var id:uint;
		
		
		/**
		 * 报文事件，收到正常报文验证通过并解密后发布报文事件
		 * 发布时报文内容不包含任何包头及加密信息 
		 * @param bytes
		 * 
		 */
		public function PackageEvent(bytes:SimplePackage){
			super(PACKAGE);   packageBytes = new SimplePackage();
			with(bytes){
				position = 6;   				//长度2,校验码4  跳过不读
				ver = readShort();			//版本号2
				position = 10;					//终端类型1 服务端类型1  跳过不读
				id = readShort();				//报文ID2
			}
			//生成最终真实报文
			bytes.readBytes(packageBytes);
		}
		
		
		
		override public function toString():String{
			return "[PackageEvent ver="+ver+" id="+id+"]";
		}
		
	}
}