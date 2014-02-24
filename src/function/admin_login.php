<?php

	$password = "flaber";
	$file_name = "(admin_login.php)";
	
	// check if the password is specified
	if (isset ($_GET ["password"]))
	{
		$get_password = $_GET ["password"];
		
		// if the password if correct return login authenticated
		if ($password == $get_password)
		{
			echo ("<login>1</login>");
		}
		else
		{
			echo ("<critical>" . $file_name . " " . "Wrong password please try again.</critical>");
			exit;				
		}
	}
	else
	{
		echo ("<critical>" . $file_name . " target_dir not set.</critical>");
		exit;
	}

?>