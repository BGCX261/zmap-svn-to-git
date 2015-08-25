package com.uc55.game.rpc{
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	public class AMFManager{
		private var channelSet:ChannelSet;
		private var amfChannel:AMFChannel;
		
		private var ro:RemoteObject;
		
		public function AMFManager():void{
			channelSet=new ChannelSet();
			amfChannel=new AMFChannel();
			amfChannel.url="http://192.168.17.25/webgame/messagebroker/amf";
			channelSet.addChannel(amfChannel);
			sendMsg();
		}
		
		private function sendMsg():void{
			ro=new RemoteObject();
			ro.destination="map";
			ro.makeObjectsBindable = true; 

			ro.endpoint="http://192.168.17.25/webgame/messagebroker/amf";
			
			ro.addEventListener(FaultEvent.FAULT,onFault);
			ro.map.addEventListener(ResultEvent.RESULT,onResult);
			ro.addEventListener(ResultEvent.RESULT,onResult);
			ro.initMap(40,40,0);
		}
		
		private function onFault(e:FaultEvent):void{
			trace(e.message);
		}
		
		private function onResult(e:ResultEvent):void{
			trace(e.result[0].length);
			trace(e.result[1].length);
			trace(e.result[2].length);
			trace(e.result[10].length);
			/*
			var arr:Array=e.result[0];
			for(var i:int=0;i>arr[0].length;i++){
				trace(arr[i].elementId);
			}
			*/
		}
	}
}
