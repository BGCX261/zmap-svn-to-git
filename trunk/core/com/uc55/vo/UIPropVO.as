package com.uc55.vo{
	/**
	 * 所有视图组件的VO对象
	 * @isLast是否为最后一个对象
	 * @initVisible初始化时的显示状态
	 * @cls对应的Class
	 **/ 
	public class UIPropVO{
		
		public var isLast:Boolean;
		public var initVisible:Boolean;
		public var cls:Class;
		public var name:String;
		public var createLater:Boolean;
		public var vid:uint;
		public var prop:Object;
		public var style:Object;
		public var parent:Object;
		public var type:String;
		
		public function UIPropVO():void{
			
		}
	}
}
