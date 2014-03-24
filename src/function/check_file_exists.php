<?php

	$FILE_NAME = "(check_file_exists.php)";

	// check if the target file is specified
	if (!isset ($_GET ["target_file"]))
	{
		echo ("<critical>" . $FILE_NAME . " target_file not set.</critical>");
		exit;
	}

	$target_file = $_GET ["target_file"];
	
	// if the target is well defined, check now...
	if ($target_file == "")
	{
		echo ("<critical>" . $FILE_NAME . " Incorrect parameter target_file.</critical>");
		exit;
	}

	// if the target wants to get upper folder of flaber, block...
	if (eregi('../', $target_dir))
	{
  	echo ("<critical>" . $FILE_NAME . " Only path within flaber is accessible.</critical>");
  	exit;
	}

	// if it is a file and exists
	$target_file = "../" . $target_file;
	if (is_file ($target_file))
	{
		echo ("<exists />");
		exit;				
	}
	else
	{
		echo ("<not_exists />");
		exit;				
	}
	
?>
