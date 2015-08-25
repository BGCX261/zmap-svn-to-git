package com.uc55.view{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	public class ViewManager{
		
		private var _uiDict:Object;
		private var _voDict:Object;
		
		public static const LOGIN_LAYER:uint=100;
		public static const MAIN_LAYER:uint=101;
		public static const PANEL_LAYER:uint=102;
		
		public static const LOGIN_CANVAS:uint=200;
		public static const LOADING_CANVAS:uint=201;
		public static const CREATOR_CANVAS:uint=202;
		
		public static const CITY_CANVAS:uint=203;
		public static const CHAT_CANVAS:uint=204;
		public static const CMD_CANVAS:uint=205;
		public static const RES_CANVAS:uint=206;
		public static const R_BAN_CANVAS:uint=207;
		public static const DETAIL_CANVAS:uint=208;
		
		public static const FRAME_WINDOW:uint=209;
		public static const CITY_DEF_CANVAS:uint=210;
		public static const PUB_CANVAS:uint=211;
		public static const TECHNOGIC_CANVAS:uint=212;
		public static const ENGAGE_HERO_CANVAS:uint=213;
		public static const BARBACK_CANVAS:uint=214;
		public static const BUILD_TREE:uint=215;
		public static const HERO_ARRTIBUTE_VIEW:uint=216;
		public static const ATTRIBUTES_CANVAS:uint=217;
		public static const DISSOLUTION_CANVAS:uint=218;
		public static const RENAME_PANEL:uint=219;
		public static const HERO_CHANGE_NAME_PANEL:uint=220;
		
		private var _stage:Stage;
		
		
		public function ViewManager():void{}
		
		/**
		 * @id	视图UI的ID
		 * @ui	视图UI
		 * @show	是否显示
		 **/  
		public function addUI(id:uint,ui:DisplayObject,dis:Boolean):void{
			if(_uiDict[id]==null){
				_uiDict[id]=new Object();
			}
			_uiDict[id]=ui;
			ui.visible=dis;
		}
		
		/**
		 * @id	视图UI的ID
		 * @vo	视图对象的属性VO
		 **/ 
		public function addVO(id:uint,vo:Object):void{
			_voDict[id]=vo;
		}
		
		public function getVO(id:uint):Object{
			return _voDict[id];
		}
		
		/**
		 * 显示
		 **/ 
		public function show(id:uint):void{
			_uiDict[id].visible=true;
		}
		
		/**
		 * 隐藏
		 **/ 
		public function hide(id:uint):void{
			_uiDict[id].visible=false;
		}
		
		/**
		 * 设置视图显示状态
		 **/ 
		public function setVisible(id:uint,dis:Boolean):void{
			var ui:*=getUI(id);
			if(ui){
				ui.visible=dis;
			}
		}
		
		/**
		 * 变换视图显示状态
		 **/ 
		public function changeVisible(id:uint):void{
			var ui:*=getUI(id);
			if(ui){
				ui.visible=!ui.visible;
			}
		}
		
		/**
		 * 取得UI
		 **/ 
		public function getUI(id:uint):Object{
			if(!_uiDict[id]){
				createUI(id);
			}
			return _uiDict[id];
		}
		
		/**
		 * 创建视图
		 **/ 
		public function createUI(id:uint):void{
			var vo:Object;
			var ui:Object;
			var prop:Object;
			var style:Object;
			
			if(_voDict[id] && _voDict[id].cls){
				vo=_voDict[id];
				ui=new vo.cls;
				
				_uiDict[id]=ui;
				
				for(prop in vo.prop){
					ui[prop]=vo.prop[prop];
				}
				
				for(style in vo.style){
					ui.setStyle(style.toString(),vo.style[style].toString());
				}
				
				if(vo.initVisible){
					vo.parent.addChild(ui);
				}else{
					//ui.container=vo.parent;
				}
				
			}
		}
		
		public function removeView(ui:*):void{
			ui.parent.removeChild(ui);
		}
		
		/**
		 * @stage:主场景引用
		 **/ 
		public function init(stage:Stage):void{
			_uiDict={};
			_voDict={};
			_stage=stage;
		}
		
		/**
		 * 单例
		 **/ 
		public static function getInstance():ViewManager{
			if(instance==null){
				instance=new ViewManager();
			}
			return instance;
		}
		
		private static var instance:ViewManager;
	}
}
