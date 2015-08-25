package com.uc55.game.view.login{
	import com.uc55.game.config.ViewPredef;
	import com.uc55.game.utils.AccountSo;
	import com.uc55.system.Core;
	import com.uc55.ui.view.comp.login.CapGroup;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.CheckBox;
	import mx.controls.ComboBox;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.events.ResizeEvent;
	
	public class LoginView extends Canvas{
		public var password:TextInput;
		public var account:ComboBox;
		public var logo:Image;
		public var loginPanel:Canvas;
		public var blog:Label;
		public var web:Label;
		public var gcode:Label;
		public var author:Label;
		public var CapGroupCanvas:Canvas;
		public var bg:Image;
		public var saveAccount:CheckBox;

		protected function initView():void{
			this.addEventListener(ResizeEvent.RESIZE,initPos);
			initPos();
			initComp();
			addComp();
			getAccount();
		}
		
		private function getAccount():void{
			var so:Object=AccountSo.getInstance().getAccount();

			if(so.account){
				account.text=so.account;
				password.text=so.password;
				saveAccount.selected=true;
			}
		}
			
		private function initPos(e:ResizeEvent=null):void{
			var sizeW:int=parentApplication.width;
			var sizeH:int=parentApplication.height;
				
			logo.x=(sizeW-logo.width)*0.5;
				
			loginPanel.x=(sizeW-loginPanel.width)*0.5
				
			blog.x=(sizeW-blog.width-5);
				
			web.x=(sizeW-web.width-blog.width-30);
				
			gcode.y=(sizeH-gcode.height)-60;
			gcode.x=(sizeW-gcode.width)*0.5;
				
			author.y=(sizeH-author.height)-30;
			author.x=(sizeW-author.width)*0.5;
				
			CapGroupCanvas.x=(sizeW-CapGroupCanvas.width)*0.5-37;
		}
			
		private function initComp():void{
			var myClass:Class=lpb;
			var bitmapData:BitmapData=new myClass(60,60) as BitmapData;
	        var bitmap:Bitmap=new Bitmap(bitmapData);
			bg.source=bitmap;
		}
			
		private function addComp():void{
			CapGroupCanvas.addChild(new CapGroup());
		}
		
		protected function loginHandel():void{
			if(saveAccount.selected){
				AccountSo.getInstance().saveAccount(account.text,password.text);
			}else{
				AccountSo.getInstance().clearAccount();
			}
			if(password.text==""||account.text==""){
				Alert.show("Please Enter Account or Password First...","Tip");
			}else{
				var _core:Core=Core.getInstance();
				_core.view.getUI(ViewPredef.MAIN_LAYER);
				_core.view.getUI(ViewPredef.PANEL_LAYER);
				_core.view.removeView(this);
			}
		}
		
		protected function saveSelect():void{
			if(saveAccount.selected){
				Alert.show("This option is used with caution.","Warning");
			}
		}
	}
}
