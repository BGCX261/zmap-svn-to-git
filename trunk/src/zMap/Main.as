import com.uc55.API;
import com.uc55.event.*;
import com.uc55.rpc.SocketManager;
import com.uc55.game.rpc.AMFManager;
import com.uc55.ui.view.StageContainer;
import com.uc55.ui.view.UIContainer;

private var _api:API;
private var _amf:AMFManager;

private function init():void{
	maximize();
	_amf=new AMFManager();
	_api=new API(this,StageContainer,UIContainer);
	CommonEventDispatcher.getInstance().dispatchEvent(new Event(SocketManager.RPC_OK));
}