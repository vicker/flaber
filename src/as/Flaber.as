// ******************************
// Flaber class (central control)
// ******************************
class as.Flaber
{
	// private variables
	private var img_dir_array:Array = new Array ();				// array storing all the files in the img directory
	private var page_dir_array:Array = new Array ();			// array storing all the files in the page directory
	
	private var index_page:String = "";
	private var status_mc_mode:String = "";
	private var stored_password:String = "";
	private var version_number:String = "1.1 RC1";
	
	// ***********
	// constructor
	// ***********
	public function Flaber ()
	{
		build_root ();
		build_admin_listener ();
		config_broadcaster ();
		load_page_dir_array ();
		load_img_dir_array ();
		flaber_startup ();
		load_content ();
	}
	
	// ***********************
	// build up root variables
	// ***********************
	private function build_root ():Void
	{
		_root.sys_func = new as.global.SystemFunction;						// system function
		_root.mode_broadcaster = new as.datatype.Broadcaster (1);			// change mode broadcaster
		_root.save_broadcaster = new as.datatype.Broadcaster (2);			// save broadcaster
		_root.mc_filters = new as.global.MCFilters ();						// movieclip filters
		_root.component_style = new as.global.ComponentStyle ();			// component styles
		
		_root.custom_context = new as.global.CustomContext ();
		_root.menu = new ContextMenu (_root.custom_context.menu_builder);
		
		_root.attachMovie ("lib_page_content", "page_mc", 1, {_x:-1, _y:-1});
		_root.attachMovie ("lib_status_message", "status_mc", 3, {_x:0, _y:Stage.height - 184});
		_root.attachMovie ("lib_element_handler", "handler_mc", 4, {_x:0, _y:-30});
		_root.attachMovie ("lib_menu_bar", "menu_mc", 5, {_x:0, _y:0});
		_root.attachMovie ("lib_tooltip", "tooltip_mc", 10000);
	}
	
	// ***********************
	// build up admin listener
	// ***********************
	private function build_admin_listener ():Void
	{
		var temp_listener:Object = new Object;
		
		temp_listener ["class_ref"] = this;
		temp_listener.onKeyDown = function ()
		{
			// fire only if the menu bar is not visible
			if (_root.menu_mc._visible != true)
			{
				if (Key.isDown(Key.CONTROL) && Key.getCode() == 69)
				{
					this.class_ref.pop_admin_login ();
				}
			}
		}
		
		Key.addListener (temp_listener);
	}
	
	// ***************
	// pop admin login
	// ***************
	public function pop_admin_login ():Void
	{
		// if running in local, skip admin login and open menu directly
		if (_url.indexOf ("file") == 0)
		{
			_root.menu_mc._visible = true;
		}
		else
		{
			if (_root.window_mc)
			{
				_root.window_mc.close_window ();
			}
			
			_root.attachMovie ("lib_window", "window_mc", 9999);
			_root.window_mc.set_window_data ("Admin Login", 210, 120, "lib_dialogue_admin_login");
		}
	}
	
	// ******************
	// config broadcaster
	// ******************
	private function config_broadcaster ():Void
	{
		// this line is a must
		_root.save_broadcaster.add_observer (_root.page_mc);
	}
	
	// *******************
	// load page dir array
	// *******************
	public function load_page_dir_array ():Void
	{
		var dir_xml:as.datatype.XMLExtend = new as.datatype.XMLExtend ();
		dir_xml.ignoreWhite = true;
		dir_xml ["class_ref"] = this;
      		
		dir_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				var temp_node:XMLNode = this.firstChild;
			
				// if the data retrieved correctly
				if (temp_node.nodeName == "directory")
				{
					// initialize the array
           		this.class_ref.page_dir_array = new Array ();

					for (var i in temp_node.childNodes)
					{
						var temp_value:String = "page/" + temp_node.childNodes [i].firstChild.nodeValue;
						
						this.class_ref.page_dir_array.push (temp_value);
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
		
		dir_xml.sendAndLoad ("function/get_dir.php?target_dir=page&break_cache=" + new Date ().getTime ().toString (), dir_xml);
		dir_xml.check_progress ("Building page directory...");
	}
	
	// ******************
	// load img dir array
	// ******************
	public function load_img_dir_array ():Void
	{
		var img_xml:as.datatype.XMLExtend = new as.datatype.XMLExtend ();
		img_xml.ignoreWhite = true;
		img_xml ["class_ref"] = this;
		
		img_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				var temp_node:XMLNode = this.firstChild;
				
				// if the data retrieved correctly
				if (temp_node.nodeName == "directory")
				{
					// initialize the array
           		this.class_ref.img_dir_array = new Array ();

					for (var i in temp_node.childNodes)
					{
						var temp_value:String = "img/" + temp_node.childNodes [i].firstChild.nodeValue;
						
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
		
		img_xml.sendAndLoad ("function/get_dir.php?target_dir=img&break_cache=" + new Date ().getTime ().toString (), img_xml);
		img_xml.check_progress ("Building image directory...");
	}
	
	// **************
	// flaber startup
	// **************
	private function flaber_startup ():Void
	{
		_root.status_mc.add_message ("<flaber_f>F</flaber_f><flaber_l>L</flaber_l><flaber_a>A</flaber_a><flaber_b>B</flaber_b><flaber_e>E</flaber_e><flaber_r>R</flaber_r> " + version_number + " (http://www.sourceforge.net/projects/flaber)", "flaber");
	}
	
	// ************
	// load content
	// ************
	private function load_content ():Void
	{
		var flaber_xml:as.datatype.XMLExtend = new as.datatype.XMLExtend ();
		flaber_xml ["class_ref"] = this;
		flaber_xml.ignoreWhite = true;
		
		flaber_xml.onLoad = function (b:Boolean)
		{
			if (b)
			{
				var temp_node:XMLNode = this.firstChild;
				
				for (var i in temp_node.childNodes)
				{
					var temp_name:String = temp_node.childNodes [i].nodeName;
					var temp_value:String = temp_node.childNodes [i].firstChild.nodeValue;
					
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
						
						// StatusMessage
						case "StatusMessage":
						{
							this.class_ref.status_mc_mode = temp_value;
							
							if (temp_value == "off")
							{
								_root.status_mc.throw_away ();
							}
							
							break;
						}
					}
				}
			}
		}
		
		flaber_xml.sendAndLoad ("Flaber.xml" + _root.sys_func.get_break_cache (), flaber_xml, "POST");
		flaber_xml.check_progress ("Loading global config files...");
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

	// *******************
	// set stored password
	// *******************
	public function set_stored_password (s:String):Void
	{
		stored_password = s;
	}
	
	// *******************
	// get stored password
	// *******************
	public function get_stored_password ():String
	{
		return (stored_password);
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
	// set status mc mode
	// ******************
	public function set_status_mc_mode (s:String):Void
	{
		status_mc_mode = s;
	}

	// ******************
	// get status mc mode
	// ******************
	public function get_status_mc_mode ():String
	{
		return (status_mc_mode);
	}

	// ******************
	// get version number
	// ******************
	public function get_version_number ():String
	{
		return (version_number);
	}
}
