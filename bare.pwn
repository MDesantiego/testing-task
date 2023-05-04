#include <a_samp>
#include <core>
#include <Pawn.CMD>
#include <easyDialog>
#include <a_mysql>
//#include streamer

new base;

#include 			"modules/other.pwn"
#include 			"modules/casino_sys.pwn"

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnPlayerConnect(playerid)
{
	base = mysql_connect ( "", "", "", "" );
	mysql_tquery ( base, "CREATE TABLE `logs` ( `id` INT(11) NOT NULL AUTO_INCREMENT , `name` VARCHAR(32) NOT NULL , `count` INT(11) NOT NULL , `time` TIME NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`id`)) ENGINE = InnoDB;" );
	
	GetPlayerName ( playerid, temp [ playerid ] [ tPlayerName ], MAX_PLAYER_NAME );
	RemoveBuildingForPlayer(playerid, -1, 0.0, 0.0, 0.0, 6000.0);
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Bare Script",5000,5);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("Bare Script");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);


	//
	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);
	return 1;
}
