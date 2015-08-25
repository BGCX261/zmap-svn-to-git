package com.redbaby.game.module.map{
	import com.redbaby.game.allInterface.IPlayer;
	import com.redbaby.game.module.avatar.Avatar;
	import com.redbaby.game.module.map.astar.MoveDirection;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	public class Player extends Sprite implements IPlayer {
		private var walkSpeed:Number = 30;
		private var lastPointY:Number = 0;
		private var lastPointX:Number = 0;
		private var lastDir:String = "0";
		private var path:Array;
		private var isUser:Boolean = false;
		private var labelCatch:Bitmap;
		private var endActionInfo:Object;
		private var timer:Timer;
		private var scrollCount:uint = 0;
		private var moveBiX:Number;
		private var lineStep:uint;//**
		private var moveBiY:Number;
		private var face:Sprite;
		private var label_txt:TextField;
		private var stepCount:uint;
		private var nowIndex:uint;
		private var ava:Avatar;
		private var endActionType:String;
		private var moveSpeed:Number = 1.8;
		private var moveBi:Number;
		
		public function Player(user:Boolean = false, dir:uint = 2){
			var textFormat:TextFormat;
			var glow:GlowFilter;
			moveSpeed = 1.8;
			walkSpeed = 30;
			scrollCount = 0;
			lastPointX = 0;
			lastPointY = 0;
			isUser = false;
			lastDir = "0";
			this.mouseChildren = false;
			this.mouseEnabled = false;
			timer = new Timer(walkSpeed);
			timer.addEventListener(TimerEvent.TIMER, moveNextTimer);
			label_txt = new TextField();
			label_txt.width = 500;
			textFormat = new TextFormat();
			textFormat.font = "Tahoma,Arial";
			if (user) {
				textFormat.color = 16777215;
			}else {
				textFormat.color = 65280;
			}
			glow = new GlowFilter(0, 1, 5, 5, 4, 2);
			label_txt.defaultTextFormat = textFormat;
			label_txt.filters = [glow];
			ava = new Avatar(dir);
			ava.y = 17;
			if (user) {
				isUser = true;
				
			}
			face = new Sprite();
			this.addChild(ava);
			this.addChild(label_txt);
			this.addChild(face);
		}
		
		public function moveTo(p:Array):void {
			trace(p);
			path = p;
			setXY(path[0][0], path[0][1]);
			nowIndex = 0;
			stepCount = 0;
			
			timer.start();
			whenPathChange(path[0][0], path[0][1], path[1][0], path[1][1]);
			if (isUser) {
				
			}
		}
		
		public function setXY(x:Number, y:Number):void {
			this.x = Math.round(x);
			this.y = Math.round(y - 140);
		}
		
		public function get avatar():Avatar {
			return ava;
		}
		
		private function whenPathChange(x1:Number, y1:Number, x2:Number, y2:Number):void {
			var tim:Number;
			var currdir:String;
			currdir = MoveDirection.compute(x1, y1, x2, y2);
			if (currdir != lastDir || lastDir == "0" || 0 < 2) {
				ava.setAction("WALK", uint(currdir));
			}
			lastDir = currdir;
		}
		
		private function moveNextTimer(e:TimerEvent):void {
			try{
			var pos:Number;
			var dec:Number;
			moveBi = (path[nowIndex + 1][0] - path[nowIndex][0]) / (path[nowIndex + 1][1] - path[nowIndex][1]);
			moveBiX = path[nowIndex + 1][0] - path[nowIndex][0];
			moveBiY = path[nowIndex + 1][1] - path[nowIndex][1];
			
			pos = Math.pow(Math.abs(moveBiX), 2) + Math.pow(Math.abs(moveBiY), 2);
			lineStep = Math.floor(10 * Math.sqrt(pos) / 100 * moveSpeed) + 1;
			stepCount++;
			dec = 2;
			if (path[nowIndex + 1][0] < path[nowIndex][0]) {
				dec = -dec;
			}
			
			//var nowX:int=path[nowIndex][0];
			//var nowY:int=path[nowIndex][1];
			
			//this.x=(64*.5)*(nowX-nowY)+500;
			//this.y=(31*.5)*(nowX+nowY)+16;
			
			this.x = Math.round(path[nowIndex][0] + moveBiX * stepCount / lineStep)+500;
			this.y = Math.round(path[nowIndex][1] + moveBiY * stepCount / lineStep)+16;
			if (stepCount == lineStep) {
				nowIndex++;
				stepCount = 0;
				if (nowIndex == path.length--) {
					timer.stop();
					whenPathChange(path[nowIndex][0], path[nowIndex][1], path[nowIndex + 1][0], path[nowIndex + 1][1]);
					
				}
			}
			
			scrollCount++;
			}catch(e:Error){
				ava.setAction("STAND",dec);
				return;
			}
		}
		
		public function hide():void{
			
		}
		
		public function run():void{
			
		}
	}
}