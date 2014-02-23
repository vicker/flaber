// *****************
// RectangleMC class
// *****************
class as.shape.RectangleMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// interface for the rectangle mc
	
	// rectangle parameters
	private var rect_width:Number;
	private var rect_height:Number;
	private var rect_corner:Number;
	private var line_style:Array;
	private var fill_color:Number;

	// ***********
	// constructor
	// ***********
	public function RectangleMC ()
	{
		mc_ref = this;
		
		rect_width = 10;
		rect_height = 10;
		rect_corner = 0;
		line_style = new Array (1, 0x000000, 100);
		fill_color = 0x000000;
	}
	
	// *******
	// draw_it
	// *******
	public function draw_it ():Void
	{
		// remind that clear will also remove lineStyle
		mc_ref.clear ();
		
		if (fill_color != null)
		{
			mc_ref.beginFill (fill_color);
		}
		
		mc_ref.lineStyle (parseInt (line_style [0]), parseInt (line_style [1]), parseInt (line_style [2]));
		
		mc_ref.lineTo (rect_width, 0);
		mc_ref.lineTo (rect_width, rect_height);
		mc_ref.lineTo (0, rect_height);
		mc_ref.lineTo (0, 0);
		
		if (fill_color != null)
		{
			mc_ref.endFill ();
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
				// x position of the rectangle mc
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the rectangle mc
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// width of the rectangle mc
				case "width":
				{
					rect_width = parseInt (temp_value);
					break;
				}
				// height of the rectangle mc
				case "height":
				{
					rect_height = parseInt (temp_value);
					break;
				}
				case "rotation":
				{
					mc_ref._rotation = parseInt (temp_value);
					break;
				}
				// corner radius of the rectangle mc
				case "corner":
				{
					rect_corner = parseInt (temp_value);
					break;
				}
				// line style of the line of rectangle
				case "line_style":
				{
					line_style = temp_value.split ("|");
					break;
				}
				// fill color of the rectangle mc
				case "fill_color":
				{
					fill_color = parseInt (temp_value);
					break;
				}
				// alpha of the whole rectangle mc
				case "alpha":
				{
					mc_ref._alpha = parseInt (temp_value);
					break;
				}
			}
			
			draw_it ();
		}		
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

	// ***************
	// pull edit panel
	// ***************
	public function pull_edit_panel ():Void
	{
		var temp_x:Number;
		var temp_y:Number;
		
		var adjust_x:Number;
		var adjust_y:Number;
		
		temp_x = mc_ref._x;
		temp_y = mc_ref._y + mc_ref._height;
		
		adjust_x = 0;
		adjust_y = 0;
		
		// rotation adjuster
		if (mc_ref._rotation < 0 && mc_ref._rotation >= - 90)
		{
			adjust_y = mc_ref._height * (mc_ref._rotation / 90);
		}
		else if (mc_ref._rotation < -90 && mc_ref._rotation >= - 180)
		{
			adjust_y = 0 - mc_ref._height;
			adjust_x = mc_ref._width * ((mc_ref._rotation + 90) / 90);
		}
		else if (mc_ref._rotation > 90 && mc_ref._rotation <= 180)
		{
			adjust_y = 0 - (mc_ref._width * ((mc_ref._rotation - 90) / 90));
			adjust_x = 0 - mc_ref._width;
		}
		else if (mc_ref._rotation > 0 && mc_ref._rotation <= 90)
		{
			adjust_x = 0 - mc_ref._width * (mc_ref._rotation / 90);
		}
		
		temp_x = temp_x + adjust_x;
		temp_y = temp_y + adjust_y;
		
		_root.edit_panel_mc.set_target_ref (mc_ref);
		_root.edit_panel_mc.set_position (temp_x, temp_y);
		_root.edit_panel_mc.set_function (true, true, true, true, true);
	}

	// ***************
	// resize function
	// ***************
	public function resize_function (n:Number):Void
	{
		// calling to go
		if (n == 1)
		{
			mc_ref.onMouseMove = function ()
			{
				resize_interval_function ();
			}
		}
		// calling to stop
		else
		{
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
		
		target_width = Math.max (mc_ref._xmouse, 10);
		target_height = Math.max (mc_ref._ymouse, 10);
		
		rect_width = target_width;
		rect_height = target_height;
		draw_it ();
	}

	// ***************
	// rotate function
	// ***************
	public function rotate_function (n:Number):Void
	{
		// calling to go
		if (n == 1)
		{
			var initial_rotation:Number;
			var initial_degree:Number;
			
			initial_rotation = mc_ref._rotation;
			initial_degree = _root.sys_func.get_mouse_degree (mc_ref._x, mc_ref._y);
			
			mc_ref.onMouseMove = function ()
			{
				rotate_interval_function (initial_rotation, initial_degree);
			}
		}
		// calling to stop
		else
		{
			delete mc_ref.onMouseMove;
		}
	}
	
	// ************************
	// rotate interval function
	// ************************
	public function rotate_interval_function (r:Number, d:Number):Void
	{
		var target_degree:Number;
		var current_degree:Number;
		
		current_degree = _root.sys_func.get_mouse_degree (mc_ref._x, mc_ref._y);
		target_degree = current_degree - d;
		
		mc_ref._rotation = r + target_degree;
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
		
		temp_lib = "lib_properties_rectangle";
		temp_name = "Rectangle Properties Window";
		temp_width = 580;
		temp_height = 260;
		
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
		root_node = out_xml.createElement ("RectangleMC");
		root_node.attributes.depth = mc_ref.getDepth ();
		
		// x of rectangle
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of rectangle
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// width of rectangle
		temp_node = out_xml.createElement ("width");
		temp_node_2 = out_xml.createTextNode (rect_width.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// height of rectangle
		temp_node = out_xml.createElement ("height");
		temp_node_2 = out_xml.createTextNode (rect_height.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// rotation of image
		temp_node = out_xml.createElement ("rotation");
		temp_node_2 = out_xml.createTextNode (mc_ref._rotation.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
				
		// corner of rectangle
		temp_node = out_xml.createElement ("corner");
		temp_node_2 = out_xml.createTextNode (rect_corner.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// linestyle of rectangle
		temp_node = out_xml.createElement ("line_style");
		temp_node_2 = out_xml.createTextNode (line_style [0] + "|" + line_style [1] + "|" + line_style [2]);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// fillcolor of rectangle
		if (fill_color != null)
		{
			temp_node = out_xml.createElement ("fill_color");
			temp_node_2 = out_xml.createTextNode ("0x" + fill_color.toString (16));
			temp_node.appendChild (temp_node_2);
			root_node.appendChild (temp_node);
		}
		
		// alpha of rectangle
		temp_node = out_xml.createElement ("alpha");
		temp_node_2 = out_xml.createTextNode (mc_ref._alpha.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// export the xml node to whatever place need this
		return (root_node);
	}

	// **************
	// get rect width
	// **************
	public function get_rect_width ():Number
	{
		return (rect_width);
	}

	// ***************
	// get rect height
	// ***************
	public function get_rect_height ():Number
	{
		return (rect_height);
	}
	
	// **************
	// get line style
	// **************
	public function get_line_style ():Array
	{
		return (line_style);
	}
	
	// **************
	// get fill color
	// **************
	public function get_fill_color ():Number
	{
		return (fill_color);
	}
}