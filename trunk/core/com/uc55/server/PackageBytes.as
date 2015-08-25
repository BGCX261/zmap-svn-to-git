package com.uc55.server {
	

	public final class PackageBytes extends SimplePackage{


		/**
		 *  报头长度包括报文包头12bytes+协议头
		 */
		public static const HEAD_LENGTH:uint = 12;

		/**
		 *  报文长度限制(包括http头,包头,报文实体) 
		 */
		public static const MAX:uint = 4096;




		/**
		 * 	通信协议包体定义：
		 * 	http协议头
		 *	包头:数据长度[2],效验码[4],版本号[2],
		 * 		终端类型[1],服务端类型[1]，报文ID[2]
		 * 	报文内容以事件形式发布，包含必要信息和实体数据
		 * 	构造函数建立通信包体，低位在前(littleEndian)
		 * 	简单模式下，内容仅仅为报文实体，更改低位在前，不包含包头和加密运算
		 * 	此类的父类SimplePackage为该类的简单模式
		 * 
		 */
		public function PackageBytes(){
			super();   position = HEAD_LENGTH;
		}
		
		
		
		/**
		 * 四位异或加密
		 * @param offset 异或偏移值，
		 * @param key1Buffer 密钥1偏移缓存
		 * @param key2Buffer 密钥2偏移缓存
		 * 
		 */		 
		public function xor(offset:int, key1Buffer:int, key2Buffer:int):void{
			if (key1Buffer==0 && key2Buffer==0) return;
			var len:int = this.length-offset;
			var blocks:int = len>>2;			//int(len/4)
			var remainByte:int = len&3;		//int(len%4)
			var xkey:SimplePackage = new SimplePackage();
			xkey.writeInt(key1Buffer^key2Buffer);
			for (var i:uint = 0; i < blocks; i++){
				for (j = 0; j < 4; j++){
					this[offset + (i<<2) + j] ^= xkey[j];
				}
			}
			if (remainByte > 0){
				for (var j:uint = 0; j < remainByte; j++){
					this[offset + (blocks<<2) + j] ^= xkey[j];
				}
			}		
		}
		
		
		
		/**
		 * @return 计算crc校验码
		 * 
		 */
		public function get crc():uint{
			var len:uint = (this[1]<<8)+this[0];
			var blocks:int = len>>2;			//int(len/4)
			var remainByte:int = len&3;		//int(len%4)
			var des:SimplePackage = new SimplePackage();
			var tmpBlock:SimplePackage = new SimplePackage();
			for (var m:uint=0; m<4; m++){
				des[m] = tmpBlock[m] = 0;
			}
			for (var i:uint=0; i<blocks; i++){
				for (var j:uint=0; j<4; j++){
					des[j] ^= this[(i<<2) + j];
				}
			}
			if (remainByte > 0){
				tmpBlock.writeBytes(this,blocks<<2,remainByte);
				for(var s:uint=remainByte; s<4; s++){
					tmpBlock.writeByte(0);
				}
				for (var k:uint=0; k<4; k++){
					des[k] ^= tmpBlock[k];
				}
			}
			return des.readUnsignedInt();
		}
		
		
		
		/**
		 *	按littleEndian规则替换crc校验码
		 *	包头:数据长度[2],效验码[4],版本号[2],
		 * 		终端类型[1],服务端类型[1]，报文ID[2]
		 * @param crcCode 将被替换用的crc校验码
		 * 
		 */		
		public function changeCrc(crcCode:uint):void{
			this[2] = crcCode & 0xFF;
			this[3] = (crcCode >> 8) & 0xFF;
			this[4] = (crcCode >> 16) & 0xFF;
			this[5] = (crcCode >> 24) & 0xFF;	
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
}