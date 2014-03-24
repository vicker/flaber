<?php

	require_once ("password.php");

	$FILE_NAME = "(admin_login.php)";
	
	// check if the password is specified
	if (!isset ($_GET ["password"]))
	{
		echo ("<critical>" . $FILE_NAME . " target_dir not set.</critical>");
		exit;
	}

	$get_password = md5 ($_GET ["password"]);
	
	// if the password is correct return login authenticated
	if ($password == $get_password)
	{
		echo ("<login>1</login>");
		exit;
	}
	else
	{
		echo ("<critical>" . $FILE_NAME . " " . "Wrong password please try again.</critical>");
		exit;				
	}

?>
