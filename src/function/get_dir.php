<?php
	
	$FILE_NAME = "(get_dir.php)";
	$xml_output = "";
	
	// check if the target file is specified
	if (!isset ($_GET ["target_dir"]))
	{
		echo ("<critical>" . $FILE_NAME . " target_dir not set.</critical>");
		exit;
	}

	$target_dir = $_GET ["target_dir"];
	
	// if the target is well defined
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
		exit;
	}
	else
	{
		echo ("<critical>" . $FILE_NAME . " " . $target_dir . " is not an appropriate directory.</critical>");
		exit;				
	}
?>
