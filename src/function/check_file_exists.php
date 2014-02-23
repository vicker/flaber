<?php

	$file_name = "(check_file_exists.php)";

	// check if the target file is specified
	if (isset ($_GET ["target_file"]))
	{
		$target_file = $_GET ["target_file"];
		
		// if the target is well defined, update now...
		if ($target_file != "")
		{
			$target_file = "../" . $target_file;
			if (is_file ($target_file))
			{
				echo ("<exists></exists>");
				exit;				
			}
			else
			{
				echo ("<not_exists></not_exists>");
				exit;				
			}
		}
		else
		{
			echo ("<critical>" . $file_name . " Incorrect parameter target_file.</critical>");
			exit;
		}
	}
	else
	{
		echo ("<critical>" . $file_name . " target_file not set.</critical>");
		exit;
	}
	
?>
