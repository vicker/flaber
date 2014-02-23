<?php

	$file_name = "update_xml.php";

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
			
			$fp = fopen($target_file, "w");
			fwrite($fp, $raw_xml);
			fclose($fp);
			
			print ($file_name . ": Update finished. " . $target_file . " updated.");
		}
		else
		{
			print ($file_name . ": Update failed. Target not inside scope.");
		}
	}
	else
	{
		print ($file_name . ": Update failed. Target not specified.");
	}
	
?>
