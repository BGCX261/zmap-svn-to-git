package com.redbaby.game.view{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	public class ViewManager{
		
		private var _uiDict:Object;
		private var _voDict:Object;
		
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
