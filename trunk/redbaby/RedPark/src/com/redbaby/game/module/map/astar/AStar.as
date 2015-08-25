/**
* @author Z.eR
* @version 0.1
*/

package com.redbaby.game.module.map.astar {
	import com.redbaby.game.allInterface.IMapTileModel;
	public class AStar {
		private var m_maxTry:int;
		private var m_openCount:int;
		private var m_openId:int;
		private var m_openList:Array;
		private var m_pathScoreList:Array;
		private var m_xList:Array;
		private var m_yList:Array;
		private var m_movementCostList:Array;
		private var m_noteMap:Array;
		private var m_fatherList:Array;
		private var m_mapTileModel:IMapTileModel;
		
		private const NOTE_ID:int = 0;
		private const NOTE_CLOSED:int = 2;
		private const COST_DIAGONAL:int = 14;
		private const COST_STRAIGHT:int = 10;
		private const NOTE_OPEN:int = 1;
		
		
		public function AStar(iMapTileModel:IMapTileModel,maxTry:int=500) {
			m_mapTileModel = iMapTileModel;
			m_maxTry = maxTry;
		}
		
		public function find(sx:int, sy:int, ex:int, ey:int):Array {
			var currTry:int = 0;;
			var currId:int;
			var currNoteX:int;
			var currNoteY:int;
			var checkingId:int;
			var cost:int;
			var score:int;
			var aroundNotes:Array;
			
			initLists();
			
			this.m_openCount = 0;
			this.m_openId = -1;
			
			this.openNote(sx, sy, 0, 0, 0);
			
			while (m_openCount > 0) {
				if (++currTry > m_maxTry) {
					this.destroyLists();
					return null;
				}
				currId = this.m_openList[0];
				
				this.closeNote(currId);
				
				currNoteX = this.m_xList[currId];
				currNoteY = this.m_yList[currId];
				
				if (currNoteX == ex && currNoteY == ey) {
					return this.getPath(sx, sy, currId);
				}
				
				aroundNotes = this.getAround(currNoteX, currNoteY);
				
				for each(var note:Array in aroundNotes) {
					cost = this.m_movementCostList[currId] + ((note[0] == currNoteX || note[1] == currNoteY) ? COST_STRAIGHT : COST_DIAGONAL);
					score = cost + (Math.abs(ex - note[0]) + Math.abs(ey - note[1])) * COST_STRAIGHT;
					
					if (this.isOpen(note[0], note[1])){
						checkingId = this.m_noteMap[note[1]][note[0]][NOTE_ID];
						if(cost < this.m_movementCostList[checkingId]){
							this.m_movementCostList[checkingId] = cost;
							this.m_pathScoreList[checkingId] = score;
							this.m_fatherList[checkingId] = currId;
							this.aheadNote(this.getIndex(checkingId));
						}
					} else{
						this.openNote(note[0], note[1], score, cost, currId);
					}
				}
			}
			this.destroyLists();
			return null;
		}
		
		public function openNote(sx:int, sy:int, score:int, cost:int, father:int):void {
			this.m_openCount++;
			this.m_openId++;
			
			if (this.m_noteMap[sy] == null) {
				this.m_noteMap[sy] = [];
			}
			this.m_noteMap[sy][sx] = [];
			this.m_noteMap[sy][sx][NOTE_OPEN] = true;
			this.m_noteMap[sy][sx][NOTE_ID] = this.m_openId;
			this.m_xList.push(sx);
			this.m_yList.push(sy);
			this.m_pathScoreList.push(score);
			this.m_movementCostList.push(cost);
			this.m_fatherList.push(father);
			this.m_openList.push(m_openId);
			this.aheadNote(m_openCount);
		}
		
		private function closeNote(id:int):void {
			this.m_openCount--;
			var noteX:int = this.m_xList[id];
			var noteY:int = this.m_yList[id];
			this.m_noteMap[noteX][noteY][NOTE_OPEN] = false;
			this.m_noteMap[noteX][noteY][NOTE_CLOSED] = true;
			if (m_openCount <= 0) {
				this.m_openCount = 0;
				this.m_openList = [];
				return;
			}
			this.m_openList[0] = this.m_openList.pop();
			this.backNote();
		}
		
		private function backNote():void {
			var checkIndex:int = 1;
			var tmp:int;
			var change:int;
			
			while (true) {
				tmp = checkIndex;
				if (2 * tmp <= this.m_openCount) {
					if (this.getScore(checkIndex) > this.getScore(2 * tmp)) {
						checkIndex = 2 * tmp;
					}
					
					if (2 * tmp + 1 <= this.m_openCount) {
						if (this.getScore(checkIndex) > this.getScore(2 * tmp + 1)) {
							checkIndex = 2 * tmp + 1;
						}
					}
				}
				
				if (tmp == checkIndex) {
					break;
				}else {
					change = this.m_openList[tmp - 1];
					this.m_openList[tmp - 1] = this.m_openList[checkIndex - 1];
					this.m_openList[checkIndex - 1] = change;
				}
			}
		}
		
		private function aheadNote(index:int):void {
			trace("index:", index);
			var father:int;
			var change:int;
			
			while (index > 1) {
				//标记:用--优化效率
				father = Math.floor(index / 2);
				if (getScore(index) < getScore(father)) {
					change = this.m_openList[index - 1];
					this.m_openList[index - 1] = this.m_openList[father - 1];
					this.m_openList[father - 1] = change;
					index = change;
				}else {
					break;
				}
			}
		}
		
		private function getIndex(id:int):int {
			var i : int = 1;
			for each (var _id : int in this.m_openList)
			{
				if (_id == id)
				{
					return i;
				}
				i++;
			}
			return -1;
		}
		
		private function getScore(index:int):int {
			trace("score:", index, this.m_pathScoreList[this.m_openList[index - 1]]);
			return this.m_pathScoreList[this.m_openList[index - 1]];
		}
		
		private function getPath(sx:int, sy:int, id:int):Array {
			var arr:Array = [];
			var noteX:int = this.m_xList[id];
			var noteY:int = this.m_yList[id];
			while (noteX != sx || noteY != sy) {
				arr.unshift([noteX, noteY]);
				id = this.m_fatherList[id];
				noteX = m_xList[id];
				noteY = m_yList[id];
			}
			arr.unshift([sx, sy]);
			this.destroyLists();
			return arr;
		}
		
		private function isClosed(x:int, y:int):Boolean {
			if (this.m_noteMap[y] == null) return false;
			if (this.m_noteMap[y][x] == null) return false;
			return this.m_noteMap[y][x][NOTE_CLOSED];
		}
		
		private function isOpen(x:int, y:int):Boolean {
			if (this.m_noteMap[y] == null) return false;
			if (this.m_noteMap[y][x] == null) return false;
			return this.m_noteMap[y][x][NOTE_OPEN];
		}
		
		private function getAround(x:int, y:int):Array {
			var arr:Array = [];
			var checkX:int;
			var checkY:int;
			var canDiagonal:Boolean;
			
			checkX = x + 1;
			checkY = y;
			var canRight:Boolean = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canRight && !this.isClosed(checkX, checkY)) {
				arr.push([checkX, checkY]);
			}
			
			checkX = x;
			checkY = y + 1;
			var canDown:Boolean = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canDown && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x - 1;
			checkY = y;
			var canLeft : Boolean = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canLeft && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x;
			checkY = y - 1;
			var canUp : Boolean = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canUp && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x + 1;
			checkY = y + 1;
			canDiagonal = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canDiagonal && canRight && canDown && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x - 1;
			checkY = y + 1;
			canDiagonal = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canDiagonal && canLeft && canDown && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x - 1;
			checkY = y - 1;
			canDiagonal = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canDiagonal && canLeft && canUp && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			checkX = x + 1;
			checkY = y - 1;
			canDiagonal = this.m_mapTileModel.isBlock(x, y, checkX, checkY) == 1;
			if (canDiagonal && canRight && canUp && !this.isClosed(checkX, checkY)){
				arr.push([checkX, checkY]);
			}
			
			return arr;
		}
		
		private function initLists():void {
			m_openList = [];
			m_pathScoreList = [];
			m_xList = [];
			m_yList = [];
			m_movementCostList = [];
			m_noteMap = [];
			m_fatherList = [];
		}
		
		private function destroyLists():void {
			m_openList = null;
			m_pathScoreList = null;
			m_xList = null;
			m_yList = null;
			m_movementCostList = null;
			m_noteMap = null;
			m_fatherList = null;
		}
	}
	
}
