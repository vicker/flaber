<?php

	require_once ("password.php");
	
	// check whether password is provided
	if (!isset ($_GET ['password']))
	{
		echo ("<critical>Empty password.</critical>");
		exit;
	}
	
	// check whether the password is correct or not
	if (md5 ($_GET ['password']) != $password)
	{
		echo ("<critical>Incorrect password.</critical>");
		exit;
	}

	// check whether the new password is set
	if (!isset ($_GET ['new_password']))
	{
		echo ("<critical>Empty new password.</critical>");
		exit;
	}

	// if it is correct~ continue the change password process
	if (!is_writable ("password.php"))
	{
		echo ("<critical>password.php is not writable.</critical>");
		exit;
	}
	
	$password_file = fopen("password.php", "w");
	
	fwrite($password_file, '<');
	fwrite($password_file, '?');
	fwrite($password_file, ' $password = ');
	fwrite($password_file, "'");
	fwrite($password_file, md5 ($_GET ['new_password']));
	fwrite($password_file, "'");
	fwrite($password_file, '; ');
	fwrite($password_file, '?');
	fwrite($password_file, '>');
	
	echo ("<changed />");
?>
