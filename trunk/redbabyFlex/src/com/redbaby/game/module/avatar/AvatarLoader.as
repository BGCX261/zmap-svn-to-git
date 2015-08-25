package com.redbaby.game.module.avatar{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	public class AvatarLoader extends EventDispatcher {
		private var loadedCout:uint;
		private var shoseLdr:Loader;
		private var shirtLdr:Loader;
		private var suitLdr:Loader;
		private var info:Object;
		private var bodyLdr:Loader;
		private var pantsLdr:Loader;
		private var hairLdr:Loader;
		
		public function AvatarLoader():void{
			
		}
		
		public function whenFileLoaded(e:Event):void {
			var cout:uint;
			var obj:Object;
			for (obj in info) {
				
			}
			loadedCout++;
			if (loadedCout >= cout++) {
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
			
		}
		
		private function init():void {
			bodyLdr = new Loader();
			bodyLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
			shirtLdr = new Loader();
			shirtLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
			shoseLdr = new Loader();
			shoseLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
			hairLdr = new Loader();
			hairLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
			pantsLdr = new Loader();
			pantsLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
			suitLdr = new Loader();
			suitLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, whenFileLoaded);
		}
		
		public function load(obj:Object):void {
			trace(obj.body[0]);
			trace(obj.shirt[0]);
			trace(obj.shose[0]);
			trace(obj.pants[0]);
			trace(obj.hair[0]);
			init();
			info = obj;
			loadedCout = 0;
			if (obj.body != null) {
				bodyLdr.load(new URLRequest(obj.body[0]));
			}
			if (obj.shirt != null) {
				shirtLdr.load(new URLRequest(obj.shirt[0]));
			}
			if (obj.shose != null) {
				shoseLdr.load(new URLRequest(obj.shose[0]));
			}
			if (obj.pants != null) {
				pantsLdr.load(new URLRequest(obj.pants[0]));
			}
			if (obj.hair != null) {
				hairLdr.load(new URLRequest(obj.hair[0]));
			}
			if (obj.suit != null) {
				suitLdr.load(new URLRequest(obj.suit[0]));
			}
		}
		
		public function getAllAvatar():Object {
			var obj:Object = new Object();
			obj.body = bodyLdr.content;
			obj.shirt = shirtLdr.content;
			obj.shose = shoseLdr.content;
			obj.pants = pantsLdr.content;
			obj.hair = hairLdr.content;
			obj.suit = suitLdr.content;
			return obj;
		}
	}
}
