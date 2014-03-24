<?php

	$FILE_NAME = "(update_xml.php)";

	// check if the target file is specified
	if (!isset ($_GET ["target_file"]))
	{
		echo ("<critical>" . $FILE_NAME . " target_file not set.</critical>");
		exit;
	}
		
	$target_file = $_GET ["target_file"];
	
	// if the target is well defined, update now...
	if ($target_file == "")
	{
		echo ("<critical>" . $FILE_NAME . " Incorrect parameter target_file.</critical>");
		exit;
	}
	
	
	$target_file = "../" . $target_file;
	
	// if it is a file
	if (is_file ($target_file))
	{
		if (!is_writable ($target_file))
		{
			echo ("<critical>" . $FILE_NAME . " " . $target_file . " is not writable.</critical>");
			exit;
		}		

		$fp = fopen($target_file, "w");
		
		$raw_xml = file_get_contents("php://input");
		fwrite($fp, $raw_xml);
		
		fclose ($fp);
		echo ("<normal>" . $FILE_NAME . " " . $target_file . " updated successfully.</normal>");
		exit;
	}
	
	// if it is a folder
	else
	{
		$target_folder = substr ($target_file, 0, strrpos ($target_file, "/") + 1);
		
		if (!is_writable ($target_folder))
		{
			$folder_name = substr ($target_folder, strpos ($target_file, "/") + 1);
			$folder_name = substr ($folder_name, 0, strpos ($folder_name, "/"));
			
			echo ("<critical>" . $FILE_NAME . " " . $folder_name  . " folder is not writable.</critical>");
			exit;
		}			
		
		$fp = fopen($target_file, "w");
		
		$raw_xml = file_get_contents("php://input");
		fwrite($fp, $raw_xml);
		
		fclose ($fp);
		echo ("<normal>" . $FILE_NAME . " " . $target_file . " created successfully.</normal>");
		exit;
	}
	
?>
