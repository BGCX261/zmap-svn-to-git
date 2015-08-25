/**
* ...
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.GridFitType;
	
	import com.redbaby.game.utils.RCS;
	import com.redbaby.game.allInterface.*;

	public class Map extends Sprite implements IMapEngine {
		private var fps:uint = 30;
		private var userAvatar:IAvatar;
		private var dyControl:DyLayeControl;
		private var loader:Loader;
		private var floor:Sprite;
		private var hitBD:BitmapData;
		private var hitTimeID:Number;
		//private var progress:Progress;
		private var _isUserRoom:Boolean;
		private var sky:Sprite;
		//private var myContextMenu:ContextMenu;
		private var hitBP:Bitmap;
		//private var roomDataLdr:RoomDataLoader;
		private var _moveScroll:Boolean = true;
		private var userPlayer:Player;
		//private var playerCtl:PlayerControl;
		private var grid:Grid;
		
		private var m_path:Array;
		public function Map() {
			this.addEventListener(MouseEvent.CLICK, onMapClick);
			m_grid = new Grid();
			this.addChild(m_grid);
		}
		
		private function onMapClick(e:MouseEvent):void {
			var stime:Date = new Date();
			var pto:Point = RCS.ScreenToPoint(mouseX, mouseY, 10, 10);
			var pfrom:Point = RCS.ScreenToPoint(m_grid.mapData.avatar.x, m_grid.mapData.avatar.y, 10, 10);
			trace("from", pfrom, "to", pto);
			m_path = m_grid.astar.find(pfrom.x, pfrom.y, pto.x, pto.y);
			var etime:Date = new Date();
			trace(stime.getTime(), etime.getTime());
			trace("共耗时:", etime.getTime() - stime.getTime());
			if (this.m_path != null && this.m_path.length > 0){
				this.addEventListener(Event.ENTER_FRAME, enterframeHandle);
			}
		}
		
		private function enterframeHandle(e:Event):void {
			if (this.m_path == null || this.m_path.length == 0){
				this.removeEventListener(Event.ENTER_FRAME, enterframeHandle);
				return;
			}
			
			var note : Array = this.m_path.shift() as Array;
			m_grid.mapData.avatar.x = note[0] * 10;
			m_grid.mapData.avatar.y = note[1] * 10;
		}
		
	}
	
}
