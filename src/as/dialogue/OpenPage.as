// **************
// OpenPage class
// **************
class as.dialogue.OpenPage extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function OpenPage ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.List, "page_list", 1, {_x:10, _y:35, _width:170, _height:110});
		
		setup_component_style ();
		
		setup_page_list ();
		setup_ok_button ();
		setup_cancel_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.path_label.setStyle ("styleName", "label_style");
		
		mc_ref.page_list.setStyle ("styleName", "list_style");
	}
	
	// ***************
	// setup page list
	// ***************
	public function setup_page_list ():Void
	{
		mc_ref.page_list.rowHeight = 17;
		
		var temp_array:Array;
		
		temp_array = _root.flaber.get_page_dir_array ();
		
		for (var i in temp_array)
		{
			mc_ref.page_list.addItem ({label:temp_array [i], data:temp_array [i]});
		}
		
		mc_ref.page_list.sortItemsBy ("label", "ASC");
		mc_ref.page_list.selectedIndex = 0;
	}
	
	// *********
	// open page
	// *********
	public function open_page ():Void
	{
		_root.page_mc.load_root_xml (mc_ref.page_list.selectedItem.data);
	}
	
	// ***************
	// setup ok button
	// ***************
	public function setup_ok_button ():Void
	{
		mc_ref.ok_button ["class_ref"] = mc_ref;
		mc_ref.ok_button.onRelease = function ()
		{
			this.class_ref.open_page ();
			this.class_ref._parent.close_window ();
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