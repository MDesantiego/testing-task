enum ENUM_CPLAYER
{
	cpPlayers [ 5 ],
	cpRoll [ 5 ],
	cpStavka,
	cpWinner,

	bool:cpStarted,
	cpStage,
	cpTime,
}
new CasinoPlayer [ MAX_PLAYERS ] [ ENUM_CPLAYER ];

#include 			"modules/casino/stock.pwn"
#include 			"modules/casino/timer.pwn"
#include 			"modules/casino/dialog.pwn"

public OnPlayerConnect(playerid)
{
	ResetPlayerVariableCasino ( playerid );
	temp [ playerid ] [ tCasinoPlayer ] = INVALID_PLAYER_ID;

	#if defined CP_OnPlayerConnect
		return CP_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect CP_OnPlayerConnect

#if defined CP_OnPlayerConnect
    forward CP_OnPlayerConnect(playerid);
#endif


public OnPlayerDisconnect(playerid, reason)
{
	if ( temp [ playerid ] [ tCasinoPlayer ] != INVALID_PLAYER_ID )
	{
		new cpID = temp [ playerid ] [ tCasinoPlayer ];
		
		for ( new i = 0; i < 5; i ++ )
		{
			if ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
				continue;

			temp [ i ] [ tCasinoPlayer ] = INVALID_PLAYER_ID;
			SEM ( i, "Игра закончена %s покинул игру.", GetName ( playerid ) );
		}

		if ( CasinoPlayer [ cpID ] [ cpStarted ] == true )
		{
			KillTimer ( temp [ playerid ] [ tTimer ] );
			ResetPlayerVariableCasino ( playerid );
		}
	}
	#if defined CP_OnPlayerDisconnect
		return CP_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CP_OnPlayerDisconnect

#if defined CP_OnPlayerDisconnect
    forward CP_OnPlayerDisconnect(playerid, reason);
#endif

CMD:casino ( playerid )
{
	temp [ playerid ] [ tCasinoPlayer ] = playerid;
	ShowPlayerCasino ( playerid );
	return 1;
}

