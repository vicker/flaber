// *************************
// OpenPageSaveConfirm class
// *************************
class as.dialogue.OpenPageSaveConfirm extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function OpenPageSaveConfirm ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.Label, "file_label", 1, {_x:20, _y:35, _width:150, _height:20});
		
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
	public function open_open_page_window ():Void
	{
		var temp_lib:String;
		var temp_name:String;
		var temp_width:Number;
		var temp_height:Number;
		
		temp_lib = "lib_dialogue_open_page";
		temp_name = "Open Page";
		temp_width = 210;
		temp_height = 230;
		
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
		_root.window_mc.content_mc.set_target_ref (mc_ref);
	}
	
	// ****************
	// setup yes button
	// ****************
	public function setup_yes_button ():Void
	{
		mc_ref.yes_button ["class_ref"] = mc_ref;
		mc_ref.yes_button.onRelease = function ()
		{
			// save page mc
			_root.page_mc.save_xml ();
			
			//TODO mechanism to prevent save fail but still close
			
			// rebuild page mc
			_root.page_mc.removeMovieClip ();
			_root.attachMovie ("lib_page_content", "page_mc", 1, {_x:-1, _y:-1});
			
			// call up new page window
			this.class_ref.open_open_page_window ();
		}
	}
	
	// ***************
	// setup no button
	// ***************
	public function setup_no_button ():Void
	{
		mc_ref.no_button ["class_ref"] = mc_ref;
		mc_ref.no_button.onRelease = function ()
		{
			// rebuild page mc
			_root.page_mc.removeMovieClip ();
			_root.attachMovie ("lib_page_content", "page_mc", 1, {_x:-1, _y:-1});
			
			// call up new page window
			this.class_ref.open_open_page_window ();
		}
	}
}