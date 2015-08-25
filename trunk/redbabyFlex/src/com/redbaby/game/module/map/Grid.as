package com.redbaby.game.module.map
{
    import core.*;
    import core.library.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import module.map.find.*;

    public class Grid extends Sprite
    {
        private var bak:Array;
        private var cellH:Number;
        private var _mapWidth:int = 320;
        private var _mapHeight:int = 320;
        private var mapData:MapData;
        private var cellW:Number;
        private var startX:Number;
        private var startY:Number;
        private var bp:Bitmap;
        private var aStar:AStar;
        private var cells:Array;
        private var pathView:Sprite;
        private var t:Number;
        private var walkPath:Array;
        private var pathMask:Sprite;

        public function Grid()
        {
            _mapWidth = 320;
            _mapHeight = 320;
            bak = [10, 10];
            mapData = new MapData();
            mapData.reset(mapWidth, mapHeight);
            aStar = new AStar(mapData, 1500);
            cellW = GridXY.width;
            cellH = GridXY.height;
            var _loc_1:* = _mapWidth / 2 * GridXY.width / 2;
            GridXY.startX = _mapWidth / 2 * GridXY.width / 2;
            startX = _loc_1;
            var _loc_1:* = (-_mapHeight) / 2 * GridXY.height / 2;
            GridXY.startY = (-_mapHeight) / 2 * GridXY.height / 2;
            startY = _loc_1;
            cells = new Array();
            creatCells();
            bp = new Bitmap();
            bp.alpha = 0.5;
            this.addChild(bp);
            this.mouseEnabled = false;
            this.mouseChildren = false;
            pathView = new Sprite();
            pathMask = new Sprite();
            pathMask.visible = false;
            this.addChild(pathView);
            this.addChild(pathMask);
            return;
        }// end function

        public function clearPath() : void
        {
            var _loc_1:Number;
            var _loc_2:Number;
            pathView.mask = pathMask;
            pathView.cacheAsBitmap = true;
            pathMask.cacheAsBitmap = true;
            pathMask.graphics.beginFill(0);
            _loc_1 = walkPath[walkPath.length--][0] - walkPath[0][0];
            _loc_2 = walkPath[walkPath.length--][1] - walkPath[0][1];
            if (pathMask.numChildren == 0)
            {
                pathMask.addChild(SourceLibrary.getSource("PathMask") as DisplayObject);
            }// end if
            pathMask.scaleX = (-_loc_1) / 100;
            pathMask.scaleY = (-_loc_2) / 100;
            pathMask.x = walkPath[walkPath.length--][0];
            pathMask.y = walkPath[walkPath.length--][1];
            pathMask.addEventListener(Event.ENTER_FRAME, lessScale);
            return;
        }// end function

        private function findCellByName(param1:String) : Object
        {
            var _loc_2:Cell;
            var _loc_3:uint;
            var _loc_4:Object;
            _loc_2 = new Cell();
            _loc_3 = param1.indexOf("_");
            _loc_2.X = int(param1.slice(4, _loc_3));
            _loc_2.Y = int(param1.slice(_loc_3 + 1));
            return _loc_2;
            return null;
        }// end function

        private function lessScale(param1:Event) : void
        {
            pathMask.scaleX = pathMask.scaleX * 0.96;
            pathMask.scaleY = pathMask.scaleY * 0.96;
            if (Math.abs(pathMask.scaleX) < 0.02 && Math.abs(pathMask.scaleY) < 0.02)
            {
                pathMask.removeEventListener(Event.ENTER_FRAME, lessScale);
            }// end if
            return;
        }// end function

        private function creatCells() : void
        {
            var _loc_1:Cell;
            var _loc_2:int;
            var _loc_3:int;
            this.graphics.clear();
            this.graphics.beginFill(16724736);
            _loc_2 = 0;
            while (_loc_2 < _mapWidth - _mapWidth)
            {
                // label
                _loc_3 = 0;
                while (_loc_3 < _mapHeight - _mapHeight)
                {
                    // label
                    _loc_1 = new Cell();
                    _loc_1.X = _loc_2;
                    _loc_1.Y = _loc_3;
                    _loc_1.name = "cell" + _loc_1.X + "_" + _loc_1.Y;
                    cells.push(_loc_1);
                    _loc_3++;
                }// end while
                _loc_2++;
            }// end while
            return;
        }// end function

        public function reset(param1:BitmapData) : void
        {
            var _loc_2:Cell;
            var _loc_3:Point;
            var _loc_4:int;
            var _loc_5:int;
            var _loc_6:Point;
            _loc_3 = new Point(0, 0);
            mapData.reset(mapWidth, mapHeight);
            _loc_4 = 0;
            while (_loc_4 < _mapWidth)
            {
                // label
                _loc_5 = 0;
                while (_loc_5 < _mapHeight)
                {
                    // label
                    _loc_6 = GridXY.gridToScreen(_loc_4, _loc_5);
                    if (param1.hitTest(_loc_3, 204, _loc_6) == true)
                    {
                        mapData.closeBlock(_loc_4, _loc_5);
                    }// end if
                    _loc_5++;
                }// end while
                _loc_4++;
            }// end while
            return;
        }// end function

        public function checkAbleWalk(param1:Point, param2:Point, param3:Number = 20) : Boolean
        {
            var _loc_4:Boolean;
            var _loc_5:Shape;
            var _loc_6:Rectangle;
            var _loc_7:BitmapData;
            var _loc_8:Bitmap;
            var _loc_9:BitmapData;
            _loc_5 = new Shape();
            _loc_5.graphics.lineStyle(param3, 0, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
            _loc_5.graphics.moveTo(param1.x, param1.y);
            _loc_5.graphics.lineTo(param2.x, param2.y);
            this.addChild(_loc_5);
            _loc_6 = _loc_5.getBounds(this);
            _loc_7 = new BitmapData(_loc_6.width, _loc_6.height, true, 0);
            _loc_7.draw(_loc_5, new Matrix(1, 0, 0, 1, -_loc_6.x, -_loc_6.y));
            _loc_8 = new Bitmap();
            _loc_8.bitmapData = _loc_7;
            _loc_8.x = _loc_6.x;
            _loc_8.y = _loc_6.y;
            this.removeChild(_loc_5);
            _loc_9 = Map.getInstance().hitTest;
            _loc_4 = _loc_9.hitTest(new Point(0, 0), 204, _loc_7, new Point(_loc_6.x, _loc_6.y));
            _loc_7.dispose();
            return !_loc_4;
        }// end function

        public function findPath(param1:Number, param2:Number) : Array
        {
            var _loc_3:Point;
            var _loc_4:Cell;
            var _loc_5:Array;
            var _loc_6:Number;
            var _loc_7:Point;
            var _loc_8:Array;
            var _loc_9:Point;
            var _loc_10:int;
            var _loc_11:int;
            var _loc_12:DisplayObject;
            var _loc_13:Sprite;
            var _loc_14:Point;
            _loc_3 = GridXY.srceenToGrid(param1, param2);
            if (mapData.getWalkable(_loc_3.x, _loc_3.y) == false)
            {
                _loc_12 = UILibrary.getUIObject("UnableWalk");
                _loc_13 = Map.getInstance().skyLayer;
                _loc_12.x = _loc_13.mouseX;
                _loc_12.y = _loc_13.mouseY;
                _loc_13.addChild(_loc_12);
                return [];
            }// end if
            _loc_4 = findCellByName("cell" + _loc_3.x + "_" + _loc_3.y) as Cell;
            _loc_6 = getTimer();
            _loc_7 = PlayerControl.user.getXY();
            _loc_7 = GridXY.srceenToGrid(_loc_7.x, _loc_7.y);
            _loc_5 = aStar.find(_loc_7.x, _loc_7.y, _loc_4.X, _loc_4.Y);
            if (_loc_5 == null)
            {
                return [];
            }// end if
            bak = [_loc_4.X, _loc_4.Y];
            trace("寻路A*用时", getTimer() - _loc_6);
            _loc_8 = _loc_5;
            this.graphics.clear();
            this.graphics.lineStyle(1, 65280, 0.2);
            _loc_9 = GridXY.gridToScreen(_loc_8[0][0], _loc_8[0][1]);
            this.graphics.moveTo(_loc_9.x, _loc_9.y);
            _loc_10 = 1;
            while (_loc_10 < _loc_8.length)
            {
                // label
                _loc_9 = GridXY.gridToScreen(_loc_8[_loc_10][0], _loc_8[_loc_10][1]);
                this.graphics.lineTo(_loc_9.x, _loc_9.y);
                _loc_10++;
            }// end while
            walkPath = new Array();
            walkPath.push([_loc_5[0][0], _loc_5[0][1]]);
            t = getTimer();
            getSimplePath(_loc_5, 0);
            _loc_11 = 0;
            while (_loc_11 < walkPath.length)
            {
                // label
                _loc_14 = GridXY.gridToScreen(walkPath[_loc_11][0], walkPath[_loc_11][1]);
                walkPath[_loc_11][0] = _loc_14.x;
                walkPath[_loc_11][1] = _loc_14.y;
                _loc_11++;
            }// end while
            walkPath.push([param1, param2]);
            drawWalkPath();
            trace("寻路共用时", getTimer() - _loc_6);
            return walkPath;
        }// end function

        public function get mapHeight() : int
        {
            return _mapHeight;
        }// end function

        public function get mapWidth() : int
        {
            return _mapWidth;
        }// end function

        private function getSimplePath(param1:Array, param2:uint) : void
        {
            var _loc_3:Boolean;
            var _loc_4:uint;
            if (getTimer() - t > 3000)
            {
                return;
            }// end if
            _loc_4 = param2;
            while (_loc_4++ < param1.length--)
            {
                // label
                _loc_3 = checkAbleWalk(GridXY.gridToScreen(param1[param2][0], param1[param2][1]), GridXY.gridToScreen(param1[_loc_4][0], param1[_loc_4][1]));
                if (_loc_3 == false && checkAbleWalk(GridXY.gridToScreen(param1[param2][0], param1[param2][1]), GridXY.gridToScreen(param1[_loc_4 + 1][0], param1[_loc_4 + 1][1])) == false)
                {
                    if (walkPath[walkPath.length--][0] != param1[_loc_4--][0] || walkPath[walkPath.length--][1] != param1[_loc_4--][1])
                    {
                        walkPath.push([param1[_loc_4--][0], param1[_loc_4--][1]]);
                    }// end if
                    if (_loc_4 > param2 + 1)
                    {
                        getSimplePath(param1, _loc_4--);
                    }
                    else
                    {
                        getSimplePath(param1, _loc_4);
                    }// end else if
                    break;
                }// end if
            }// end while
            return;
        }// end function

        private function drawWalkPath() : void
        {
            var _loc_1:int;
            pathView.mask = null;
            pathView.graphics.clear();
            pathView.graphics.lineStyle(1, 16777215, 1);
            pathView.graphics.moveTo(walkPath[0][0], walkPath[0][1]);
            _loc_1 = 1;
            while (_loc_1 < walkPath.length)
            {
                // label
                pathView.graphics.lineTo(walkPath[_loc_1][0], walkPath[_loc_1][1]);
                _loc_1++;
            }// end while
            return;
        }// end function

    }
}
