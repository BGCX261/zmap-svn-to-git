package com.uc55.game.view.panel{
	import com.uc55.view.UIWindow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import riaidea.utils.zip.ZipArchive;
	import riaidea.utils.zip.ZipEvent;
	import riaidea.utils.zip.ZipFile;
	
	import com.uc55.view.ViewManager;
	import com.uc55.system.Core;
	import com.uc55.game.config.ViewPredef;
	
	
	public class ResLibsView extends UIWindow{
		public var ViewItem:Image;
		private var cur_item:String;
		
		[Bindable]
		public var libs:XMLList;
		
		private var zipl:ZipArchive = new ZipArchive();
		
		public function ResLibsView():void{
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandel);
			zipl.load("map.zip");
			zipl.addEventListener(ProgressEvent.PROGRESS, loading);
			zipl.addEventListener(ZipEvent.ZIP_INIT, inited);
			zipl.addEventListener(ZipEvent.ZIP_FAILED, failed);
			zipl.addEventListener(IOErrorEvent.IO_ERROR, ioerror);
		}
		
		private function loading(e:ProgressEvent):void {
			//trace("loading");
		}
		
		private function inited(e:ZipEvent):void {
			//trace("loadOK");
			zipl.addEventListener(ZipEvent.ZIP_CONTENT_LOADED, imgloaded);
			var file:ZipFile = zipl.getFileByName("catalog.xml");
			var xml:XML=new XML(file.data);
			libs=XMLList(xml);
		}
		
		private function imgloaded(e:ZipEvent):void{
			trace("fileLoade");
		}
		
		private function failed(e:ZipEvent):void {
			trace("failed");
		}
		
		private function ioerror(e:IOErrorEvent):void {
			trace("ioerror");
		}
		
		protected function showItem(e:MouseEvent):void{
			try{
				var swfFile:ZipFile=zipl.getFileByName("library.swf");
				var swf:ByteArray=swfFile.data;
				cur_item=e.target.text;
				var l:Loader = new Loader();
				
				var loaderContext:LoaderContext = new LoaderContext();
				loaderContext.allowLoadBytesCodeExecution = true;
	            l.loadBytes(swf, loaderContext);
	            l.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoaded);
	        }catch(e:Error){
   				
   			}
		}
		
		private function onSWFLoaded(e:Event):void{
			try{
				var swc:*=e.currentTarget;
				var myClass:Class=swc.applicationDomain.getDefinition(cur_item) as Class;
				var bitmapData:BitmapData=new myClass(60,60) as BitmapData;
		        var bitmap:Bitmap=new Bitmap(bitmapData);
		        ViewItem.source=bitmap;
	  		}catch(e:Error){
	  			
	  		}
		}
		
		private function onMouseUpHandel(e:MouseEvent):void{
			e.currentTarget.stopDrag();
		}
		
		protected function cloneItem(e:MouseEvent):void{
			var bm:BitmapData=Bitmap(e.currentTarget.source).bitmapData;
			var newBm:Bitmap=new Bitmap(bm);
			var newMc:MovieClip=new MovieClip();
			newMc.addChild(newBm);
			var comp:UIComponent=new UIComponent();
			comp.addChild(newMc);
			comp.startDrag();
			comp.alpha=.5;
			comp.x=this.parentApplication.mouseX-(newBm.width*0.5);
			comp.y=this.parentApplication.mouseY-(newBm.height*0.5);
			comp.buttonMode=true;
			comp.addEventListener(MouseEvent.CLICK,onClick);
			this.parentApplication.addChild(comp);
		}
		
		private function onClick(e:MouseEvent):void{
			e.currentTarget.removeEventListener(MouseEvent.CLICK,onClick);
			e.currentTarget.alpha=1;
			e.currentTarget.stopDrag();
			var _core:Core=Core.getInstance();
			e.currentTarget.y+=60;
			_core.view.getUI(ViewPredef.MAP_CANVAS).addChild(e.currentTarget);
		}
	}
}
