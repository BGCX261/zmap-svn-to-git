/**
* ...
* @author ZeR
* @version 0.1
*/

package com.redbaby.game.module.avatar {
	import com.redbaby.game.allInterface.IAvatar;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Avatar extends Sprite implements IAvatar {
		
		private var suit:MovieClip;
		private var loader:Loader;
		private var loopStart:uint = 1;
		private var nowFrame:uint = 0;
		private var timer:Timer;
		private var motionPlaySpeed:uint = 100;
		private var loopEnd:uint = 1;
		private var playFrame:uint = 0;
		private var shose:MovieClip;
		private var body:MovieClip;
		private var dir:uint;
		private var emptyMC:MovieClip;
		private var hair:MovieClip;
		private var pants:MovieClip;
		private var aldr:AvatarLoader;
		private var shirt:MovieClip;
		
		public function Avatar(dir:uint = 2) {
			loopStart = 1;
			loopEnd = 1;
			motionPlaySpeed = 100;
			playFrame = 0;
			nowFrame = 0;
			this.dir = dir;
			timer = new Timer(motionPlaySpeed);
			timer.addEventListener(TimerEvent.TIMER, playAction);
			loader = new Loader();
			this.addChild(loader);
			loader.x = -27;
			aldr = new AvatarLoader();
			aldr.addEventListener(Event.COMPLETE, whenAllFilesLoaded);
			emptyMC = new MovieClip();
			nowFrame = AvatarFrame[AvatarAction.STAND + "_" + dir];
			setAvatar({body:["http://192.168.1.60:8080/redbaby/avatar/body1.swf",150],shirt:["http://192.168.1.60:8080/redbaby/avatar/cloth1.swf",120], hair:["http://192.168.1.60:8080/redbaby/avatar/hair1.swf", 120], pants:["http://192.168.1.60:8080/redbaby/avatar/pants1.swf", 120], shose:["http://192.168.1.60:8080/redbaby/avatar/shose1.swf", 120]});
		}
		
		public function setAction(sta:String,mir:uint):void {
			var dir:uint;
			var mir0:Boolean;
			var mir1:Boolean;
			var mir2:Boolean;
			var mir3:Boolean;
			
			mir0 = mir == AvatarFrame.mirror[0];
			mir1 = mir == AvatarFrame.mirror[1];
			mir2 = mir == AvatarFrame.mirror[2];
			mir3 = mir == AvatarFrame.mirror[3];
			
			if (mir0 || mir1 || mir2 || mir3) {
				this.scaleX = -1;
			}else {
				this.scaleX = 1;
			}
			
			if (sta == AvatarAction.STAND) {
				timer.stop();
				viewFrame(AvatarFrame[sta + "_" + mir]);
			}
			loopStart = AvatarFrame["WALK_" + mir + "_BEGIN"];
			loopEnd = AvatarFrame["WALK_" + mir + "_END"];
			playFrame = 0;
			timer.start();
		}
		
		public function setAvatar(obj:Object):void {
			aldr.load(obj);
		}
		
		private function playAction(e:TimerEvent):void {
			//trace("playAction");
			if (playFrame > loopEnd - loopStart) {
				playFrame = 0;
			}
			viewFrame(loopStart + playFrame);
			playFrame++;
		}
		
		public function viewFrame(fra:int,end:Boolean=false):void {
			if(end){
				timer.stop();
				viewFrame(AvatarFrame["STAND_" + fra]);
				return;
			}
			//trace("停止动作");
			nowFrame = fra;
			body.gotoAndStop(fra);
			shirt.gotoAndStop(fra);
			shose.gotoAndStop(fra);
			hair.gotoAndStop(fra);
			pants.gotoAndStop(fra);
			suit.gotoAndStop(fra);
		}
		
		private function whenAllFilesLoaded(e:Event):void {
			var cout:uint;
			while (numChildren > 0) {
				this.removeChildAt(0);
			}
			
			body = aldr.getAllAvatar().body;
            body = body != null ? (body) : (emptyMC);
            body.x = AvatarFrame.dx;
            body.y = AvatarFrame.dy;
            shirt = aldr.getAllAvatar().shirt;
            shirt = shirt != null ? (shirt) : (emptyMC);
            shirt.x = AvatarFrame.dx;
            shirt.y = AvatarFrame.dy;
            shose = aldr.getAllAvatar().shose;
            shose = shose != null ? (shose) : (emptyMC);
            shose.x = AvatarFrame.dx;
            shose.y = AvatarFrame.dy;
            hair = aldr.getAllAvatar().hair;
            hair = hair != null ? (hair) : (emptyMC);
            hair.x = AvatarFrame.dx;
            hair.y = AvatarFrame.dy;
            pants = aldr.getAllAvatar().pants;
            pants = pants != null ? (pants) : (emptyMC);
            pants.x = AvatarFrame.dx;
            pants.y = AvatarFrame.dy;
            suit = aldr.getAllAvatar().suit;
            suit = suit != null ? (suit) : (emptyMC);
            suit.x = AvatarFrame.dx;
            suit.y = AvatarFrame.dy;
            this.addChild(body);
            this.addChild(shirt);
            this.addChild(shose);
            this.addChild(pants);
            this.addChild(hair);
            this.addChild(suit);
            viewFrame(nowFrame);
		}
		
		public function set playSpeed(x:Number):void {
			timer.delay = motionPlaySpeed / x;
		}
	}
	
}
