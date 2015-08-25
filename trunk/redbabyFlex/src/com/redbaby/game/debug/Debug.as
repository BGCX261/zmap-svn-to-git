/****************************************
 * Debug模式设置
 * @usage 调整Application运行模式
 * @author ZeR
 * @since 09.09.24
 * @version 1.0
 ****************************************/ 
package com.redbaby.game.debug{
	import com.redbaby.game.view.compDebug.DebugUI;
	
	public class Debug{
		
		public static var DEBUGGING:Boolean=true;
		
		//DEBUG_MODE 0:本地调试模式 1:网络数据模式
		public static var DEBUG_MODE:int;
		
		public static var LOCAL:int=0;
		public static var NET:int=1;
		
		private var _debugUI:DebugUI;
		
		public function Debug():void{
			return;
		}
		
		/**
		 * log日志输出
		 **/
		public static function log():void{
			
		}
	}
}