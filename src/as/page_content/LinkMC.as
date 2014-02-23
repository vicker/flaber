// ************
// LinkMC class
// ************
class as.page_content.LinkMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// interface for the link mc
	
	private var link_type:Number;				// internal link or external
	private var link_url:String;				// url of the link content
	
	private var content_mc_array:Array;		// array storing all the content items
	
	private var file_name:String;				// for tracer
	
	// ***********
	// constructor
	// ***********
	public function LinkMC ()
	{
		mc_ref = this;
		
		content_mc_array = new Array ();
		
		file_name = "(LinkMC.as)";
		
		mc_ref.onRelease = function ()
		{
			onRelease_event ();
		}
		
		mc_ref.onRollOver = function ()
		{
			onRollOver_event_1 ();
		}
		
		mc_ref.onRollOut = function ()
		{
			onRollOut_event_1 ();
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
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			temp_value = temp_node.firstChild.nodeValue;
			
			switch (temp_name)
			{
				// x position of the link
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the link
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// link type
				case "type":
				{
					link_type = parseInt (temp_value);
					break;
				}
				// link url
				case "url":
				{
					link_url = temp_value;
					break;
				}
				// textfield inside the link
				case "TextFieldMC":
				{
					var temp_name:String;
					var lib_name:String;
					
					temp_name = "textfield_mc";
					lib_name = "lib_page_content_textfield";
					
					content_mc_array [0] = mc_ref.attachMovie (lib_name, temp_name, 0);
					content_mc_array [0].set_data_xml (temp_node);
					break;
				}
				// exception
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name + "'", "critical");
					break;
				}
			}
		}
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
	public function onRelease_event ():Void
	{
		switch (link_type)
		{
			// internal link
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
			// external link
			case 1:
			{
				// loading external content
				_root.sys_func.build_popup (800, 600, "", link_url, 1);
				break;
			}
		}
	}
	
	// *********************
	// onrollover override 1
	// *********************
	public function onRollOver_event_1 ():Void
	{
		var temp_string:String;
		
		switch (link_type)
		{
			case 0:
			{
				temp_string = "Internal link - " + link_url;
				break;
			}
			case 1:
			{
				temp_string = "External link - " + link_url;
				break;
			}
		}
		
		_root.status_mc.add_message (temp_string , "tooltip");
		_root.tooltip_mc.set_content (link_url);
	}

	// *********************
	// onrollover override 2
	// *********************
	public function onRollOver_event_2 ():Void
	{
		_root.mc_filters.set_brightness_filter (mc_ref);
		_root.tooltip_mc.set_content (mc_ref._name);
		_root.status_mc.add_message ("Click to bring up the edit panel" , "tooltip");
	}

	// ********************
	// onrollout override 1
	// ********************
	public function onRollOut_event_1 ():Void
	{
		_root.tooltip_mc.throw_away ();
	}

	// ********************
	// onrollout override 2
	// ********************
	public function onRollOut_event_2 ():Void
	{
		_root.mc_filters.remove_filter (mc_ref);
		_root.tooltip_mc.throw_away ();
	}

	// ****************
	// onpress override
	// ****************
	public function onPress_event ():Void
	{
		pull_edit_panel ();
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
		
		temp_lib = "lib_properties_link";
		temp_name = "Link Properties Window";
		temp_width = 290;
		temp_height = 330;
		
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
		_root.page_mc.destroy_one (mc_ref);
	}

	// *****************
	// broadcaster event
	// *****************
	public function broadcaster_event (o:Object):Void
	{
		if (o == true)
		{			
			delete mc_ref.onRollOver;
			delete mc_ref.onRelease;
			
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
			delete mc_ref.onRelease;
			delete mc_ref.onPress;
			
			mc_ref.onRollOver = function ()
			{
				onRollOver_event_1 ();
			}
			
			mc_ref.onRelease = function ()
			{
				onRelease_event ();
			}
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
		root_node = out_xml.createElement ("LinkMC");
		root_node.attributes.depth = mc_ref.getDepth ();
		
		// x of link
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of link
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// type of link
		temp_node = out_xml.createElement ("type");
		temp_node_2 = out_xml.createTextNode (link_type.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// url of link
		temp_node = out_xml.createElement ("url");
		temp_node_2 = out_xml.createTextNode (link_url);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// all the contents inside the link
		for (var i in content_mc_array)
		{
			temp_node = content_mc_array [i].export_xml ();
			root_node.appendChild (temp_node);
		}
		
		// export the xml node to whatever place need this
		return (root_node);
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