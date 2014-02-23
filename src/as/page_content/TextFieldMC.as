// *****************
// TextFieldMC class
// *****************
class as.page_content.TextFieldMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var mc_ref:MovieClip;						// interface for the textfield mc

	// ***********
	// constructor
	// ***********
	public function TextFieldMC ()
	{
		mc_ref = this;
		mc_ref.content_field.html = true;
		mc_ref.content_field.multiline = true;
		mc_ref.content_field.wordWrap = true;
	}

	// *******************
	// onrollover override
	// *******************
	// because rollover will damage textfield anchor tag so need to hide out the event first
	public function onRollOver_event ()
	{
		_root.mc_filters.set_brightness_filter (mc_ref);
		_root.tooltip_mc.set_content (mc_ref._name);
		_root.status_mc.add_message ("Click to bring up the edit panel" , "tooltip");
	}
	
	// ******************
	// onrollout override
	// ******************
	// because rollout will damage textfield anchor tag so need to hide out the event first
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
		_root.edit_panel_mc.set_function (true, true, false, true, true);
	}

	// ***************
	// resize function
	// ***************
	public function resize_function (n:Number):Void
	{
		// calling to go
		if (n == 1)
		{
			mc_ref.content_field.border = true;
			
			mc_ref.onMouseMove = function ()
			{
				resize_interval_function ();
			}
		}
		// calling to stop
		else
		{
			mc_ref.content_field.border = false;
			
			// if scroll bar exists, need to adjust
			if (mc_ref.scroll_bar)
			{
				mc_ref.scroll_bar.set_scroll_ref (mc_ref.content_field);
			}
			
			delete mc_ref.onMouseMove;
		}
	}
	
	// ************************
	// resize interval function
	// ************************
	public function resize_interval_function ():Void
	{
		var target_width:Number;
		var target_height:Number;
		
		target_width = Math.max (mc_ref.content_field._xmouse, 10);
		target_height = Math.max (mc_ref.content_field._ymouse, 10);
		
		mc_ref.content_field._width = target_width;
		mc_ref.content_field._height = target_height;
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
		
		temp_lib = "lib_properties_textfield";
		temp_name = "Textfield Properties Window";
		temp_width = 470;
		temp_height = 460;
		
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
		}
		else
		{
			delete mc_ref.onRollOver;
			delete mc_ref.onRollOut;
			delete mc_ref.onPress;
		}
	}
	
	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		// reset text
		mc_ref.content_field.htmlText = "";
		
		// reset scroll
		if (mc_ref.scroll_bar)
		{
			mc_ref.scroll_bar.removeMovieClip ();
		}
		
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
				// x position of the textfield
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the textfield
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// width of the textfield
				case "width":
				{
					mc_ref.content_field._width = parseInt (temp_value);
					break;
				}
				// height of the textfield
				case "height":
				{
					mc_ref.content_field._height = parseInt (temp_value);
					break;
				}
				// content of the textfield
				case "text":
				{
					for (var j in temp_node.childNodes)
					{
						mc_ref.content_field.htmlText = temp_node.childNodes [j].toString () + mc_ref.content_field.htmlText;
					}
					break;
				}
			}
		}
		
		if (x.attributes.scroll_bar == "true")
		{
			// setup full mc's scroll bar
			mc_ref.attachMovie ("lib_scroll_bar", "scroll_bar", mc_ref.getNextHighestDepth ());
			mc_ref.scroll_bar.set_scroll_ref (mc_ref.content_field);
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
		root_node = out_xml.createElement ("TextFieldMC");
		root_node.attributes.depth = mc_ref.getDepth ();
		
		if (mc_ref.scroll_bar)
		{
			root_node.attributes.scroll_bar = "true";
		}
		
		// x of textfield
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of textfield
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// width of textfield
		temp_node = out_xml.createElement ("width");
		temp_node_2 = out_xml.createTextNode (mc_ref.content_field._width.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// height of textfield
		temp_node = out_xml.createElement ("height");
		temp_node_2 = out_xml.createTextNode (mc_ref.content_field._height.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// content of textfield
		var temp_xml:XML;
		temp_xml = new XML ("<dummy>" + mc_ref.content_field.htmlText + "</dummy>");
		
		temp_node = out_xml.createElement ("text");
		
		var temp_length:Number;
		temp_length = temp_xml.firstChild.childNodes.length;
		
		for (var i = 0; i < temp_length; i++)
		{
			// using clone to prevent node removal
			temp_node_2 = temp_xml.firstChild.childNodes [i].cloneNode (true);
			temp_node.appendChild (temp_node_2);
		}
		root_node.appendChild (temp_node);
		
		// export the xml node to whatever place need this
		return (root_node);
	}

	// ***************
	// get scroll flag
	// ***************
	public function get_scroll_flag ():Boolean
	{
		if (mc_ref.scroll_bar)
		{
			return (true);
		}
		else
		{
			return (false);
		}
	}
}
