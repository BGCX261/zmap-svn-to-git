package com.redbaby.game.config{
	
    public class SocketCode{
    	
    	//发送协议
    	public static const LOGIN:String = "login";
    	public static const CREATE_PLAYER:String = "createPlayer";
    	public static const UPGRADE_BUILDING:String="upgradeBuilding";
    	public static const CANCEL_JOB:String="cancelJob";
    	public static const RENAME_CITY:String="renameCity";

	    
	    //接收协议
	    public static const LOGIN_SUCCESS:String = "loginBack";
	    public static const CREATE_PLAYER_BACK:String = "createPlayerBack";
	    public static const LOAD_BACK:String="loadBack";
	    public static const FLUSH_HERO_BACK:String="flushHeroBack";
	    public static const UPGRADE_BUILDING_BACK:String="upgradeBuildingBack";
	    public static const COMPLETE_BUILDING_JOB_BACK:String="completeBuildingJobBack";
	    public static const UPDATE_RESOURCE:String="updateResource";
	    public static const CANCEL_JOB_BACK:String="cancelJobBack";
	    public static const RENAME_CITY_BACK:String="renameCityBack";
    }
}