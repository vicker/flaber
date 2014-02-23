<?php

	$file_name = "(update_xml.php)";

	// check if the target object is specified
	if (isset ($_GET ["target_object"]))
	{
		// for different target, update different xml file
		switch ($_GET ["target_object"])
		{
			case "navigation_menu":
			{
				$target_file = "NavigationMenu.xml";
				break;
			}
			default:
			{
				$target_file = "";
				break;
			}
		}
		
		// if the target is well defined, update now...
		if ($target_file != "")
		{
			$raw_xml = file_get_contents("php://input");
			
			if (is_file ($target_file))
			{
				if (is_writable ($target_file))
				{
					$fp = fopen($target_file, "w");
					fclose ($fp);
					print ("<normal>" . $file_name . " " . $target_file . " updated successfully.</critical>");
				}
				else
				{
					print ("<critical>" . $file_name . " " . $target_file . " is not writable.</critical>");
					exit;				
				}
			}
			else
			{
				print ("<critical>" . $file_name . " " . $target_file . " does not exists.</critical>");
				exit;				
			}
		}
		else
		{
			print ("<critical>" . $file_name . " Incorrect parameter target_file.</critical>");
			exit;
		}
	}
	else
	{
		print ("<critical>" . $file_name . " Incorrect parameter target_object.</critical>");
		exit;
	}
	
?>
