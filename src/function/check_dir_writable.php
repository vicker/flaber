<?php

	$FILE_NAME = "(check_dir_writable.php)";

	// check if the target dir is specified
	if (!isset ($_GET ["target_dir"]))
	{
		echo ("<critical>" . $FILE_NAME . " target_dir not set.</critical>");
		exit;
	}

	$target_dir = $_GET ["target_dir"];
	
	// if the target is well defined, check now...
	if ($target_dir == "")
	{
		echo ("<critical>" . $FILE_NAME . " Incorrect parameter target_dir.</critical>");
		exit;
	}

	// if the target wants to get upper folder of flaber, block...
	if (eregi('../', $target_dir))
	{
  	echo ("<critical>" . $FILE_NAME . " Only path within flaber is accessible.</critical>");
  	exit;
	}

	// if the target is writable
	if (is_writable ("../" . $target_dir))
	{
		echo ("<writable />");
		exit;				
	}
	else
	{
		echo ("<not_writable />");
		exit;				
	}
	
?>
