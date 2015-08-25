package com.uc55.config{
	public class SysHost{
		
		//服务器IP&PORT
		private var _RPC_IP:String;
		private var _RPC_PORT:int;
		private var _DOMAIN_PORT:int;
		
		private var _LOGO:String="logo.png";
		private var _CONFIG_FILE:String="config.dat";
				
		//资源服务器地址
		private var _RES_URL:String;
		//注册用户地址
		private var _REG_URL:String;
		//官网地址
		private var _INDEX_URL:String;
		
		//游戏数据文件地址
		private var _GAMEDATA_URL:String;
		
		//DAT文件地址
		private var _DAT_URL:String;
		
		//服务器公告地址
		private var _NOTICE_URL:String;
		
		private static var instance:SysHost;
		
		public function init(obj:Object):void{
			_RPC_IP=obj.ip;
			_RPC_PORT=int(obj.port);
			_DOMAIN_PORT=int(obj.domain);
			_RES_URL=obj.res_url;
			_REG_URL=obj.reg;
			_INDEX_URL=obj.index;
			_NOTICE_URL=obj.notice;
			_DAT_URL=obj.dat;
		}
		
		public static function getInstance():SysHost{
			if(instance==null){
				instance=new SysHost();
			}
			return instance;
		}
		
		public function SysHost():void{
			
		}
		
		public function get RPC_IP():String{
			return _RPC_IP;
		}
		
		public function get RPC_PORT():int{
			return _RPC_PORT;
		}
		
		public function get DOMAIN_PORT():int{
			return _DOMAIN_PORT;
		}
		
		public function get RES_URL():String{
			return _RES_URL;
		}

		public function get GAMEDATA_URL():String{
			return _GAMEDATA_URL;
		}
		
		public function get CONFIG_FILE():String{
			return _CONFIG_FILE;
		}
		
		public function get NOTICE_URL():String{
			return _NOTICE_URL;
		}

		public function get LOGO():String{
			return _LOGO;
		}
		
		public function get DAT_URL():String{
			return _DAT_URL;
		}
	}
}
