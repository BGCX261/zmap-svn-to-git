package com.redbaby.game.core.net.pack{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SimplePackage extends ByteArray{




		/**
		 * 	通信协议包简单类型，内容仅仅为报文实体或简单字节流
		 *  更改低位在前，不包含包头、http头和加密校验等运算
		 * 	复杂类型通信字节流packageBytes将继承此类
		 */
		public function SimplePackage(){
			super();   endian = Endian.LITTLE_ENDIAN;
		}
		
		
		
		/**
		 * 覆盖默认方法，输出字节流信息
		 * @return string
		 * 
		 */		
		override public function toString():String{
			var i:uint=0, len:uint=length, str:String="";
			for (; i<len; i++) str += " "+this[i].toString(16);
			return str;
		}



		/**
		 *	将一个字符串按UTF-8写入流 
		 * @param str 写入的字符串
		 * 
		 */
		public function writeStr(str:String):void{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(str);
			var len:uint = bytes.length;
			if (len<255){
				writeByte(len);
				writeBytes(bytes);
			} else {
				writeByte(0xFF);
				writeShort(len);
				writeBytes(bytes);
			}
		}
		/**
		 *	按规则读出一个UTF-8字符串
		 * @return 
		 * 
		 */		
		public function readStr():String{
			var len:uint = readByte();
			if (len==255)	return readUTF();
			else return readUTFBytes(len);
		}



	}
}