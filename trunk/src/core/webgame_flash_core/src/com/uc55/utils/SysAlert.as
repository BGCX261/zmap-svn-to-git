package com.uc55.utils{
	import mx.controls.Alert;
	import com.uc55.utils.Localizator;
    
	public class SysAlert{
		
		[Bindable]   
    	private var localizator:Localizator= Localizator.getInstance();
    	
		public function SysAlert():void{
			
		}
		
		public function show(id:String):void{
			Alert.okLabel="确定";
			Alert.cancelLabel="取消";
			Alert.noLabel="取消";
			Alert.yesLabel="确定";
			Alert.show(localizator.getText(String(id)));
		}
		
		private static var instance:SysAlert;
		
		public static function getInstance():SysAlert{
			if(instance==null){
				instance=new SysAlert();
			}
			return instance;
		}
	}
}
