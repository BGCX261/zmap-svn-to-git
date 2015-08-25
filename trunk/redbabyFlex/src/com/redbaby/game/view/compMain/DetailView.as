package com.redbaby.game.view.compMain{
	import com.redbaby.game.system.Core;
	import com.redbaby.game.view.UICanvas;
	import com.redbaby.game.view.ViewPredef;
	
	public class DetailView extends UICanvas{
		public function DetailView():void{
			
		}
		
		protected function creationCompleteHandle():void{
			
		}
		
		protected function showUserDetail():void{
			Core.getInstance().view.getUI(ViewPredef.USER_DETAIL_WINDOW).initView();
		}
	}
}
