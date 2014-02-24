// *******************
// ImageUploader class
// *******************
class as.dialogue.ImageUploader extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	private var file_name:String;					// for tracer
	
	private var file_ref:flash.net.FileReference;

	// ***********
	// constructor
	// ***********
	public function ImageUploader ()
	{
		mc_ref = this;
		
		file_name = "(ImageUploader.as)";		
		
		setup_component_object ();
		setup_file_ref ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "file_textinput", 1, {_x:10, _y:10, _width:150, _height:20});
		
		setup_component_style ();
		
		setup_file_textinput ();
		setup_browse_button ();
		setup_upload_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.message_label.setStyle ("styleName", "label_style");
		mc_ref.file_pre_label.setStyle ("styleName", "label_style");
		mc_ref.file_post_label.setStyle ("styleName", "label_style");
		
		mc_ref.file_textinput.setStyle ("styleName", "textinput_style");
	}

	// ********************
	// setup file textinput
	// ********************
	public function setup_file_textinput ():Void
	{
		mc_ref.file_textinput.enabled = false;
	}

	// **************
	// setup file ref
	// **************
	public function setup_file_ref ():Void
	{
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.onSelect = function (f:flash.net.FileReference):Void
		{
			this.class_ref.file_textinput.text = f.name;
		}
		
		temp_listener.onProgress = function (f:flash.net.FileReference, l:Number, t:Number):Void
		{
			var temp_string:String;
			var temp_percentage:Number;
			var temp_size:Number;
			
			temp_percentage = Math.round (l / t * 10000) / 100;
			temp_size = Math.round (f.size / 1024);
			temp_string = "Uploading " + f.name + "... " + temp_percentage + "% of " + temp_size + "Kb";
			
			_root.status_mc.add_message (temp_string , "tooltip");
		}
		
		temp_listener.onComplete = function (f:flash.net.FileReference):Void
		{
			var temp_string:String;
			
			temp_string = f.name + " uploaded successfully.";
			_root.status_mc.add_message (temp_string , "normal");
			
			this.class_ref._parent.close_window ();
			
			// update img array
			_root.flaber.preload_img_dir_array ();
		}
		
		file_ref = new flash.net.FileReference ();
		file_ref.addListener (temp_listener);
	}

	// ***************
	// data validation
	// ***************
	public function data_validation ():Boolean
	{
		if (mc_ref.file_textinput.text == "")
		{
			_root.status_mc.add_message (mc_ref.file_name + " Please select a valid file.", "critical");
			return false;
		}
		
		return true;
	}

	// ***********
	// browse file
	// ***********
	public function browse_file ():Void
	{
		file_ref.browse ([{description: "Image Files", extension: "*.jpg; *.gif; *.png", macType: "JPEG; jp2_; GIFF"},
								{description: "Flash Movies", extension: "*.swf", macType: "SWFL"}]);
	}
	
	// ***********
	// upload file
	// ***********
	public function upload_file ():Void
	{
		var dir_xml:as.global.XMLExtend;
		
		dir_xml = new as.global.XMLExtend ();
		dir_xml.ignoreWhite = true;
		dir_xml ["class_ref"] = mc_ref;
		
		dir_xml.sendAndLoad ("function/check_dir_writable.php?target_dir=img", dir_xml);
		dir_xml.check_progress ("Checking img folder writing permission.. ");
		
		dir_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				// if the directory is writable
				if (this.firstChild.nodeName == "writable")
				{
					this.class_ref.upload_button.enabled = false;
					
					this.class_ref.file_ref.upload ("function/upload_file.php?target_dir=img");
				}
				// if the directory is not writable
				else if (this.firstChild.nodeName == "not_writable")
				{
					this.class_ref.upload_button.enabled = true;
					
					this.stop_progress ();
					_root.status_mc.add_message ("Img folder is not writable.", "critical");
				}
			}
		}
	}
	
	// *******************
	// setup browse button
	// *******************
	public function setup_browse_button ():Void
	{
		mc_ref.browse_button ["class_ref"] = mc_ref;
		mc_ref.browse_button.onRelease = function ()
		{
			this.class_ref.browse_file ();
		}
	}
	
	// *******************
	// setup cancel button
	// *******************
	public function setup_upload_button ():Void
	{
		mc_ref.upload_button ["class_ref"] = mc_ref;
		mc_ref.upload_button.onRelease = function ()
		{
			if (this.class_ref.data_validation () == true)
			{
				this.class_ref.upload_file ();
			}
		}
	}
}