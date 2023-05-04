stock ResetPlayerVariableCasino ( playerid )
{
	for ( new i = 0 ; i < 5; i ++ )
	{
		CasinoPlayer [ playerid ] [ cpPlayers ] [ i ] = INVALID_PLAYER_ID;
		CasinoPlayer [ playerid ] [ cpRoll ] [ i ] = 0;
	}

	CasinoPlayer [ playerid ] [ cpStavka ] =
	CasinoPlayer [ playerid ] [ cpStage ] =
	CasinoPlayer [ playerid ] [ cpWinner ] =
	CasinoPlayer [ playerid ] [ cpTime ] = 0;

	CasinoPlayer [ playerid ] [ cpStarted ] = false;

	return 1;
}

stock RandomChisloForPlayer ( playerid, indx = 0 )
{
	if ( indx != 0 )
	{
		new numb = random ( 9 ) + 1;
		for ( new i = 0; i < 5; i ++ )
		{
			if ( numb == CasinoPlayer [ playerid ] [ cpRoll ] [ i ] )
				continue;

			RandomChisloForPlayer ( playerid, indx );
			return 1;
		}

		CasinoPlayer [ playerid ] [ cpRoll ] [ indx ] = numb;
		return 1;
	}

	for ( new i = 0; i < 5; i ++ )
	{
		if ( CasinoPlayer [ playerid ] [ cpPlayers ] [ i ] == INVALID_PLAYER_ID )
			continue;

		new numb = random ( 9 ) + 1,
			bool: used;
		
		for ( new k = 0; k < 5; k ++ )
		{
			if ( numb != CasinoPlayer [ playerid ] [ cpRoll ] [ k ] )
				continue;

			RandomChisloForPlayer ( playerid, i );
			used = true;
			break;
		}

		if ( used == false )
			CasinoPlayer [ playerid ] [ cpRoll ] [ i ] = numb; 
	}

	return 1;
}

stock SearchWinnerPlayer ( playerid )
{
	new number,	
		w_id,
		query [ 128 ];

	for ( new i = 0; i < 5; i ++ )
	{
		if ( CasinoPlayer [ playerid ] [ cpRoll ] [ i ] < number )
			continue;
		
		number = CasinoPlayer [ playerid ] [ cpRoll ] [ i ];
		w_id = i;
	}

	mysql_format ( base, query, sizeof query, "INSERT INTO `logs` (`name`,count) VALUES ('%s',%i)",
		GetName ( CasinoPlayer [ playerid ] [ cpPlayers ] [ CasinoPlayer [ playerid ] [ cpWinner ] ] ),
		number
	);
	mysql_tquery ( base, query );

	CasinoPlayer [ playerid ] [ cpWinner ] = w_id;
	return 1;
}

stock ShowPlayerCasino ( playerid )
{
	new cpID = temp [ playerid ] [ tCasinoPlayer ],
		_str [ 256 ];
	
	if ( CasinoPlayer [ playerid ] [ cpWinner ] != INVALID_PLAYER_ID )
		format ( _str, sizeof _str, "���������� %i (%i)", GetName ( CasinoPlayer [ playerid ] [ cpPlayers ] [ CasinoPlayer [ playerid ] [ cpWinner ] ] ), CasinoPlayer [ playerid ] [ cpPlayers ] [ CasinoPlayer [ playerid ] [ cpWinner ] ] );
	else if ( cpID == playerid && CasinoPlayer [ playerid ] [ cpStarted ] == false )
	{
		strcat ( _str, "������ ����" );
	
		if ( CasinoPlayer [ playerid ] [ cpStavka ] == 0 )
			CasinoPlayer [ playerid ] [ cpStavka ] = random ( 10000 ) + 1;
	}
	else if ( CasinoPlayer [ playerid ] [ cpStarted ] == true )
		format ( _str, sizeof _str, "%s %i ������", (CasinoPlayer [ playerid ] [ cpStage ] == 1)?("����� �����"):("����� �����"), CasinoPlayer [ playerid ] [ cpTime ] );

	format ( _str, sizeof _str, "%s\n������: %i", CasinoPlayer [ playerid ] [ cpStavka ] );

	for ( new i = 0; i < 5; i ++ )
	{
		/*
			���� ������� ������ ������ � 1 ������ format, � �� 2-� strcat ->
			��� �������� ���������� � 1 ������ ��� strcat ��-����� ������� ������������ format, � �� ������ � ����� ������� ���������� ������������ ������ ���,
			� �� 2-� ������ �����, �� ������ ����, ��� �� ����� �������� ������� ����������
		*/
		if ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] != INVALID_PLAYER_ID )
			format ( _str, sizeof _str, "%s\n- %s", _str, GetName ( CasinoPlayer [ cpID ] [ cpPlayers ] [ i ] ) );
		else
			strcat ( _str, "\n- ������ ����" );
	}

	Dialog_Show ( playerid, casino_menu, DIALOG_STYLE_LIST, " ", _str, "�����", "�����" );
	return 1;
}