<?php

	if ($_FILES ['Filedata']['name'] && $_GET ['target_dir'])
	{
		$target_path = "../" . $_GET ['target_dir'] . "/" . basename ($_FILES ['Filedata']['name']);
		move_uploaded_file ($_FILES ['Filedata']['tmp_name'], $target_path);
	}
	
?>
