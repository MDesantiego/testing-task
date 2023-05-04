Dialog:casino_menu ( playerid, response, listitem, inputtext[] )
{
	new cpID = temp [ playerid ] [ tCasinoPlayer ];

	if ( !response )
	{
		temp [ playerid ] [ tCasinoPlayer ] = INVALID_PLAYER_ID;

		if ( cpID != playerid ) //Обнуляем его слот, чтобы показать всем корректную информацию
		{
			for ( new i = 0; i < 5; i ++ )
			{
				if ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] != playerid )
					continue;

				CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] = INVALID_PLAYER_ID;
				break;
			}
		}

		for ( new i = 0; i < 5; i ++ )
		{
			if ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
				continue;

			if ( playerid == cpID )
			{
				Dialog_Show ( playerid, NULL, DIALOG_STYLE_MSGBOX, " ", "Лобби удалено, создатель отменил игру", "Ок", "" );
				temp [ CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] ] [ tCasinoPlayer ] = INVALID_PLAYER_ID;
			}
			else
				ShowPlayerCasino ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] );
		}

		if ( cpID == playerid )
			ResetPlayerVariableCasino ( playerid );

		return 1;
	}

	if ( listitem == 0 && playerid == cpID && CasinoPlayer [ cpID ] [ cpStarted ] == false )
	{
		for ( new i = 0; i < 5; i ++ )
		{
			if ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
			{
				ShowPlayerCasino ( playerid );
				return SEM ( playerid, "Недостаточно игроков для старта!" );
			}

			temp [ playerid ] [ tTimer ] = SetTimerEx ( "second_timer_", 1000, true, "i", playerid );
			
			CasinoPlayer [ playerid ] [ cpStarted ] = true;
			CasinoPlayer [ playerid ] [ cpStage ] = 1;
			CasinoPlayer [ playerid ] [ cpTime ] = 5;
		}
	}
	else
		ShowPlayerCasino ( playerid );

	return 1;
}