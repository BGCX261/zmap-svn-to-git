package com.uc55.view{
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	
	public class UIWindow extends TitleWindow{
		
		private var head:Canvas;
		private var closeButton:Button;
		
		public function UIWindow():void{
			head=new Canvas();
			head.styleName="CurrencyHeadSkin";
			head.width=139;
			head.height=31;
			this.addChild(head);
			this.setChildIndex(head,0);
			this.showCloseButton=true;
			this.styleName="CurrencyOutlineSkin";
			//closeButton=new Button();
			//closeButton.width=24;
			//closeButton.height=24;
			//closeButton.y=5;
			//closeButton.styleName="CurrencyCloseButton";
			//closeButton.buttonMode=true;
			//closeButton.addEventListener(MouseEvent.CLICK,onCloseButton);
			//this.addChild(closeButton);
			//this.setChildIndex(closeButton,numChildren-1);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
   			this.titleBar.addEventListener(MouseEvent.MOUSE_DOWN,panelDragStart);
    		this.titleBar.addEventListener(MouseEvent.MOUSE_UP,panelDragStop);
       		this.titleBar.addEventListener(MouseEvent.CLICK,panelClick);
		}
		
		private function panelClick(e:MouseEvent):void{
			setTop();
		}
		
		private function setTop():void{
			this.parent.setChildIndex(this,this.parent.numChildren-1);
		}
		
		private function panelDragStart(e:MouseEvent):void{
	    	this.startDrag();
	    	this.alpha=.5;
	    }
	  
	   	private function panelDragStop(e:MouseEvent):void{
			this.stopDrag();
			this.alpha=1;
	   	}
	   	
	   	public function setPos(w:int,h:int):void{
	   		this.x=(1000-w)*0.5;
	   		this.y=(600-h)*0.5;
	   		head.x=(w-139)*0.5;
	   		//closeButton.x=w-30;
	   		top();
	   	}
		
		public function addComp(target:*,ui:*):void{
			target.removeAllChildren();
			target.addChild(ui);
		}
		
		private function onCloseButton(e:MouseEvent):void{
			close();
		}
		
		public function close(target:*=null):void{
			if(target){
				target.removeAllChildren();	
			}
			
			this.visible=false;
		}
	}
}
