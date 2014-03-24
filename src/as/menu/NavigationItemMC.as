// **********************
// NavigationItemMC class
// **********************
class as.menu.NavigationItemMC extends as.page_content.PageElementMC
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var link_url:String;						// url of the link content
	private var link_type:Number;						// internal link or external
	
	private var mc_ref:MovieClip;						// interface for the navigation item mc
	
	private var style_global:Boolean;				             	 // state that if this item is using global style
	private var format_global:Boolean;				            	 // state that if this item is using global textformat
	private var FILE_NAME:String = "(NavigationItemMC.as)";		 	 // for tracer
	
	// ***********
	// constructor
	// ***********
	public function NavigationItemMC ()
	{
		mc_ref = this;
		
		mc_ref.onRollOver = function ()
		{
			onRollOver_event_special ();
		}
		
		mc_ref.onRollOut = function ()
		{
			onRollOut_event_special ();
		}
		
		mc_ref.onRelease = function ()
		{
			onRelease_event_special ();
		}
		
		mc_ref.onReleaseOutside = function ()
		{
			onReleaseOutside_event_special ();
		}
	}
	
	// *********************
	// transition out action
	// *********************
	public function transition_out_action ():Void
	{
		_root.page_mc.load_root_xml (link_url);
	}
	
	// ***************************
	// onrollover special override
	// ***************************
	private function onRollOver_event_special ():Void
	{
		mc_ref.gotoAndStop ("over");
		
		var temp_string:String = "";
		temp_string = mc_ref.content_field.text + " - " + link_url;
		
		_root.status_mc.add_message (temp_string , "tooltip");
		_root.tooltip_mc.set_content (link_url);
	}
	
	// **************************
	// onrollout special override
	// **************************
	private function onRollOut_event_special ():Void
	{
		mc_ref.gotoAndStop ("normal");
		_root.tooltip_mc.throw_away ();
	}

	// **************************
	// onrelease special override
	// **************************
	private function onRelease_event_special ():Void
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
					_root.mc_transitions.start_transition ("out");
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
	
	// *********************************
	// onreleaseoutside special override
	// *********************************
	private function onReleaseOutside_event_special ():Void
	{
		mc_ref.gotoAndStop ("normal");
	}
	
	// ***************
	// pull edit panel
	// ***************
	private function pull_handler (s:String):Void
	{
		var temp_x:Number;
		var temp_y:Number;
		
		temp_x = mc_ref._parent._x + mc_ref._x;
		temp_y = mc_ref._parent._y + mc_ref._y;
		
		if (s == "first")
		{
			_root.handler_mc.bring_back ();
			_root.handler_mc.set_function (["delete"], ["resize", "rotate"]);
		}

		_root.handler_mc.set_size (mc_ref._width, mc_ref._height);
		_root.handler_mc.set_position (temp_x, temp_y, 0);
	}

	// *******************
	// properties function
	// *******************
	public function properties_function ():Void
	{	
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data ("Navigation Item Properties Window", 300, 280, "lib_properties_navigation_item");
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
				onRollOver_event ();
			}
			
			mc_ref.onRollOut = function ()
			{
				onRollOut_event ();
			}
			
			mc_ref.onPress = function ()
			{
				onPress_event ();
			}
			
			mc_ref.onRelease = function ()
			{
				onRelease_event ();
			}
		}
		else
		{
			delete mc_ref.onRollOver;
			delete mc_ref.onRollOut;
			delete mc_ref.onPress;
			delete mc_ref.onRelease;
			
			mc_ref.onRollOver = function ()
			{
				onRollOver_event_special ();
			}
			
			mc_ref.onRollOut = function ()
			{
				onRollOut_event_special ();
			}
			
			mc_ref.onRelease = function ()
			{
				onRelease_event_special ();
			}
			
			mc_ref.onReleaseOutside = function ()
			{
				onReleaseOutside_event_special ();
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
					var temp_format:TextFormat = new TextFormat ();
					
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
					_root.status_mc.add_message (FILE_NAME + " node skipped with node name '" + temp_name + "'", "critical");
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
		var out_xml:XML = new XML ();
		
		var root_node:XMLNode;
		var temp_node:XMLNode;
		var temp_node_2:XMLNode;
		
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
