// *************
// NewPage class
// *************
class as.dialogue.NewPage extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function NewPage ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "file_textinput", 1, {_x:50, _y:35, _width:135, _height:20});
		
		setup_component_style ();
		
		setup_file_textinput ();
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
		return true;
	}

	// ********************
	// setup file textinput
	// ********************
	public function setup_file_textinput ():Void
	{
		mc_ref.file_textinput.text = "page/";
	}

	// ********
	// new page
	// ********
	public function new_page ():Void
	{
		if (data_validation () == true)
		{		
			var page_xml:XML;
			
			page_xml = new XML ();
			page_xml.ignoreWhite = true;
			page_xml ["class_ref"] = mc_ref;
			
			page_xml.sendAndLoad ("function/check_file_exists.php?target_file=" + mc_ref.file_textinput.text + ".xml", page_xml);
			
			page_xml.onLoad = function (b:Boolean)
			{
				if (b)
				{
					// if the file already exists
					if (this.firstChild.nodeName == "exists")
					{
						_root.status_mc.add_message (this.class_ref.file_textinput.text + ".xml already exists.", "critical");
					}
					// if the file not exists
					else if (this.firstChild.nodeName == "not_exists")
					{
						_root.page_mc.set_loaded_file (this.class_ref.file_textinput.text + ".xml");
						this.class_ref._parent.close_window ();
					}
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
			this.class_ref.new_page ();
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