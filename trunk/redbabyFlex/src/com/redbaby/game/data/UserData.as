/*******************************************************
 * 角色数据类
 * @usage 用于用户角色数据的存与取
 * @since 09.09.24
 * @author ZeR.
 * @version 1.0
 *******************************************************/
package com.redbaby.game.data{
	import flash.events.EventDispatcher;
	import com.redbaby.game.events.UserDataEvent;
	
	public class UserData extends EventDispatcher{
		private var _roleName:String="ZeR";//角色名
		
		private var _roleId:String;//角色ID
		
		private var _money:Number;//角色金币
		
		private var _userName:String;//用户名
		
		private var _userId:uint;//用户ID
		
		private var _bodyId:String;//形象ID
		
		private var _avatar:XML;//形象数据
		
		private var _mapId:String;//地图ID
		
		private static var isSimple:Boolean=true;
		
		private static var instance:UserData;
		
		public function UserData():void{
			_roleName="ZeR";
			_money=0;
		}
		
		/**
		 * 角色ID设置
		 * @param	x 参数角色ID
		 */
		public function setRoleId(x:String):void{
			this._roleId=x;
		}
		
		/**
		 * 角色形象ID设置
		 * @param	x 参数角色形象ID
		 */
		public function setBodyId(x:String):void {
			this._bodyId = x;
		}
		
		/**
		 * 用户名设置
		 * @param	x 用户名
		 */
		public function setUserName(x:String):void {
			this._userName = x;
		}
		
		/**
		 * 形象数据设置
		 * @param	x 数据XML
		 */
		public function setAvatar(x:XML):void {
			this._avatar = x;
		}
		
		/**
		 * 角色名设置
		 * @param	x 角色名
		 */
		public function set RoleName(x:String):void {
			this._roleName = x;
		}
		
		/**
		 * 用户ID设置
		 * @param	x 用户ID
		 */
		public function set UserID(x:uint):void {
			this._userId = x;
		}
		
		/**
		 * 用户积分设置
		 * @param	x 用户积分
		 */
		public function setMoney(x:Number):void {
			this._money = x;
			//当注册了金币数量变更事件时触发
			if (this.hasEventListener(UserDataEvent.MONEY_CHANGE)) {
				/**@see无数据携带**/
				dispatchEvent(new UserDataEvent(UserDataEvent.MONEY_CHANGE, null ));
			}
		}
		
		public function setMapID(x:String):void {
			this._mapId = x;
		}
		
		/**
		 * 返回地图名
		 * @see 未有真实数据,数据为模拟
		 */
		public function get mapName():String {
			return "shop";
		}
		
		/**
		 * 返回角色名
		 */
		public function get RoleName():String {
			return _roleName;
		}
		
		/**
		 * 返回角色积分
		 */
		public function get money():Number {
			return _money;
		}
		
		/**
		 * 返回用户ID
		 */
		public function get UserID():uint {
			return _userId;
		}
		
		/**
		 * 返回角色数据
		 */
		public function get avatar():XML {
			return _avatar;
		}
		
		/**
		 * 返回角色ID
		 */
		public function get roleID():String {
			return _roleId;
		}
		
		/**
		 * 返回角色名
		 */
		public function get userName():String {
			return _userName;
		}
		
		/**
		 * 返回地图ID
		 */
		public function get mapID():uint {
			return 1;
		}
		
		/**
		 * 返回形象ID
		 */
		public function get bodyID():String {
			return _bodyId;
		}
		
		public static function getInstance():UserData {
			if (instance == null) {
				instance = new UserData();
			}
			return UserData.instance;
		}
	}
}
