// *****************
// TextFieldMC class
// *****************
class as.page_content.TextFieldMC extends as.page_content.PageElementMC
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

	// ***************
	// pull edit panel
	// ***************
	public function pull_handler (s:String):Void
	{
		if (s == "first")
		{
			_root.handler_mc.bring_back ();
			_root.handler_mc.set_function (["resize", "delete"], ["rotate"]);
		}
		
		_root.handler_mc.set_size (mc_ref.content_field._width, mc_ref.content_field._height);
		_root.handler_mc.set_position (mc_ref._x, mc_ref._y, 0);
	}
	
	// ***************
	// resize function
	// ***************
	// override
	public function resize_function (n:Number):Void
	{
		// calling to go
		if (n == 1)
		{
			mc_ref.content_field.border = true;
			
			mc_ref.onMouseMove = function ()
			{
				resize_interval_function ();
				// since the resize function depends on the handler position
				// that is why handler mc chasing is necessary
				pull_handler ("not first");
			}
		}
		// calling to stop
		else
		{
			mc_ref.content_field.border = false;
			
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
		
		if (mc_ref.scroll_bar)
		{
			mc_ref.scroll_bar.set_scroll_ref (mc_ref.content_field);
		}		
	}

	// *******************
	// properties function
	// *******************
	public function properties_function ():Void
	{
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data ("Textfield Properties Window", 430, 460, "lib_properties_textfield");
		_root.window_mc.content_mc.set_target_ref (mc_ref);
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
			
			// if scroll present, dont autosize
			mc_ref.content_field.autoSize = false;
		}
		else
		{
			// otherwise make sure all the text appears within sight
			mc_ref.content_field.autoSize = "left";
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
