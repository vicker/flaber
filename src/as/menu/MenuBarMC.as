// ***************
// MenuBarMC class
// ***************
class as.menu.MenuBarMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;						// interface for the navigation item mc

	private var file_name:String;						// for tracer
	private var edit_mode:Boolean						// storing the current edit_mode
	
	// ***********
	// constructor
	// ***********
	public function MenuBarMC ()
	{
		mc_ref = this;
		
		file_name = "(MenuBarMC.as)";
		
		build_menu ();
		hide_menu ();
		
		edit_mode = false;
	}
	
	// **********
	// build menu
	// **********
	public function build_menu ():Void
	{
		mc_ref.createClassObject (mx.controls.MenuBar, "menu_mc", 1, {_x:0, _y:0, _width:Stage.width, _height:20});
		
		var menu_xml:XML;
		
		menu_xml = new XML ();
		menu_xml.ignoreWhite = true;
		menu_xml ["class_ref"] = mc_ref;
		
		menu_xml.onLoad = function (s:Boolean)
		{
			if (s)
			{
				this.class_ref.menu_mc.dataProvider = this.firstChild;
				this.class_ref.setup_menu_action ();
			}
		}
		
		menu_xml.sendAndLoad ("MenuBar.xml" + _root.sys_func.get_break_cache (), menu_xml, "POST");
	}
	
	// *****************
	// setup menu action
	// *****************
	public function setup_menu_action ():Void
	{
		// reference http://www.darronschall.com/weblog/archives/000062.cfm
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function (o:Object)
		{
			switch (o.menuItem)
			{
				// *********
				// File Menu
				// *********
				
				// New Page
				case o.menu.file_new:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_new_page_save_confirm";
					temp_name = "Save Confirmation";
					temp_width = 200;
					temp_height = 130;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Open Page
				case o.menu.file_open:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_open_page_save_confirm";
					temp_name = "Save Confirmation";
					temp_width = 200;
					temp_height = 130;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Save Page
				case o.menu.file_save:
				{
					_root.save_broadcaster.set_changed_flag ();
					_root.save_broadcaster.broadcast ();
					break;
				}
				
				// Save As Page
				case o.menu.file_save_as:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_save_as_page";
					temp_name = "Save As";
					temp_width = 240;
					temp_height = 130;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Logout Admin
				case o.menu.file_logout:
				{
					//TODO should have some mechanism stating that the file is not saved
					this.class_ref.hide_menu ();
					
					// return to action mode if currently in edit mode
					this.class_ref.change_mode (0);
					
					break;
				}
				
				// ***********
				// Insert Menu
				// ***********
				
				// Textfield
				case o.menu.insert_textfield:
				{
					_root.page_mc.add_new_item ("TextFieldMC", null);
					break;
				}
				
				// Image
				case o.menu.insert_image:
				{
					_root.page_mc.add_new_item ("ImageMC", null);
					break;
				}
				
				// Link
				case o.menu.insert_link:
				{
					_root.page_mc.add_new_item ("LinkMC", null);
					break;
				}
				
				// Shape Rectangle
				case o.menu.insert_shape_rectangle:
				{
					_root.page_mc.add_new_item ("RectangleMC", null);
					break;
				}
				
				// ***********
				// Modify Menu
				// ***********
				
				// Web Properties
				case o.menu.modify_web:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_web_properties";
					temp_name = "Web Properties";
					temp_width = 230;
					temp_height = 290;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Page Properties
				case o.menu.modify_page:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_page_properties";
					temp_name = "Page Properties";
					temp_width = 700;
					temp_height = 510;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// *********
				// Mode Menu
				// *********
				
				// Action Mode
				case o.menu.mode_action:
				{
					this.class_ref.change_mode (0);
					break;
				}
				
				// Edit Mode
				case o.menu.mode_edit:
				{
					this.class_ref.change_mode (1);
					break;
				}
				
				// **********
				// Tools Menu
				// **********
				
				// Depth Manager
				case o.menu.tools_depth:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_depth_manager";
					temp_name = "Depth Manager";
					temp_width = 220;
					temp_height = 270;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Image Uploader
				case o.menu.tools_image:
				{
					var temp_lib:String;
					var temp_name:String;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_lib = "lib_dialogue_image_uploader";
					temp_name = "Image Uploader";
					temp_width = 375;
					temp_height = 75;
					
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
			}
		}
		
		mc_ref.menu_mc.addEventListener("change", temp_listener);
	}
	
	// *********
	// hide menu
	// *********
	public function hide_menu ():Void
	{
		mc_ref._visible = false;
		mc_ref.enabled = false;
	}
	
	// *********
	// show menu
	// *********
	public function show_menu ():Void
	{
		mc_ref._visible = true;
		mc_ref.enabled = true;
	}

	// ***********
	// change mode
	// ***********
	public function change_mode (b:Boolean):Void
	{
		switch (b)
		{
			// change to action mode
			case 0:
			{
				if (edit_mode == true)
				{
					edit_mode = false;
					
					_root.mode_broadcaster.set_changed_flag ();
					_root.mode_broadcaster.broadcast (false);
					
					_root.edit_panel_mc.throw_away ();
					
					if (_root.window_mc)
					{
						_root.window_mc.close_window ();
					}
				}
				
				break;
			}
			
			// change to edit mode
			case 1:
			{
				if (edit_mode == false)
				{
					edit_mode = true;
					
					_root.mode_broadcaster.set_changed_flag ();
					_root.mode_broadcaster.broadcast (true);
				}
				
				break;
			}
		}
	}

	// *************
	// get edit mode
	// *************
	public function get_edit_mode ():Boolean
	{
		return edit_mode;
	}	
}
