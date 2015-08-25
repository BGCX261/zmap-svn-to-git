package com.redbaby.game.core.net{
	
	import com.redbaby.game.allInterface.IServer;
	import com.redbaby.game.core.error.SimpleClassError;
	import com.redbaby.game.core.net.pack.*;
	import com.redbaby.game.debug.DebugBuff;
	import com.redbaby.game.debug.DebugColor;
	import com.redbaby.game.events.CommonEventDispatcher;
	import com.redbaby.game.rpc.SocketManager;
	import com.redbaby.game.view.compDebug.DebugUI;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	/**
	 *	游戏服务器连接通信类，提供客户端到服务端的通信功能。
	 * 	以函数形式递交，以监听形式等待服务端回应。 
	 * @author 黄侃 2009.9
	 * 
	 */
	public class ServiceConnection	extends EventDispatcher implements IServer{
		
		
		private static const socket:ClientSocket = new ClientSocket();
		
		/**
		 *	单件模式实例，通过全局方式获得该类实例。 
		 */		
		public static const instance:ServiceConnection = new ServiceConnection();
		/**
		 *	单件模式，不可直接创建，如创建将引发错误。 
		 * 
		 */
		public function ServiceConnection()	{
			if (instance) throw new SimpleClassError();
		}
		
		
		
		
		
		/**
		 *	连接函数，连接到指定的游戏服务器 
		 * @param host 服务器IP地址
		 * 
		 */
		public function connect(host:String):void{
			if (socket.connected) return;
			socket.connect(host);
			socket.addEventListener(Event.COMPLETE,onConnect);
			socket.addEventListener(PackageEvent.PACKAGE,receivePackage);
		}
		
		private function onConnect(e:Event):void{
			try{
				DebugUI.getInstance().log("Socket","服务器已连接",DebugColor.KEY);
			}catch(e:Error){
				var info:Object=new Object();
				info.tag="Socket";
				info.msg="服务器已连接";
				info.clr=DebugColor.KEY;
				DebugBuff.Buff.push(info);
			}
			dispatchEvent(new Event(Event.CONNECT));
			CommonEventDispatcher.getInstance().dispatchEvent(new Event(SocketManager.RPC_OK));
		}

		public function sendPackage(id:uint,serverID:uint,
		pack:SimplePackage=null):void{
			socket.serverID = serverID;
			socket.sendPackage(id,pack);
		}

		private function receivePackage(e:PackageEvent):void{
			var id:String = "0x"+e.id.toString(16);
			try{
				DebugUI.getInstance().log("Socket","收到命令 "+e.id,DebugColor.KEY);
			}catch(e:Error){
				var info:Object=new Object();
				info.tag="Socket";
				info.msg="收到命令 "+e.id;
				info.clr=DebugColor.KEY;
				DebugBuff.Buff.push(info);
			}
			dispatchEvent(new CodeEvent(id,e.packageBytes));
		}
		
		
		
//		/**
//		 *	注册函数，提交新的用户名密码，在服务端注册一个新的账号
//		 * @param un 用户名
//		 * @param psd 用户密码
//		 * @param code 注册验证码
//		 * @event register:LogEvent - 在注册成功或失败后调度
//		 * 
//		 */
//		public function register(un:String,psd:String,code:uint):void{
//			var pack:SimplePackage = new SimplePackage();
//			pack.writeStr(un);											//用户名str
//			pack.writeStr(psd)											//用户密码32bytes
//			pack.writeUnsignedInt(code);						//验证码4bytes
//			socket.sendPackage(0x102,pack);					//发送报文
//		}
//		private function respondRegister(pack:SimplePackage):void{
//			var logEvent:LogEvent = new LogEvent(LogEvent.REGISTER);
//			if ((logEvent.infoID=pack.readByte()) == 0) logEvent.success=true;
//			logEvent.info = Info.RESPOND_REGISTER[logEvent.infoID];
//			dispatchEvent(logEvent);
//		}
		
		
		
		/**
		 *	登陆函数，提交正确的用户名与密码，登陆到游戏服务器
		 * @param un 登陆用户名
		 * @param psd 登陆密码
		 * 
		 * @event login:LogEvent - 在登陆成功或失败后调度 
		 * 
 		 */
//		public function login(un:String,psd:String):void{
//			var pack:SimplePackage = new SimplePackage();
//			pack.writeStr(un);														//用户名str
//			pack.writeStr(MD5.hash(psd));									//用户密码32bytes
//			socket.sendPackage(0x103,pack);								//发送报文
//		}
//		private function respondLogin(pack:SimplePackage):void{
//			var logEvent:LogEvent = new LogEvent(LogEvent.LOGIN);
//			if ((logEvent.infoID=pack.readByte()) == 0){
//				logEvent.success=true;
//				trace("用户数字ID",pack.readInt());
//			} 
//			logEvent.info = Info.RESPOND_LOGIN[logEvent.infoID];
//			dispatchEvent(logEvent);
//		}
//		
//		
//		
//		/**
//		 * 	注销函数，退出游戏服务器。
//		 *	@event logout:LogEvent - 在注销成功或失败后调度
//		 *  
//		 */
//		public function logout():void{
//			socket.sendPackage(0x104);
//		}
//		private function respondLogout(pack:SimplePackage):void{
//			var logEvent:LogEvent = new LogEvent(LogEvent.LOGOUT);
//			logEvent.success = pack.readBoolean();
//			dispatchEvent(logEvent);
//		}
//		
		
		
		
//		/**
//		 *	修改权限资料，将修改后的权限保存到服务器 
//		 * @param purview 权限对象
//		 * @event change:PurviewEvent - 当服务器返回操作结果时调度
//		 * 
//		 */
//		public function editPurview(purview:Purview):void{
//			var pack:SimplePackage = new SimplePackage();
//			pack.writeByte(purview.details);
//			pack.writeByte(purview.myhome);
//			pack.writeByte(purview.addFriend);
//			socket.sendPackage(0x301,pack);
//		}
//		private function changePurview(pack:SimplePackage):void{
//			dispatchEvent(new ServiceEvent(PurviewEvent.CHNAGE));
//		}
//
//
//		/**
//		 *	编辑用户资料，将修改后的资料保存到服务器 
//		 * @param details 用户资料对象
//		 * @event change:DetailsEvent - 当服务器返回操作结果时调度
//		 */
//		public function editDetails(details:UserDetails):void{
//			var pack:SimplePackage = new SimplePackage();
//			var maskCode:uint = (1<<13)-1;								//暂时为13条记录
//			pack.writeStr(details.sex);											//性别0
//			pack.writeDouble(details.birthday.valueOf());		//生日1
//			pack.writeStr(details.bloodType);								//血型2
//			pack.writeStr(details.constellation);						//星座3
//			pack.writeStr(details.country);									//国家4
//			pack.writeStr(details.province);								//省5
//			pack.writeStr(details.city);										//城市6
//			pack.writeStr(details.mobile);									//手机7
//			pack.writeStr(details.email);										//邮箱8
//			pack.writeStr(details.pro);											//职业9
//			pack.writeStr(details.graduateSchool);					//毕业院校10
//			pack.writeStr(details.hobby);										//爱好11
//			pack.writeStr(details.acceptAD);								//允许广告12
//		}






		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}