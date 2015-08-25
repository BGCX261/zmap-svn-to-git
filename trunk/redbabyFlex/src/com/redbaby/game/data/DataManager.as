package com.redbaby.game.data{
	import flash.net.*;
	
	public class DataManager{
		
		public static const USER_INFO:uint=1;//用户信息
		public static const CUR_CITY:uint=2;//当前城堡
		public static const GOODS_JOB:uint=3;//任务
		public static const ARMY_JOB:uint=4;//招兵任务
		public static const ALL_CITY:uint=5;//全部城堡
		
		public static const HEAD_DAT:uint=6;//英雄头像DAT
		public static const SOLDIER_DAT:uint=7;//士兵DAT
		public static const GOODS_DAT:uint=8;//道具DAT
		public static const MAP_ELE_DAT:uint=9;//地图元素DAT	
		public static const BUILDING_DAT:uint=10;//建筑DAT
		public static const TASK_REL:uint=11;//任务之间关系;
		public static const RES_DAT:uint=12;//资源DAT
		public static const SOLDIER_RES_DAT:uint=13;//士兵资源DAT
		public static const SOLIDER_BUILD_DAT:uint=14;//士兵与建筑关系DAT
		public static const TP_DAT:uint=15;//爵位DAT
		public static const BUILD_PRE_RES_DAT:uint=16;//建筑前提资源
		public static const BUILD_PRE_BUILD_DAT:uint=17;//建筑前提建筑
		
		private var _d:Object;
		
		public function DataManager():void{
			_d=[];
		}
		
		public function addData(t:uint,o:*):void{
			if(_d[t]==null){
				_d[t]=new Object();
			}
			_d[t]=o;
		}
		
		public function addParam(t:uint,p:String,o:*):void{
			_d[t][p]=o;
		}
		
		public function getData(t:uint):*{
			return _d[t];
		}

		public static function getInstance():DataManager{
			if(instance==null){
				instance=new DataManager();
			}
			return instance;
		}
		
		private static var instance:DataManager;
	}
}