// *****************
// RectangleMC class
// *****************
class as.shape.RectangleMC extends as.page_content.PageElementMC
{
	// private variables
	private var mc_ref:MovieClip;				// interface for the rectangle mc
	private var shape_param:Object;

	private var stored_width:Number;
	private var stored_height:Number;

	// ***********
	// constructor
	// ***********
	public function RectangleMC ()
	{
		mc_ref = this;
		mc_ref.attachMovie ("lib_frame_mc", "frame_mc", 1, {_x: 0, _y: 0});
		
		shape_param = new Object ();
		shape_param ["px"] = 0;
		shape_param ["py"] = 0;
		shape_param ["w"] = 100;
		shape_param ["h"] = 50;
		shape_param ["ls"] = 1;
		shape_param ["lc"] = 0x000000;
		shape_param ["la"] = 100;
		shape_param ["fc"] = 0x000000;
		shape_param ["fa"] = 100;
	}
	
	// *******
	// draw_it
	// *******
	public function draw_it ():Void
	{
		mc_ref.frame_mc.clear_frame ();
		mc_ref.frame_mc.draw_rect (shape_param ["px"], shape_param ["py"], shape_param ["w"], shape_param ["h"],
											 shape_param ["ls"], shape_param ["lc"], shape_param ["la"],
											 shape_param ["fc"], shape_param ["fa"]);
	}

	// ***************
	// pull edit panel
	// ***************
	public function pull_handler (s:String):Void
	{
		if (s == "first")
		{
			_root.handler_mc.bring_back ();
			_root.handler_mc.set_function (["resize", "rotate", "delete"], null);
		}

		_root.handler_mc.set_size (shape_param ["w"], shape_param ["h"]);
		_root.handler_mc.set_position (mc_ref._x, mc_ref._y, mc_ref._rotation);
	}
	
	// ***************
	// resize function
	// ***************
	// override existing resize function
	public function resize_function (n:Number):Void
	{
		stored_width = shape_param ["w"];
		stored_height = shape_param ["h"];

		super.resize_function (n);
	}
	
	// ************************
	// resize interval function
	// ************************
	public function resize_interval_function ():Void
	{
		var target_width:Number;
		var target_height:Number;
		
		target_width = _root.handler_mc._xmouse;
		target_height = _root.handler_mc._ymouse;
		
		// preventing the object too small...
		target_height = Math.max (target_height, 10);
		target_width = Math.max (target_width, 10);
		
		// shift will have scale resize
		if (Key.isDown (Key.SHIFT))
		{
			var temp_ratio:Number;
			temp_ratio = Math.min (target_width / stored_width, target_height / stored_height);

			target_width = stored_width * temp_ratio;
			target_height = stored_height * temp_ratio;
		}
		
		// ctrl will form square
		if (Key.isDown (Key.CONTROL))
		{
			var temp_value:Number;
			temp_value = Math.max (target_width, target_height);
			
			target_width = temp_value;
			target_height = temp_value;
		}
				
		shape_param ["w"] = target_width;
		shape_param ["h"] = target_height;
		draw_it ();
	}
	
	// ************************
	// rotate interval function
	// ************************
	public function rotate_interval_function (r:Number):Void
	{
		mc_ref._rotation = r;
	}

	// *******************
	// properties function
	// *******************
	public function properties_function ():Void
	{
		_root.sys_func.remove_window_mc ();
		_root.attachMovie ("lib_window", "window_mc", 9999);
		_root.window_mc.set_window_data ("Rectangle Properties Window", 520, 240, "lib_properties_rectangle");
		_root.window_mc.content_mc.set_target_ref (mc_ref);
	}

	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		// reset frame params
		// line is necessary to be there even the user dont specify
		// however this is the case for fill~
		shape_param ["px"] = 0;
		shape_param ["py"] = 0;
		shape_param ["w"] = 100;
		shape_param ["h"] = 50;
		shape_param ["ls"] = 1;
		shape_param ["lc"] = 0x000000;
		shape_param ["la"] = 100;
		shape_param ["fc"] = null;
		shape_param ["fa"] = null;
		
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
					shape_param ["w"] = parseInt (temp_value);
					break;
				}
				// height of the rectangle mc
				case "height":
				{
					shape_param ["h"] = parseInt (temp_value);
					break;
				}
				case "rotation":
				{
					mc_ref._rotation = parseInt (temp_value);
					break;
				}
				// line style of the line of rectangle
				case "line_style":
				{
					var line_style:Array;
					line_style = temp_value.split ("|");
					shape_param ["ls"] = parseInt (line_style [0]);
					shape_param ["lc"] = parseInt (line_style [1]);
					shape_param ["la"] = parseInt (line_style [2]);
					break;
				}
				// fill color of the rectangle mc
				case "fill_color":
				{
					shape_param ["fc"] = parseInt (temp_value);
					break;
				}
				// alpha of the fill color of rectangle mc
				case "alpha":
				{
					shape_param ["fa"] = parseInt (temp_value);
					break;
				}
			}
			
			draw_it ();
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
		temp_node_2 = out_xml.createTextNode (shape_param ["w"].toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// height of rectangle
		temp_node = out_xml.createElement ("height");
		temp_node_2 = out_xml.createTextNode (shape_param ["h"].toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// rotation of image
		temp_node = out_xml.createElement ("rotation");
		temp_node_2 = out_xml.createTextNode (mc_ref._rotation.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// linestyle of rectangle
		temp_node = out_xml.createElement ("line_style");
		temp_node_2 = out_xml.createTextNode (shape_param ["ls"] + "|" + shape_param ["lc"] + "|" + shape_param ["la"]);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// fillcolor of rectangle
		if (shape_param ["fc"] != null && shape_param ["fa"] != null)
		{
			temp_node = out_xml.createElement ("fill_color");
			temp_node_2 = out_xml.createTextNode (_root.sys_func.color_num_to_string (shape_param ["fc"]));
			temp_node.appendChild (temp_node_2);
			root_node.appendChild (temp_node);
		
			// alpha of rectangle
			temp_node = out_xml.createElement ("alpha");
			temp_node_2 = out_xml.createTextNode (shape_param ["fa"].toString ());
			temp_node.appendChild (temp_node_2);
			root_node.appendChild (temp_node);
		}
		
		// export the xml node to whatever place need this
		return (root_node);
	}

	// ***************
	// get shape param
	// ***************
	public function get_shape_param ():Object
	{
		return (shape_param);
	}
}
