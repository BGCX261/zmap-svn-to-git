/*************************************
 * System接口
 * @usage System接口类
 * @author ZeR
 * @since 09.09.24
 * @version 1.0
 *************************************/
package com.redbaby.game.allInterface{
	import flash.display.DisplayObject;
	
	public interface ISystem{
		public function ISystem():void;
		
		function roleSelectInit():void;//角色创建初始化
		
		function showProgress():void;//显示进度条
		
		function hideProgress():void;//隐藏进度条
		
		function showMessage():void;//显示信息
		
		function addChild(comp:DisplayObject):DisplayObject;//添加显示对象
	}
}
