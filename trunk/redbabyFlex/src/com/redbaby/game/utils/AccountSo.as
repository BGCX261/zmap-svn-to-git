package com.redbaby.game.utils{
	import flash.net.SharedObject;
	
	public class AccountSo{
		private const ACCOUNT_CACHE:String="account_cache";
		public function AccountSo():void{
			
		}
		
		public function getAccount():Object{
			var so:SharedObject=SharedObject.getLocal(ACCOUNT_CACHE);
			if(so){
	       		return so.data;
	  		}
	  		return null;
		}
		
		public function clearAccount():void{
			var so:SharedObject=SharedObject.getLocal(ACCOUNT_CACHE);
			so.clear();
		}
		
		public function saveAccount(account:String,password:String):void{
			var so:SharedObject=SharedObject.getLocal(ACCOUNT_CACHE);
			so.data.account=account;
			so.data.password=password;
		}
		
		private static var instance:AccountSo;
		
		public static function getInstance():AccountSo{
			if(instance==null){
				instance=new AccountSo();
			}
			return instance;
		}
	}
}
