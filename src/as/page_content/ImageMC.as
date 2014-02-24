// *************
// ImageMC class
// *************
class as.page_content.ImageMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;						// interface for the image mc

	private var mc_url:String;
	
	// constructor
	public function ImageMC ()
	{
		mc_ref = this;
		
		mc_ref.attachMovie ("lib_clip_loader_mc", "clip_mc", 1, {_x: 0, _y: 0});
	}
	
	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		var temp_width:Number;
		var temp_height:Number;
		var temp_rotation:Number;
		
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
				// x position of the image
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the image
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// width of the image
				case "width":
				{
					temp_width = parseInt (temp_value);
					break;
				}
				// height of the image
				case "height":
				{
					temp_height = parseInt (temp_value);
					break;
				}
				// rotation of the image
				case "rotation":
				{
					temp_rotation = parseInt (temp_value);
					break;
				}
				// path of the image
				case "url":
				{
					mc_url = temp_value;
					break;
				}
			}			
		}
		
		if (temp_width != undefined && temp_height != undefined)
		{
			mc_ref.clip_mc.set_display_dimension (temp_width, temp_height);
		}
		
		mc_ref.clip_mc._rotation = temp_rotation;
		mc_ref.clip_mc.set_clip_mc (mc_url);
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
		if (mc_ref.clip_mc._rotation < 0 && mc_ref.clip_mc._rotation >= - 90)
		{
			adjust_y = mc_ref._height * (mc_ref.clip_mc._rotation / 90);
		}
		else if (mc_ref.clip_mc._rotation < -90 && mc_ref.clip_mc._rotation >= - 180)
		{
			adjust_y = 0 - mc_ref._height;
			adjust_x = mc_ref._width * ((mc_ref.clip_mc._rotation + 90) / 90);
		}
		else if (mc_ref.clip_mc._rotation > 90 && mc_ref.clip_mc._rotation <= 180)
		{
			adjust_y = 0 - (mc_ref._width * ((mc_ref.clip_mc._rotation - 90) / 90));
			adjust_x = 0 - mc_ref._width;
		}
		else if (mc_ref.clip_mc._rotation > 0 && mc_ref.clip_mc._rotation <= 90)
		{
			adjust_x = 0 - mc_ref._width * (mc_ref.clip_mc._rotation / 90);
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
		
		target_height = Math.max (mc_ref._ymouse, 10);
		target_width = mc_ref.clip_mc.get_display_dimension () ["width"] * (target_height / mc_ref.clip_mc.get_display_dimension () ["height"]);
		
		mc_ref.clip_mc.set_display_dimension (target_width, target_height);
		mc_ref.clip_mc.update_display_dimension ();
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
			
			initial_rotation = mc_ref.clip_mc._rotation;
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
		
		mc_ref.clip_mc._rotation = r + target_degree;
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
		
		temp_lib = "lib_properties_image";
		temp_name = "Image Properties Window";
		temp_width = 620;
		temp_height = 510;
		
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
		root_node = out_xml.createElement ("ImageMC");
		root_node.attributes.depth = mc_ref.getDepth ();
		
		// x of image
		temp_node = out_xml.createElement ("x");
		temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// y of image
		temp_node = out_xml.createElement ("y");
		temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);

		// width of image
		temp_node = out_xml.createElement ("width");
		temp_node_2 = out_xml.createTextNode (mc_ref.clip_mc.get_display_dimension () ["width"].toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// height of image
		temp_node = out_xml.createElement ("height");
		temp_node_2 = out_xml.createTextNode (mc_ref.clip_mc.get_display_dimension () ["height"].toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// rotation of image
		temp_node = out_xml.createElement ("rotation");
		temp_node_2 = out_xml.createTextNode (mc_ref.clip_mc._rotation.toString ());
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// url of image
		temp_node = out_xml.createElement ("url");
		temp_node_2 = out_xml.createTextNode (mc_ref.mc_url);
		temp_node.appendChild (temp_node_2);
		root_node.appendChild (temp_node);
		
		// export the xml node to whatever place need this
		return (root_node);
	}

	// **********
	// get mc url
	// **********
	public function get_mc_url ():String
	{
		return (mc_url);
	}
}
