// ************************
// NewPageSaveConfirm class
// ************************
class as.dialogue.NewPageSaveConfirm extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function NewPageSaveConfirm ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.Label, "file_label", 1, {_x:20, _y:35, _width:140, _height:20});

		mc_ref.attachMovie ("lib_button_mc", "yes_button", 2, {_x:10, _y:70});
		mc_ref.attachMovie ("lib_button_mc", "no_button", 3, {_x:90, _y:70});
		
		setup_component_style ();
		
		setup_file_label ();
		setup_yes_button ();
		setup_no_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.message_label.setStyle ("styleName", "label_style");
		mc_ref.file_label.setStyle ("textAlign", "center");
	}
	
	// ****************
	// setup file label
	// ****************
	public function setup_file_label ():Void
	{
		mc_ref.file_label.text = "(" + _root.page_mc.get_loaded_file () + ")";
	}
	
	// ********************
	// open new page window
	// ********************
	public function open_new_page_window ():Void
	{
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data ("New Page", 250, 120, "lib_dialogue_new_page");
		_root.window_mc.content_mc.set_target_ref (mc_ref);
	}
	
	// ****************
	// setup yes button
	// ****************
	public function setup_yes_button ():Void
	{
		mc_ref.yes_button.set_toggle_flag (false);
		mc_ref.yes_button.set_dimension (70, 20);
		mc_ref.yes_button.set_text ("Yes");

		mc_ref.yes_button ["class_ref"] = mc_ref;
		mc_ref.yes_button.onRelease = function ()
		{
			// save page mc
			_root.page_mc.save_xml ();
			
			//TODO mechanism to prevent save fail but still close
			
			// rebuild page mc
			_root.page_mc.destroy ();
			
			// call up new page window
			this.class_ref.open_new_page_window ();
		}
	}
	
	// ***************
	// setup no button
	// ***************
	public function setup_no_button ():Void
	{
		mc_ref.no_button.set_toggle_flag (false);
		mc_ref.no_button.set_dimension (70, 20);
		mc_ref.no_button.set_text ("No");

		mc_ref.no_button ["class_ref"] = mc_ref;
		mc_ref.no_button.onRelease = function ()
		{
			// rebuild page mc
			_root.page_mc.destroy ();
			
			// call up new page window
			this.class_ref.open_new_page_window ();
		}
	}
}
