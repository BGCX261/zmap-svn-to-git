package com.uc55.view{
	import com.uc55.vo.UIPropVO;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import com.uc55.view.ViewManager;
	
	public class UIBase extends SimpleCanvas{
		
		public var uiList:Array;
		
		private var _last:Boolean;
		private static var _totalCount:int;
		private static var _currentCount:int
		
		public static const CREATE_LIST_COMPLETE:String="UI_EVENT_CREATE_LIST_COMPLETE";
		
		private static var _title:String;
		
		public function UIBase():void{
			uiList=new Array();
			_totalCount=-1;
			addEventListener(FlexEvent.CREATION_COMPLETE,nextHandel);
		}
		
		//稍后再创建,只addVO
		private function createLater(vo:UIPropVO):void{
			_last=vo.isLast;
			if(vo.type!=null){
				_title=vo.type;
				_totalCount=-1;
			}
			vo.parent=this;
			ViewManager.getInstance().addVO(vo.vid,vo);
			createNext();
		}
		
		//立刻创建,直接addUI
		private function initUI(vo:UIPropVO):void{
			var prop:Object;
			var style:Object;
			
			_last=vo.isLast;

			if(vo.type!=null){
				_title=vo.type;
				_totalCount=-1;
			}
			
			var ui:*=new vo.cls;
			var uibase:*=ui as UIBase;
			
			if(uibase){
				uibase.addEventListener(CREATE_LIST_COMPLETE,nextHandel);
			}else{
				ui.addEventListener(FlexEvent.CREATION_COMPLETE,nextHandel);
			}
			
			addChild(ui);
			
			
			for(prop in vo.prop){
				ui[prop]=vo.prop[prop];
			}
			
			for(style in vo.style){
				ui.setStyle(style.toString(),vo.style[style].toString());
			}
			trace(vo.initVisible);
			ViewManager.getInstance().addUI(vo.vid,ui,vo.initVisible);
			
			createNext();
		}
		
		private function nextHandel(e:Event):void{
			e.currentTarget.removeEventListener(FlexEvent.CREATION_COMPLETE, nextHandel);
			e.currentTarget.removeEventListener(CREATE_LIST_COMPLETE, createNext);
			createNext();
		}
		
		private function createNext():void{
			if(_totalCount<0){
				_totalCount=uiList.length;
				_currentCount=0;
			}
			var vo:UIPropVO=uiList.shift();
			_currentCount++;
			
			if(vo){
				trace("======================添加界面========================");
				trace(vo.cls);
				if(vo.createLater){
					createLater(vo);
				}else{
					initUI(vo);
				}
			}else{
				dispatchEvent(new Event(CREATE_LIST_COMPLETE));
				if(_last){
					
				}
			}
		}
	}
}
