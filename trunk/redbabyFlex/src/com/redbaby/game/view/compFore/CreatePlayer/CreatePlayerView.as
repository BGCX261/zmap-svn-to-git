/**************************************************
 * @usage 角色创建界面,首先发送获得角色命令获取角色
 * 		  用户已有角色时展示角色,未有角色时显示创建角色模式
 * @author ZeR
 * @since 09.09.29
 * @version 1.0
 * 
 * 
 * @see 缺少角色创建代码,缺少获取角色时的ProgressBar显示
 **************************************************/ 
package com.redbaby.game.view.compFore.CreatePlayer{
	import com.redbaby.API;
	import com.redbaby.game.core.net.CodeEvent;
	import com.redbaby.game.core.net.config.ConnRID;
	import com.redbaby.game.core.net.config.ConnSID;
	import com.redbaby.game.core.net.config.ServerID;
	import com.redbaby.game.core.net.pack.SimplePackage;
	import com.redbaby.game.data.UserData;
	import com.redbaby.game.debug.DebugColor;
	import com.redbaby.game.system.Core;
	import com.redbaby.game.view.ViewPredef;
	import com.redbaby.game.view.compDebug.DebugUI;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.TextInput;
	
	public class CreatePlayerView extends Canvas{
		public var roleName:TextInput;
		public var createRoleBtn:Button;
		public var playGameBtn:Button;
		
		public function CreatePlayerView():void{
			
		}
		
		protected function creationCompleteHandle():void{
			
		}
		
		public function initView():void{
			visible=true;
			getRole();
		}
		
		private function getRole():void{
			var pack:SimplePackage = new SimplePackage();
			pack.writeInt(UserData.getInstance().UserID);
			API.Server.addEventListener(ConnRID.GET_ROLE_RESULT,getRoleResult);
			API.Server.sendPackage(ConnSID.GET_ROLE,ServerID.LoginServer,pack);
		}
		
		private function getRoleResult(e:CodeEvent):void{
			var pack:SimplePackage = e.data;
			var result:int=pack.readByte();
			if(result==0){
				DebugUI.getInstance().log("角色选择","有角色",DebugColor.NORMAL);
				UserData.getInstance().RoleName=pack.readStr();
				DebugUI.getInstance().log("角色选择","获取角色名:"+UserData.getInstance().RoleName,DebugColor.NORMAL);
				playGameBtn.visible=true;
			}else if(result==1){
				DebugUI.getInstance().log("角色选择","没有角色",DebugColor.WARN);
				createRoleBtn.visible=true;
			}else if(result==2){
				DebugUI.getInstance().log("角色选择","获取出错",DebugColor.ERROR);
			}
		}
		
		protected function createRoleHandle():void{
			var pack:SimplePackage = new SimplePackage();
			pack.writeStr(roleName.text);
			pack.writeByte(1);
			pack.writeShort(0);
			pack.writeShort(0);
			pack.writeShort(0);
			pack.writeShort(0);
			API.Server.addEventListener(ConnRID.CREATE_ROLE_BACK,createRoleResult);
			API.Server.sendPackage(ConnSID.CREATE_ROLE,ServerID.LoginServer,pack);
		}
		
		private function createRoleResult(e:CodeEvent):void{
			var pack:SimplePackage = e.data;
			if(pack.readByte()==0){
				DebugUI.getInstance().log("角色选择","角色创建成功",DebugColor.NORMAL);
			}else{
				DebugUI.getInstance().log("角色选择","角色创建失败",DebugColor.ERROR);
			}
		}
		
		protected function playGameHandle():void{
			var pack:SimplePackage = new SimplePackage();
			DebugUI.getInstance().log("角色开始游戏","角色名:"+UserData.getInstance().RoleName,DebugColor.NORMAL);
			pack.writeStr(UserData.getInstance().RoleName);
			API.Server.addEventListener(ConnRID.PLAY_GAME_RESULT,playGameResult);
			API.Server.sendPackage(ConnSID.PLAY_GAME,ServerID.RoleServer,pack);
		}
		
		private function playGameResult(e:CodeEvent):void{
			var pack:SimplePackage = e.data;
			if(pack.readByte()==0){
				DebugUI.getInstance().log("角色开始游戏","成功",DebugColor.NORMAL);
				Core.getInstance().view.getUI(ViewPredef.MAIN_LAYER);
				Core.getInstance().view.getUI(ViewPredef.PANEL_LAYER);
				Core.getInstance().view.hide(ViewPredef.LOGIN_LAYER);
			}else{
				DebugUI.getInstance().log("角色开始游戏","失败",DebugColor.ERROR);
			}
		}
	}
}
