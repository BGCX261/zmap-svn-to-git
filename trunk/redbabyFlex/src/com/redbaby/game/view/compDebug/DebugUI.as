package com.redbaby.game.view.compDebug{
	import com.redbaby.game.allInterface.IDebug;
	import com.redbaby.game.debug.Debug;
	import com.redbaby.game.debug.DebugBuff;
	import com.redbaby.game.debug.DebugColor;
	import com.redbaby.game.system.Core;
	import com.redbaby.game.utils.Time;
	import com.redbaby.game.view.UIWindow;
	import com.redbaby.game.view.ViewPredef;
	
	import flash.events.KeyboardEvent;
	
	import mx.controls.TextArea;
	
	public class DebugUI extends UIWindow implements IDebug{
		
		public var info:TextArea;
		
		private static var instance:DebugUI;
		
		private var _debugClr:DebugColor;
		
		private var _buff:Array;
		
		private var _root:*;
		
		public function DebugUI():void{
			DebugClr=new DebugColor();
		}
		
		protected function createionCompleteHandle():void{
			setPos(this.width,this.height);
			_root=this.parentApplication;
			
			DebugUI.getInstance().log("调试器","调试器启动...",DebugColor.NORMAL);
			if(Debug.DEBUGGING){
				if(Debug.DEBUG_MODE==Debug.NET){
					DebugUI.getInstance().log("调试器","联网调试模式",DebugColor.NORMAL);
				}else{
					DebugUI.getInstance().log("调试器","本地调试模式",DebugColor.WARN);
				}
			}
			
			for(var i:int=0;i<DebugBuff.Buff.length;i++){
				var info:Object=DebugBuff.Buff[i];
				DebugUI.getInstance().log(info.tag,info.msg,info.clr);
			}
			
			DebugBuff.Buff=[];
			
			if(Debug.DEBUG_MODE){
				_root.stage.addEventListener(KeyboardEvent.KEY_UP, checkShowDebug);
			}
		}
		
		private function checkShowDebug(e:KeyboardEvent):void{
			if (e.keyCode == 81 && e.ctrlKey == true) {
            	this.visible=!this.visible;
            }
		}
		
		public function getColorPrint(tag:String,clr:String,msg:String):String{
			return "<a href='http://www.baidu.com' target='_blank'><font color=\'"+clr+"\'>["+tag+"]"+msg+"    ["+Time.getClientTimeStr()+"]</font></a>";
		}
		
		protected function clearInfo():void{
			info.text="";
		}
		
		public function log(tag:String,msg:Object,clr:String=DebugColor.NORMAL):void{
			if(info){
				info.htmlText+=this.getColorPrint(tag,clr,String(msg))+"<br>";
			}else{
				_buff.push(this.getColorPrint(tag,clr,String(msg))+"<br>");
			}
			trace("["+tag+"]",msg,"["+Time.getClientTimeStr()+"]")
		}
		
		public static function getInstance():DebugUI{
			if(instance==null){
				instance=Core.getInstance().view.getUI(ViewPredef.DEBUG_WINDOW) as DebugUI;
			}
			return instance;
		}
		
		public function get DebugClr():DebugColor{
			return _debugClr;
		}
		
		public function set DebugClr(x:DebugColor):void{
			_debugClr=x;
		}
	}
}