/**
 * 自定义Flex系统初始化加载界面
 * 
 */
package com.redbaby.ui.view{
	import com.redbaby.game.config.SysHost;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;
	
	public class redbabyLoader extends DownloadProgressBar{
		private var txt:TextField;
		private var _preloader:Sprite;
		private var _l:Loader;
		private var _count:int;
		public function redbabyLoader():void{
			_l=new Loader();
			var logo:String=SysHost.getInstance().LOGO;
			_l.load(new URLRequest(logo));
			_l.contentLoaderInfo.addEventListener(Event.COMPLETE,onLogoLoaded);
			var style:TextFormat = new TextFormat(null,null,0xed1c24,null,null,null,null,null,"center");   
            txt = new TextField();   
            txt.defaultTextFormat = style;   
            txt.width = 200;   
            txt.selectable = false;   
            txt.height = 20; 
			addChild(txt);
			addChild(_l);
			super();
		}//end function
		
		private function onLogoLoaded(e:Event):void{
			var timer:Timer=new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.start();
		}
		
		private function onTimer(e:TimerEvent):void{
			if(_count>1){
				e.currentTarget.stop();
				e.currentTarget.removeEventListener(TimerEvent.TIMER,onTimer);
				remove();
				dispatchEvent(new Event(Event.COMPLETE));
			}
			_count++;
		}
		
		override public function set preloader(value:Sprite):void{
			_preloader=value;
			_preloader.addEventListener(ProgressEvent.PROGRESS,load_progress);
			_preloader.addEventListener(Event.COMPLETE,load_complete);
			_preloader.addEventListener(FlexEvent.INIT_PROGRESS,init_progress);
			_preloader.addEventListener(FlexEvent.INIT_COMPLETE,init_complete);
			
			stage.addEventListener(Event.RESIZE,resize);
			resize(null);
		}//end function
		
		private function load_progress(e:ProgressEvent):void{
			txt.text = "正在加载..."+int(e.bytesLoaded/e.bytesTotal*100)+"%"; 
		}
		
		private function load_complete(e:Event):void{
			txt.text = "加载完毕!";
		}
		
		private function init_progress(e:FlexEvent):void{
			txt.text = "正在初始化...";
		}
		
		private function init_complete(e:FlexEvent):void{
			txt.text = "初始化完毕";
		}
		
		private function resize(e:Event):void{
			txt.x = (stage.stageWidth - txt.width)/2;   
            txt.y = (stage.stageHeight-txt.height)/2; 
            _l.x = (stage.stageWidth - 313)/2;   
            _l.y = (stage.stageHeight-86)/2-50;  
			graphics.clear();   
            graphics.beginFill(0xffffff);   
            graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);   
            graphics.endFill();   

		}
		
		private function remove():void{   
            _preloader.removeEventListener(ProgressEvent.PROGRESS,load_progress);   
            _preloader.removeEventListener(Event.COMPLETE,load_complete);   
            _preloader.removeEventListener(FlexEvent.INIT_PROGRESS,init_progress);   
            _preloader.removeEventListener(FlexEvent.INIT_COMPLETE,init_complete);   
            stage.removeEventListener(Event.RESIZE,resize)   
        }   
	}
}
