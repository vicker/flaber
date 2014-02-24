<?php

	$file_name = "(check_dir_writable.php)";

	// check if the target dir is specified
	if (isset ($_GET ["target_dir"]))
	{
		$target_dir = $_GET ["target_dir"];
		
		// if the target is well defined, check now...
		if ($target_dir != "")
		{
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
		}
		else
		{
			echo ("<critical>" . $target_dir . " Incorrect parameter target_dir.</critical>");
			exit;
		}
	}
	else
	{
		echo ("<critical>" . $target_dir . " target_dir not set.</critical>");
		exit;
	}
	
?>
