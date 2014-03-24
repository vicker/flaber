// ***************
// MenuBarMC class
// ***************
class as.menu.MenuBarMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;									// interface for the navigation item mc

	private var FILE_NAME:String = "(MenuBarMC.as)";		// for tracer
	private var edit_mode:Boolean									// storing the current edit_mode
	
	// ***********
	// constructor
	// ***********
	public function MenuBarMC ()
	{
		mc_ref = this;
		
		build_menu ();
		hide_menu ();
		
		edit_mode = false;
	}
	
	// **********
	// build menu
	// **********
	private function build_menu ():Void
	{
		mc_ref.createClassObject (mx.controls.MenuBar, "menu_mc", 1, {_x:0, _y:0, _width:Stage.width, _height:20});
		
		var menu_xml:XML = new XML ();
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
		var temp_listener:Object = new Object ();
		temp_listener ["class_ref"] = mc_ref;

		temp_listener.change = function (o:Object)
		{
			switch (o.menuItem.attributes ["instanceName"])
			{
				// *********
				// File Menu
				// *********
				
				// New Page
				case "file|new":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Save Confirmation", 190, 120, "lib_dialogue_new_page_save_confirm");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Open Page
				case "file|open":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Save Confirmation", 190, 120, "lib_dialogue_open_page_save_confirm");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Save Page
				case "file|save":
				{
					_root.save_broadcaster.set_changed_flag ();
					_root.save_broadcaster.broadcast ();
					break;
				}
				
				// Save As Page
				case "file|save_as":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Save As", 250, 120, "lib_dialogue_save_as_page");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Logout Admin
				case "file|logout":
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
				case "insert|textfield":
				{
					_root.page_mc.add_new_item ("TextFieldMC", null);
					break;
				}
				
				// Image
				case "insert|image":
				{
					_root.page_mc.add_new_item ("ImageMC", null);
					break;
				}
				
				// Link
				case "insert|link":
				{
					_root.page_mc.add_new_item ("LinkMC", null);
					break;
				}
				
				// Shape Rectangle
				case "insert|shape|rectangle":
				{
					_root.page_mc.add_new_item ("RectangleMC", null);
					break;
				}
				
				// Shape Oval
				case "insert|shape|oval":
				{
					_root.page_mc.add_new_item ("OvalMC", null);
					break;
				}
				
				// ***********
				// Modify Menu
				// ***********
				
				// Web Properties
				case "modify|web":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Web Properties", 400, 210, "lib_dialogue_web_properties");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Page Properties
				case "modify|page":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Page Properties", 700, 500, "lib_dialogue_page_properties");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// *********
				// Mode Menu
				// *********
				
				// Action Mode
				case "mode|action":
				{
					this.class_ref.change_mode (0);
					break;
				}
				
				// Edit Mode
				case "mode|edit":
				{
					this.class_ref.change_mode (1);
					break;
				}
				
				// **********
				// Tools Menu
				// **********
				
				// Depth Manager
				case "tools|depth":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Depth Manager", 220, 280, "lib_dialogue_depth_manager");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Image Uploader
				case "tools|image":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Image Uploader", 390, 60, "lib_dialogue_image_uploader");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// Change Password
				case "tools|password":
				{
					_root.sys_func.remove_window_mc ();
					_root.attachMovie ("lib_window", "window_mc", 9999);
					_root.window_mc.set_window_data ("Change Password", 210, 250, "lib_dialogue_change_password");
					_root.window_mc.content_mc.set_target_ref (mc_ref);
					
					break;
				}
				
				// ****
				// Help
				// ****
				
				// WIKI
				case "help|wiki":
				{
					_root.sys_func.build_popup (800, 600, "", "http://www.flysforum.net/flaber/wiki", 1);
					break;
				}
				
				// Forum
				case "help|forum":
				{
					_root.sys_func.build_popup (800, 600, "", "http://www.flysforum.net/flaber/forum", 1);
					break;
				}
				
				// SourceForge
				case "help|sourceforge":
				{
					_root.sys_func.build_popup (800, 600, "", "http://www.sourceforge.net/projects/flaber", 1);
					break;
				}
				
				// Donation
				case "help|donation":
				{
					_root.sys_func.build_popup (800, 600, "", "http://sourceforge.net/project/project_donations.php?group_id=152518", 1);
					break;
				}
				
				// About FLABER
				case "help|about":
				{
					this.class_ref.about_flaber ();
					break;
				}
			}
		}
		
		mc_ref.menu_mc.addEventListener("change", temp_listener);
	}
	
	// ************
	// about flaber
	// ************
	public function about_flaber ():Void
	{
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data ("About FLABER", 640, 240, "lib_dialogue_about");
		_root.window_mc.content_mc.set_target_ref (mc_ref);
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
					
					_root.handler_mc.throw_away ();
					
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
