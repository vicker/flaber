<?php

	require_once ("password.php");
	
	// check whether password is provided
	if (!isset ($_GET ['password']))
	{
		echo ("Break-in attempt.");
		exit;
	}
	
	// check whether the password is correct or not
	if (md5 ($_GET ['password']) != $password)
	{
		echo ("Break-in attempt.");
		exit;
	}

	// if it is correct~ continue the uploading process
	if ($_FILES ['Filedata']['name'] && $_GET ['target_dir'])
	{
		$target_path = "../" . $_GET ['target_dir'] . "/" . basename ($_FILES ['Filedata']['name']);
		move_uploaded_file ($_FILES ['Filedata']['tmp_name'], $target_path);
	}
	
?>
