// **********************
// NavigationMenuMC class
// **********************
class as.menu.NavigationMenuMC extends MovieClip
{
	// MC variables
	// MovieClip					edit_mode_bg
	
	// private variables
	private var data_xml:XMLNode;					// xml data
	private var config_xml:XMLNode;				// xml config
	
	private var text_format:TextFormat;			// text format of the menu items
	private var menu_style:Object;				// menu style's linkage name
	
	private var item_mc_array:Array;				// array storing all the menu items
	
	private var mc_ref:MovieClip;					// reference back to the navigation menu mc
	
	private var file_name:String;					// for tracer
	private var loaded_file:String;				// loaded file name

	// ***********
	// constructor
	// ***********
	public function NavigationMenuMC ()
	{
		mc_ref = this; 
		
		text_format = new TextFormat ();
		menu_style = new Object ();
		item_mc_array = new Array ();
		
		file_name = "(NavigationMenuMC.as)";
		
		mc_ref.edit_mode_bg_tag._visible = false;
	}

	// **********
	// destructor
	// **********
	public function destroy ():Void
	{
		for (var i in item_mc_array)
		{
			item_mc_array [i].removeMovieClip ();
		}
		
		item_mc_array = new Array ();
	}

	// ******************
	// delete one item mc
	// ******************
	public function destroy_one (m:MovieClip):Void
	{
		for (var i in item_mc_array)		{
			if (item_mc_array [i] == m)
			{
				item_mc_array [i].removeMovieClip ();
				item_mc_array [i].splice (i, 1);
				
				break;
			}
		}
	}

	// ***************
	// add one item mc
	// ***************
	public function add_one ():Void
	{
		var temp_mc:MovieClip;
		temp_mc = mc_ref.attachMovie (menu_style ["name"], "menu_item_" + mc_ref.getNextHighestDepth (), mc_ref.getNextHighestDepth ());
		item_mc_array.push (temp_mc);
		
		var temp_xml:XML;
		temp_xml = new XML ("<NavigationItemMC style='global'><x>20</x><y>20</y><text>Dummy</text></NavigationItemMC>");
		temp_mc.set_data_xml (temp_xml.firstChild, text_format);
		
		temp_mc.broadcaster_event (_root.menu_mc.get_edit_mode ());
	}

	// *******************
	// onrollover override
	// *******************
	public function onRollOver_event ()
	{
		_root.mc_filters.set_brightness_filter (mc_ref);
		_root.tooltip_mc.set_content (mc_ref._name);
		_root.status_mc.add_message ("Click to bring up the edit panel" , "tooltip");
	}
	
	// ******************
	// onrollout override
	// ******************
	public function onRollOut_event ()
	{
		_root.mc_filters.remove_filter (mc_ref);
		_root.tooltip_mc.throw_away ();
	}
	
	// ****************
	// onpress override
	// ****************
	public function onPress_event ()
	{
		pull_edit_panel ();
	}
	
	// *************
	// load root xml
	// *************
	public function load_root_xml (s:String):Void
	{
		loaded_file = s;
		
		// xml data loading
		var root_xml:as.global.XMLExtend;
		root_xml = new as.global.XMLExtend ();
		root_xml ["class_ref"] = this;
		root_xml.ignoreWhite = true;
		root_xml.sendAndLoad (s + _root.sys_func.get_break_cache (), root_xml, "POST");
		root_xml.check_progress ("Loading navigation menu...");
		
		root_xml.onLoad = function (b:Boolean)
		{
			// when xml loading is success
			if (b)
			{
				this.class_ref.set_root_xml (this);
			}
			else
			{
				_root.status_mc.add_message (this.class_ref.file_name + " load root xml fail.", "critical");
			}
		}
	}
	
	// ************
	// set root_xml
	// ************
	public function set_root_xml (x:XML):Void
	{
		destroy ();
		
		var temp_config:XMLNode;
		var temp_data:XMLNode;
		
		// try to find out the config node and data node
		for (var i in x.firstChild.childNodes)
		{
			
			var temp_node:XMLNode;
			var temp_name:String;
			
			temp_node = x.firstChild.childNodes [i];
			temp_name = temp_node.nodeName;
			
			switch (temp_name)
			{
				// config node
				case "config":
				{
					temp_config = temp_node;
					break;
				}
				// data node
				case "data":
				{
					temp_data = temp_node;
					break;
				}
				// exception
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name + "'", "critical");
				}
			}
		}
		
		set_config_xml (temp_config);
		set_data_xml (temp_data);
	}
	
	// *****************
	// config_xml setter
	// *****************
	public function set_config_xml (x:XMLNode):Void
	{
		// try to parse the config node
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			
			if (temp_name != "menu_style" || temp_name != "text_format")
			{
				temp_value = temp_node.firstChild.nodeValue;
			}
			
			switch (temp_name)
			{
				// x position of the navigation menu
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the navigation menu
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// global menu style
				case "menu_style":
				{
					// since menu style still have many nodes, so need to iterate again
					for (var j in temp_node.childNodes)
					{
						menu_style [temp_node.childNodes [j].nodeName] = temp_node.childNodes [j].firstChild.nodeValue;
					}
					break;
				}
				// global text format
				case "text_format":
				{
					// since text format still have many nodes, so need to iterate again
					for (var j in temp_node.childNodes)
					{
						var temp_value_2:String;
						
						temp_value_2 = temp_node.childNodes [j].firstChild.nodeValue;
						
						// try to set boolean value to it
						text_format [temp_node.childNodes [j].nodeName] = _root.sys_func.string_to_boolean (temp_value_2);
						
						// if get null means the input is not boolean, then set original
						if (text_format [temp_node.childNodes [j].nodeName] == null)
						{
							text_format [temp_node.childNodes [j].nodeName] = temp_value_2;
						}
					}
					break;
				}
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name + "'", "critical");
				}
			}
		}
	}
	
	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			
			if (temp_name == "NavigationItemMC")
			{
				if (temp_node.attributes ["style"] != "global")
				{
					item_mc_array [i] = mc_ref.attachMovie (temp_node.attributes ["style"], "menu_item_" + i, mc_ref.getNextHighestDepth ());
				}
				else
				{
					item_mc_array [i] = mc_ref.attachMovie (menu_style ["name"], "menu_item_" + i, mc_ref.getNextHighestDepth ());
				}
				
				item_mc_array [i].set_data_xml (temp_node, text_format);
			}
			else
			{
				_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_node.nodeName + "'", "critical");
			}
		}
	}
	
	// ***************
	// pull edit panel
	// ***************
	public function pull_edit_panel ():Void
	{
		var temp_x:Number;
		var temp_y:Number;
		
		temp_x = mc_ref._x;
		temp_y = mc_ref._y + mc_ref._height;
		
		_root.edit_panel_mc.set_target_ref (mc_ref);
		_root.edit_panel_mc.set_position (temp_x, temp_y);
		_root.edit_panel_mc.set_function (true, false, false, true);
	}

	// *******************
	// properties function
	// *******************
	public function properties_function ():Void
	{
		var temp_lib:String;
		var temp_name:String;
		var temp_width:Number;
		var temp_height:Number;
		
		temp_lib = "lib_properties_navigation_menu";
		temp_name = "Navigation Menu Properties Window";
		temp_width = 450;
		temp_height = 250;
		
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
		_root.window_mc.content_mc.set_target_ref (mc_ref);
	}

	// ***********
	// change mode
	// ***********
	public function broadcaster_event (o:Object):Void
	{
		if (o == true)
		{
			// showing the edit mode bg
			var temp_xml:XML;
			temp_xml = new XML ("<RectangleMC><x>0</x><y>0</y><width>300</width><height>50</height><corner>0</corner><line_style>2|0x666666|100</line_style><fill_color>0xFFFFFF</fill_color><alpha>10</alpha></RectangleMC>");
			
			mc_ref.edit_mode_bg_tag._visible = true;
			
			mc_ref.edit_mode_bg ["class_ref"] = mc_ref;
			mc_ref.edit_mode_bg.set_data_xml (temp_xml.firstChild);
			mc_ref.edit_mode_bg.draw_it ();
			
			// listeners
			mc_ref.edit_mode_bg.onRollOver = function ()
			{
				this.class_ref.onRollOver_event ();
			}
			
			mc_ref.edit_mode_bg.onRollOut = function ()
			{
				this.class_ref.onRollOut_event ();
			}
			
			mc_ref.edit_mode_bg.onPress = function ()
			{
				this.class_ref.onPress_event ();
			}
		}
		else
		{
			mc_ref.edit_mode_bg.clear ();
			mc_ref.edit_mode_bg_tag._visible = false;
			
			delete mc_ref.edit_mode_bg.onRollOver;
			delete mc_ref.edit_mode_bg.onRollOut;
			delete mc_ref.edit_mode_bg.onPress;
		}
		
		for (var i in item_mc_array)
		{
			item_mc_array [i].broadcaster_event (o);
		}
	}

	// **********
	// export_xml
	// **********
	public function export_xml ():XML
	{
		var out_xml:XML;
		var out_string:String;
		
		var root_node:XMLNode;
		var config_node:XMLNode;
		var data_node:XMLNode;
		
		var temp_node:XMLNode;
		var temp_node_2:XMLNode;
		var temp_node_3:XMLNode;
		
		out_string = "<?xml version='1.0'?>";
		
		out_xml = new XML ();
		
		// building root node
		root_node = out_xml.createElement ("NavigationMenu");
		root_node.attributes ["xmlns"] = "http://www.w3schools.com";
		root_node.attributes ["xmlns:xsi"] ="http://www.w3.org/2001/XMLSchema-instance";
		out_xml.appendChild (root_node);
		
		// building config node
		config_node = out_xml.createElement ("config");
			
			// x of navigation menu
			temp_node = out_xml.createElement ("x");
			temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// y of navigation menu
			temp_node = out_xml.createElement ("y");
			temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// menu style of navigation menu
			temp_node = out_xml.createElement ("menu_style");
			for (var i in menu_style)
			{
				temp_node_2 = out_xml.createElement (i);
				temp_node_3 = out_xml.createTextNode (menu_style [i]);
				temp_node_2.appendChild (temp_node_3);
				temp_node.appendChild (temp_node_2);
			}
			config_node.appendChild (temp_node);
			
			// text format of navigation menu
			temp_node = out_xml.createElement ("text_format");
			for (var i in text_format)
			{
				if (text_format [i] != null && i.indexOf ("getTextExtent") == -1)
				{
					temp_node_2 = out_xml.createElement (i);
					temp_node_3 = out_xml.createTextNode (text_format [i]);
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
			}
			config_node.appendChild (temp_node);
			
		root_node.appendChild (config_node);
		
		// building data node
		data_node = out_xml.createElement ("data");
			
			// calling each navigation item instance to return their xml
			// MUST keep in sequence so dont use for in...
			var temp_length:Number;
			temp_length = item_mc_array.length;
			
			for (var i = 0; i < temp_length; i++)
			{
				if (item_mc_array [i] != null)
				{
					temp_node = item_mc_array [i].export_xml ();
					data_node.appendChild (temp_node);
				}
			}
			
		root_node.appendChild (data_node);
		
		
		// append those string contents to the xml and rebuild it
		out_string = out_string + out_xml.toString ();
		out_xml = new XML (out_string);
		
		return (out_xml);
	}

	// ********
	// save xml
	// ********
	public function save_xml ():Void
	{
		var out_xml:XML;
		var return_xml:as.global.XMLExtend;
		
		return_xml = new as.global.XMLExtend ();
		return_xml.onLoad = function (b: Boolean)
		{
			if (b)
			{
				this.stop_progress ();
				_root.status_mc.add_message (return_xml.toString (), "");
			}
		}
		
		out_xml = new XML ();
		out_xml = export_xml ();
		out_xml.contentType = "text/xml";
		out_xml.sendAndLoad ("function/update_xml.php?target_file=" + loaded_file, return_xml);
		
		return_xml.check_progress ("Saving navigation menu...");
	}

	// ***************
	// get text format
	// ***************
	public function get_text_format ():TextFormat
	{
		return (text_format);
	}
	
	// **************
	// get menu style
	// **************
	public function get_menu_style ():Object
	{
		return (menu_style);
	}
	
	// ***************
	// get loaded file
	// ***************
	public function get_loaded_file ():String
	{
		return (loaded_file);
	}
}
