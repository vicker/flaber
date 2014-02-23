// *****************
// TextFieldMC class
// *****************
class as.page_content.TextFieldMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var mc_ref:MovieClip;						// interface for the textfield mc

	private var interval_id:Number;					// temp store for interval id
	
	private var edit_mode:Boolean;					// edit mode flag
	
	// ***********
	// constructor
	// ***********
	public function TextFieldMC ()
	{
		mc_ref = this;
		mc_ref.content_field.html = true;
		mc_ref.content_field.multiline = true;
		mc_ref.content_field.wordWrap = true;
		
		edit_mode = false;
	}

	// *******************
	// onrollover override
	// *******************
	// because rollover will damage textfield anchor tag so need to hide out the event first
	public function onRollOver_event ()
	{
		// react only in edit mode
		if (edit_mode == true)
		{
			_root.mc_filters.set_brightness_filter (mc_ref);
			
			pull_edit_panel ();
		}
	}
	
	// ******************
	// onrollout override
	// ******************
	// because rollout will damage textfield anchor tag so need to hide out the event first
	public function onRollOut_event ()
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

	// ***************
	// resize function
	// ***************
	public function resize_function (n:Number):Void
	{
		// calling to go
		if (n == 1)
		{
			mc_ref.content_field.border = true;
			
			clearInterval (interval_id);
			interval_id = setInterval (mc_ref, "resize_interval_function", 75);
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
			
			clearInterval (interval_id);
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

	// *****************
	// broadcaster event
	// *****************
	public function broadcaster_event (o:Object):Void
	{
		edit_mode = new Boolean (o);
		
		if (edit_mode == true)
		{
			mc_ref.onRollOver = function ()
			{
				onRollOver_event ();
			}
			
			mc_ref.onRollOut = function ()
			{
				onRollOut_event ();
			}
		}
		else
		{
			delete mc_ref.onRollOver;
			delete mc_ref.onRollOut;
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
		
		if (x.attributes ["scroll_bar"] == "true")
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
			root_node.attributes.scroll_bar = true;
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
}
