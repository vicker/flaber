// ****************
// SaveAsPage class
// ****************
class as.dialogue.SaveAsPage extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	private var file_name:String;					// for tracer
	
	// ***********
	// constructor
	// ***********
	public function SaveAsPage ()
	{
		mc_ref = this;
		
		file_name = "(SaveAsPage.as)";		
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "file_textinput", 1, {_x:80, _y:35, _width:110, _height:20});
		
		setup_component_style ();
		
		setup_ok_button ();
		setup_cancel_button ();
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
	
	// ***************
	// data validation
	// ***************
	public function data_validation ():Boolean
	{
		if (mc_ref.file_textinput.text == "")
		{
			_root.status_mc.add_message (mc_ref.file_name + " Please enter a valid page name.", "critical");
			return false;
		}
		
		return true;
	}

	// ************
	// save as page
	// ************
	public function save_as_page ():Void
	{
		var page_xml:as.global.XMLExtend;
		
		page_xml = new as.global.XMLExtend ();
		page_xml.ignoreWhite = true;
		page_xml ["class_ref"] = mc_ref;
		
		page_xml.sendAndLoad ("function/check_file_exists.php?target_file=page/" + mc_ref.file_textinput.text + ".xml", page_xml);
		page_xml.check_progress ("Checking if file exists...");
		
		page_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				// if the file already exists
				if (this.firstChild.nodeName == "exists")
				{
					this.stop_progress ();
					_root.status_mc.add_message (this.class_ref.file_textinput.text + ".xml already exists.", "critical");
				}
				// if the file not exists
				else if (this.firstChild.nodeName == "not_exists")
				{
					_root.page_mc.set_loaded_file ("page/" + this.class_ref.file_textinput.text + ".xml");
					_root.page_mc.save_xml ();
					this.class_ref._parent.close_window ();
				}
			}
		}
	}
	
	// ***************
	// setup ok button
	// ***************
	public function setup_ok_button ():Void
	{
		mc_ref.ok_button ["class_ref"] = mc_ref;
		mc_ref.ok_button.onRelease = function ()
		{
			if (this.class_ref.data_validation () == true)
			{		
				this.class_ref.save_as_page ();
			}
		}
	}
	
	// *******************
	// setup cancel button
	// *******************
	public function setup_cancel_button ():Void
	{
		mc_ref.cancel_button ["class_ref"] = mc_ref;
		mc_ref.cancel_button.onRelease = function ()
		{
			this.class_ref._parent.close_window ();
		}
	}
}