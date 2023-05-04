forward second_timer_ ( playerid );
public second_timer_ ( playerid )
{
	if ( ( CasinoPlayer [ playerid ] [ cpTime ] -- ) == 0 )
	{
		switch ( CasinoPlayer [ playerid ] [ cpStage ] )
		{
			case 1:
			{
				CasinoPlayer [ playerid ] [ cpStage ] ++;
				CasinoPlayer [ playerid ] [ cpTime ] = 5;

				RandomChisloForPlayer ( playerid );
			}
			
			case 2:
			{
				CasinoPlayer [ playerid ] [ cpStage ] ++;
				SearchWinnerPlayer ( playerid );

				CasinoPlayer [ playerid ] [ cpTime ] = 5;
			}

			default:
			{
				for ( new i = 0; i < 5; i ++ )
				{
					if ( CasinoPlayer [ playerid ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
						continue;

					temp [ playerid ] [ tCasinoPlayer ] = INVALID_PLAYER_ID;
					Dialog_Show ( playerid, NULL, DIALOG_STYLE_MSGBOX, " ", "Игра завершена", "Ок", "" );
				}

				KillTimer ( temp [ playerid ] [ tTimer ] );
				ResetPlayerVariableCasino ( playerid );
				return 1;
			}
		}
	}

	for ( new i = 0; i < 5; i ++ )
	{
		if ( CasinoPlayer [ playerid ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
			continue;
		
		ShowPlayerCasino ( CasinoPlayer [ playerid ] [ cpPlayers ] [ i ] );
	}
	return 1;
}