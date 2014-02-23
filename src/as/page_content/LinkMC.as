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

	private var edit_mode:Boolean;			// edit mode flag
	
	// ***********
	// constructor
	// ***********
	public function LinkMC ()
	{
		mc_ref = this;
		
		content_mc_array = new Array ();
		
		file_name = "(LinkMC.as)";
		
		edit_mode = false;
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
					var temp_depth:Number;
					var temp_name:String;
					var lib_name:String;
					
					temp_depth = mc_ref.getNextHighestDepth ();
					temp_name = "text_field_" + temp_depth;
					lib_name = "lib_page_content_textfield";
					
					content_mc_array [temp_depth] = mc_ref.attachMovie (lib_name, temp_name, temp_depth);
					content_mc_array [temp_depth].set_data_xml (temp_node);
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
	
	// ******************
	// onrelease override
	// ******************
	public function onRelease ()
	{
		switch (link_type)
		{
			// internal link
			case 0:
			{
				// loading new contents
				_root.page_mc.load_root_xml (link_url);
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
	
	// *******************
	// onrollover override
	// *******************
	public function onRollOver ()
	{
		// react as normal link in action mode
		if (edit_mode == false)
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
		}
		// react differently in edit mode
		else
		{
			_root.mc_filters.set_brightness_filter (mc_ref);
			
			pull_edit_panel ();
		}
	}

	// ******************
	// onrollout override
	// ******************
	public function onRollOut ()
	{
		// react only in edit mode
		if (edit_mode == true)
		{
			_root.mc_filters.remove_filter (mc_ref);
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

	// *****************
	// broadcaster event
	// *****************
	public function broadcaster_event (o:Object):Void
	{
		edit_mode = new Boolean (o);
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
}