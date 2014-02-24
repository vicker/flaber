// ******************************
// Flaber class (central control)
// ******************************
class as.Flaber
{
	// private variables
	private var page_dir_array:Array;				// array storing all the files in the page directory
	private var img_dir_array:Array;					// array storing all the files in the img directory
	
	private var index_page:String;
	
	private var version_number:String;
	
	// ***********
	// constructor
	// ***********
	public function Flaber ()
	{
		build_root ();
		build_admin_listener ();
		config_broadcaster ();
		preload_page_dir_array ();
		preload_img_dir_array ();
		flaber_startup ();
		load_content ();
	}
	
	// ***********************
	// build up root variables
	// ***********************
	private function build_root ():Void
	{
		_root.sys_func = new as.global.SystemFunction ();				// system function
		_root.mode_broadcaster = new as.global.Broadcaster (1);		// change mode broadcaster
		_root.save_broadcaster = new as.global.Broadcaster (2);		// save broadcaster
		_root.mc_filters = new as.global.MCFilters ();					// movieclip filters
		_root.component_style = new as.global.ComponentStyle ();		// component styles
		
		// make sure that if this line change, also change in NewPageSaveConfirm.as
		_root.attachMovie ("lib_page_content", "page_mc", 1, {_x:-1, _y:-1});
		
		_root.attachMovie ("lib_status_message", "status_mc", 3, {_x:0, _y:Stage.height - 184});
		_root.attachMovie ("lib_edit_panel", "edit_panel_mc", 4, {_x:0, _y:-30});
		_root.attachMovie ("lib_menu_bar", "menu_mc", 5, {_x:0, _y:0});
		_root.attachMovie ("lib_tooltip", "tooltip_mc", 10000);
	}
	
	// ***********************
	// build up admin listener
	// ***********************
	private function build_admin_listener ():Void
	{
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener.onKeyDown = function ()
		{
			// fire only if the menu bar is not visible
			if (_root.menu_mc._visible != true)
			{
				if (Key.isDown(Key.CONTROL) && Key.getCode() == 69)
				{
					// if running in local, skip admin login and open menu directly
					if (_url.indexOf ("file") == 0)
					{
						_root.menu_mc._visible = true;
					}
					else
					{
						var temp_lib:String;
						var temp_name:String;
						var temp_width:Number;
						var temp_height:Number;
						
						temp_lib = "lib_dialogue_admin_login";
						temp_name = "Admin Login";
						temp_width = 200;
						temp_height = 130;
						
						if (_root.window_mc)
						{
							_root.window_mc.close_window ();
						}
						_root.attachMovie ("lib_window", "window_mc", 9999);
						_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
					}
				}
			}
		}
		
		Key.addListener (temp_listener);
	}
	
	// ******************
	// config broadcaster
	// ******************
	private function config_broadcaster ():Void
	{
		// this line is a must
		_root.save_broadcaster.add_observer (_root.page_mc);
	}
	
	// **************
	// flaber startup
	// **************
	private function flaber_startup ():Void
	{
		version_number = "1.0 RC3 (Final) (http://www.sourceforge.net/projects/flaber)";
		
		_root.status_mc.add_message ("<flaber_f>F</flaber_f><flaber_l>L</flaber_l><flaber_a>A</flaber_a><flaber_b>B</flaber_b><flaber_e>E</flaber_e><flaber_r>R</flaber_r> " + version_number, "flaber");
	}
	
	// ************
	// load content
	// ************
	private function load_content ():Void
	{
		var flaber_xml:XML;
		flaber_xml = new XML ();
		flaber_xml ["class_ref"] = this;
		flaber_xml.ignoreWhite = true;
		flaber_xml.sendAndLoad ("Flaber.xml" + _root.sys_func.get_break_cache (), flaber_xml, "POST");
		
		flaber_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				var temp_node:XMLNode;
				temp_node = this.firstChild;
				
				for (var i in temp_node.childNodes)
				{
					var temp_name:String;
					var temp_value:String;
					temp_name = temp_node.childNodes [i].nodeName;
					temp_value = temp_node.childNodes [i].firstChild.nodeValue;
					
					switch (temp_name)
					{
						// NavigationMenu
						case "NavigationMenu":
						{
							_root.attachMovie ("lib_navigation_menu", "navigation_menu", 2, {_x:20, _y:20});
							_root.navigation_menu.load_root_xml (temp_value);
							_root.mode_broadcaster.add_observer (_root.navigation_menu);
							_root.save_broadcaster.add_observer (_root.navigation_menu);
							break;
						}
						
						// Index page
						case "index_page":
						{
							this.class_ref.index_page = temp_value;
							_root.page_mc.load_root_xml (temp_value);
							break;
						}
						
						// MC Transitions
						case "MCTransitions":
						{
							_root.mc_transitions = new as.global.MCTransitions ();
							_root.mc_transitions.set_transition_ref (_root.page_mc);
							_root.mc_transitions.set_transition_style (temp_value);
							break;
						}
					}
				}
			}
		}
	}
	
	// ****************
	// preload page dir
	// ****************
	private function preload_page_dir_array ():Void
	{
		// initialize the page dir array
		this.page_dir_array = new Array ();
		
		var dir_xml:XML;
		
		dir_xml = new XML ();
		dir_xml.ignoreWhite = true;
		dir_xml ["class_ref"] = this;
		dir_xml.sendAndLoad ("function/get_dir.php?target_dir=page", dir_xml);
		
		dir_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				// if the data retrieved correctly
				if (this.firstChild.nodeName == "directory")
				{
					for (var i in this.firstChild.childNodes)
					{
						var temp_value:String;
						
						temp_value = this.firstChild.childNodes [i].firstChild.nodeValue;
						
						this.class_ref.page_dir_array.push ("page/" + temp_value);
					}
					
					this.class_ref.page_dir_array.sort ();
				}
				// if have error
				else
				{
					_root.status_mc.add_message (this.toString (), "");
				}
			}
		}
	}
	
	// ***************
	// preload img dir
	// ***************
	private function preload_img_dir_array ():Void
	{
		// initialize the page dir array
		this.img_dir_array = new Array ();
		
		var img_xml:XML;
		
		img_xml = new XML ();
		img_xml.ignoreWhite = true;
		img_xml ["class_ref"] = this;
		img_xml.sendAndLoad ("function/get_dir.php?target_dir=img", img_xml);
		
		img_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				// if the data retrieved correctly
				if (this.firstChild.nodeName == "directory")
				{
					for (var i in this.firstChild.childNodes)
					{
						var temp_value:String;
						
						temp_value = this.firstChild.childNodes [i].firstChild.nodeValue;
						
						this.class_ref.img_dir_array.push (temp_value);
					}
					
					this.class_ref.img_dir_array.sort ();
				}
				// if have error
				else
				{
					_root.status_mc.add_message (this.toString (), "");
				}
			}
		}
	}
	
	// ******************
	// get page dir array
	// ******************
	public function get_page_dir_array ():Array
	{
		return (page_dir_array);
	}
	
	// *****************
	// get img dir array
	// *****************
	public function get_img_dir_array ():Array
	{
		return (img_dir_array);
	}

	// **************
	// set index page
	// **************
	public function set_index_page (s:String):Void
	{
		index_page = s;
	}

	// **************
	// get index page
	// **************
	public function get_index_page ():String
	{
		return (index_page);
	}

	// ******************
	// get version number
	// ******************
	public function get_version_number ():String
	{
		return (version_number);
	}
}