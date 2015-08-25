/**
* ...
* @author Default
* @version 0.1
*/

package com.redbaby.game.module.avatar {
	import com.redbaby.game.allInterface.IAvatar;
	import flash.display.Sprite;

	public class Avatar extends Sprite implements IAvatar {
		
		public function Avatar() {
			with (this.graphics)
			{
				lineStyle(1, 0xff0000);
				beginFill(0xff0000);
				drawRect(0, 0, 10, 10);
				endFill();
			}
		}
		
		public function setAction():void {
			
		}
		
		public function setAvatar():void {
			
		}
		
	}
	
}
