<?php
	
	$file_name = "(get_dir.php)";
	$xml_output = "";
	
	// check if the target file is specified
	if (isset ($_GET ["target_dir"]))
	{
		$target_dir = $_GET ["target_dir"];
		
		// if the target is well defined
		if ($target_dir != "")
		{
			// if the dir is correct and can be handled, retrieve now...
			if ($handle = opendir ("../" . $target_dir))
			{
				while (false !== ($file = readdir($handle)))
				{
					if ($file != "." && $file != ".." && strpos ($file, ".") != false)
					{
						$xml_output = $xml_output . "<file>" . $file . "</file>";
					}
				}
				
				closedir ($handle);
				
				$xml_output = "<directory>" . $xml_output . "</directory>";
				
				echo ($xml_output);
			}
			else
			{
				echo ("<critical>" . $file_name . " " . $target_dir . " is not an appropriate directory.</critical>");
				exit;				
			}
		}
		else
		{
			echo ("<critical>" . $file_name . " Incorrect parameter target_dir.</critical>");
			exit;
		}
	}
	else
	{
		echo ("<critical>" . $file_name . " target_dir not set.</critical>");
		exit;
	}

?>