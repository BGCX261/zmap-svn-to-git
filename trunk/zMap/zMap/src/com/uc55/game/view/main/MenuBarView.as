package com.uc55.game.view.main{
	import mx.controls.MenuBar;
	import mx.events.MenuEvent;
    import mx.controls.Alert;
    import mx.collections.*;
	
	public class MenuBarView extends MenuBar{
			
		[Bindable]
		public var menuBarCollection:XMLListCollection;
			
		private var cmd:Array=["newFile","openFile","verInfo","worldMap"];
			
		protected function menuHandel(e:MenuEvent):void{
			this[cmd[int(e.item.@data)]]();
		}
			
		private function newFile():void{
			Alert.show("newFile");
		}
			
		private function openFile():void{
			Alert.show("openFile");
		}
		
		private function worldMap():void{
			
		}
			
		private function verInfo():void{
			Alert.show("google code:code.google.com/p/zmap.if you have some problom,yan could content me[QQ:61440210,Email:riazone@qq.com].    Version.a_1.0_090907_01","Version");
		}
			
		private var menubarXML:XMLList =
			<>
				<menuitem label="File" data="top">
					<menuitem label="New" data="0">
						<menuitem label="World Map" data="3"/>
					</menuitem>
					<menuitem label="Save" data="1"/>
				</menuitem>
				<menuitem label="Edit" data="top">
					<menuitem label="Hide Grid Layer" data="4"/>
					<menuitem label="Hide Build Layer" data="5"/>
				</menuitem>
				<menuitem label="Window" data="top">
					<menuitem label="Resource Libs" data="2"/>
				</menuitem>
				<menuitem label="Help" data="top">
					<menuitem label="Help Contents" data="2"/>
					<menuitem label="About zMap" data="2"/>
				</menuitem>
			</>;
		protected function initCollections():void {
        	menuBarCollection = new XMLListCollection(menubarXML);
        }
	}
	
	
}
