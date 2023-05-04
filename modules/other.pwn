enum ENUM_TEMP
{
	tPlayerName [ MAX_PLAYER_NAME ],
	tCasinoPlayer,
	tTimer,
}

new temp [ MAX_PLAYERS ] [ ENUM_TEMP ];
#define SEM(%0,%1) \
	SendClientMessageEx ( %0, 0xFFFFFFFF, "> "%1 )

#define GetName(%0) \
	temp [ %0 ] [ tPlayerName ]

stock SendClientMessageEx ( playerid, color, const str[], {Float,_}:... )
{
	static
	    args,
	    start,
	    end,
	    string [ 144 ]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if ( args > 12 )
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for ( end = start + ( args - 12 ); end > start; end -= 4 )
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage ( playerid, color, string );

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage ( playerid, color, str );
}