package com.uc55.utils{
	public class Time{
		public function Time():void{
			
		}
		
		public function getClientTimeStr():String{
			var date:Date=new Date();
			return date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
		}
		
		public function getClientTimeNum():Number{
			var date:Date=new Date();
			
			return date.getTime();
		}
	}
}
