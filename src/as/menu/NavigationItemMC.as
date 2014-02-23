// **********************
// NavigationItemMC class
// **********************
class as.menu.NavigationItemMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var link_url:String;						// url of the link content
	private var link_type:Number;						// internal link or external
	
	private var mc_ref:MovieClip;						// interface for the navigation item mc
	
	private var style_global:Boolean;				// state that if this item is using global style
	private var format_global:Boolean;				// state that if this item is using global textformat
	private var file_name:String;						// for tracer
	
	// ***********
	// constructor
	// ***********
	public function NavigationItemMC ()
	{
		mc_ref = this;
		
		file_name = "(NavigationItemMC.as)";
		
		mc_ref.onRollOver = function ()
		{
			onRollOver_event_1 ();
		}
		
		mc_ref.onRollOut = function ()
		{
			onRollOut_event_1 ();
		}
		
		mc_ref.onRelease = function ()
		{
			onRelease_event ();
		}
		
		mc_ref.onReleaseOutside = function ()
		{
			onReleaseOutside_event ();
		}
	}
	
	// *********************
	// onrollover override 1
	// *********************
	public function onRollOver_event_1 ()
	{
		mc_ref.gotoAndStop ("over");
		
		var temp_string:String;
		
		temp_string = mc_ref.content_field.text + " - " + link_url;
		_root.status_mc.add_message (temp_string , "tooltip");
		_root.tooltip_mc.set_content (link_url);
	}
	
	// *********************
	// onrollover override 2
	// *********************
	public function onRollOver_event_2 ()
	{
		_root.mc_filters.set_brightness_filter (mc_ref);
		_root.tooltip_mc.set_content (mc_ref._name);
		_root.status_mc.add_message ("Click to bring up the edit panel" , "tooltip");
	}
	
	// ********************
	// onrollout override 1
	// ********************
	public function onRollOut_event_1 ()
	{
		mc_ref.gotoAndStop ("normal");
		_root.tooltip_mc.throw_away ();
	}

	// ********************
	// onrollout override 2
	// ********************
	public function onRollOut_event_2 ()
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

	// *********************
	// transition out action
	// *********************
	public function transition_out_action ():Void
	{
		_root.page_mc.load_root_xml (link_url);
	}
	
	// ******************
	// onrelease override
	// ******************
	public function onRelease_event ()
	{
		mc_ref.gotoAndStop ("normal");
		
		switch (link_type)
		{
			case 0:
			{
				// loading new contents
				if (_root.mc_transitions != null)
				{
					_root.mc_transitions.set_mc_ref (mc_ref);
					_root.mc_transitions.start_transition (1);
				}
				else
				{
					_root.page_mc.load_root_xml (link_url);
				}
				break;
			}
			case 1:
			{
				// loading external content
				_root.sys_func.build_popup (800, 600, "", link_url, 1);
				break;
			}
		}
	}
	
	// *************************
	// onreleaseoutside override
	// *************************
	public function onReleaseOutside_event ()
	{
		mc_ref.gotoAndStop ("normal");
	}
	
	// ***************
	// pull edit panel
	// ***************
	public function pull_edit_panel ():Void
	{
		var temp_x:Number;
		var temp_y:Number;
		
		temp_x = mc_ref._parent._x + mc_ref._x;
		temp_y = mc_ref._parent._y + mc_ref._y + mc_ref._height;
		
		_root.edit_panel_mc.set_target_ref (mc_ref);
		_root.edit_panel_mc.set_position (temp_x, temp_y);
		_root.edit_panel_mc.set_function (true, false, false, true, true);
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
		
		temp_lib = "lib_properties_navigation_item";
		temp_name = "Navigation Item Properties Window";
		temp_width = 290;
		temp_height = 290;
		
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
		_root.window_mc.content_mc.set_target_ref (mc_ref);
	}

	// ***************
	// delete function
	// ***************
	public function delete_function ():Void
	{
		_root.navigation_menu.destroy_one (mc_ref);
	}

	// *****************
	// broadcaster event
	// *****************
	public function broadcaster_event (o:Object):Void
	{
		if (o == true)
		{			
			delete mc_ref.onRollOver;
			delete mc_ref.onRollOut;
			delete mc_ref.onRelease;
			delete mc_ref.onReleaseOutside;
			
			mc_ref.onRollOver = function ()
			{
				onRollOver_event_2 ();
			}
			
			mc_ref.onRollOut = function ()
			{
				onRollOut_event_2 ();
			}
			
			mc_ref.onPress = function ()
			{
				onPress_event ();
			}
		}
		else
		{
			delete mc_ref.onRollOver;
			delete mc_ref.onRollOut;
			delete mc_ref.onPress;
			
			mc_ref.onRollOver = function ()
			{
				onRollOver_event_1 ();
			}
			
			mc_ref.onRollOut = function ()
			{
				onRollOut_event_1 ();
			}
			
			mc_ref.onRelease = function ()
			{
				onRelease_event ();
			}
			
			mc_ref.onReleaseOutside = function ()
			{
				onReleaseOutside_event ();
			}
		}
	}

	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode, t:TextFormat):Void
	{
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			
			// since text_format will have further nodes
			if (temp_name != "text_format")
			{
				temp_value = temp_node.firstChild.nodeValue;
			}
			
			switch (temp_name)
			{
				// x position of the navigation item respect to the menu
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the navigation item respect to the menu
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// text content of the navigation item
				case "text":
				{
					mc_ref.content_field.text = temp_value;
					break;
				}
				// text format of the navigation item
				case "text_format":
				{
					var temp_format:TextFormat;
					temp_format = new TextFormat ();
					
					for (var j in x.childNodes)
					{
						temp_format [x.childNodes [j].nodeName] = x.childNodes [j].nodeValue;
					}
					
					t = temp_format;
					break;
				}
				// link type of the navigation item
				case "type":
				{
					link_type = parseInt (temp_value);
					break;
				}
				// link url of the navigation item
				case "url":
				{
					link_url = temp_value;
					break;
				}
				// exception
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name + "'", "critical");
				}
			}
		}
		
		mc_ref.content_field.setTextFormat (t);
		
		// style of the navigation item
		if (x.attributes ["style"] != "global")
		{
			style_global = false;
		}
		else
		{
			style_global = true;
		}
		
		// textformat of the navigation item
		if (x.attributes ["textformat"] != "global")
		{
			format_global = false;
		}
		else
		{
			format_global = true;
		}
	}
	
	// **********
	// export xml
	// **********
	public function export_xml ():XMLNode
	{
		var out_xml:XML;
		
		var root_node:XMLNode;
		var temp_node:XMLNode;
		var temp_node_2:XMLNode;
		
		out_xml = new XML ();
		
		// building root node
		root_node = out_xml.createElement ("NavigationItemMC");
		
		if (style_global == true)
		{
			root_node.attributes.style = "global";
		}
		
		// x of navigation item
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of navigation item
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// text of navigation item
		temp_node = out_xml.createElement ("text");
		temp_node_2 = out_xml.createTextNode (mc_ref.content_field.text);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// type of navigation item
		temp_node = out_xml.createElement ("type");
		temp_node_2 = out_xml.createTextNode (link_type.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// url of navigation item
		temp_node = out_xml.createElement ("url");
		temp_node_2 = out_xml.createTextNode (link_url);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// overriding styles, if any
		if (!style_global)
		{
			//TODO if doing override style, then many things have to be added here
		}
		
		// overriding textformats, if any
		if (!format_global)
		{
			//TODO if doing override textformat, then many things have to be added here
		}
		
		// export the xml node to whatever place need this
		return (root_node);
	}

	// ***************
	// get text format
	// ***************
	public function get_text_format ():TextFormat
	{
		return (mc_ref.content_field.getTextFormat ());
	}

	// *****************
	// get content field
	// *****************
	public function get_content_field ():String
	{
		return (mc_ref.content_field.text);
	}
	
	// *************
	// get link type
	// *************
	public function get_link_type ():Number
	{
		return (link_type);
	}
	
	// ************
	// get link url
	// ************
	public function get_link_url ():String
	{
		return (link_url);
	}
}
