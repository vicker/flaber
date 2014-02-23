// *****************
// PageContent class
// *****************
class as.page_content.PageContentMC extends MovieClip
{
	// MC variables
	// MovieClip		bg_mc;
	
	// private variables
	private var content_mc_array:Array;			// array storing all the content items
	
	private var mc_ref:MovieClip;					// reference back to the page content mc
	
	private var file_name:String;					// for tracer
	private var loaded_file:String;				// loaded file name

	private var max_depth:Number;					// the maximum depth of the page content items

	// ***********
	// constructor
	// ***********
	public function PageContentMC ()
	{
		mc_ref = this; 
		
		content_mc_array = new Array ();
		
		file_name = "(PageContentMC.as)";
		
		max_depth = 0;
	}
	
	// **********
	// destructor
	// **********
	public function destroy ():Void
	{
		for (var i in content_mc_array)
		{
			_root.mode_broadcaster.remove_observer (content_mc_array [i]);
			content_mc_array [i].removeMovieClip ();
		}
	}
	
	// *************
	// load root_xml
	// *************
	public function load_root_xml (s:String):Void
	{
		loaded_file = "page/" + s;
		
		// destroying old contents
		destroy ();
		
		// xml data loading
		var root_xml:XML;
		root_xml = new XML ();
		root_xml ["class_ref"] = this;
		root_xml.ignoreWhite = true;
		root_xml.sendAndLoad ("page/" + s + _root.sys_func.get_break_cache (), root_xml, "POST");
		
		root_xml.onLoad = function (b:Boolean)
		{
			// when xml loading is success
			if (b)
			{
				this.class_ref.set_root_xml (this);
			}
			else
			{
				_root.status_mc.add_message (this.class_ref.file_name + " constructor load xml fail.", "critical");
			}
		}
	}
	
	// ************
	// set root_xml
	// ************
	public function set_root_xml (x:XML):Void
	{
		// try to find out the config node and data node
		for (var i in x.firstChild.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			
			temp_node = x.firstChild.childNodes [i];
			temp_name = temp_node.nodeName;
			
			switch (temp_name)
			{
				// config node
				case "config":
				{
					set_config_xml (temp_node);
					break;
				}
				// data node
				case "data":
				{
					set_data_xml (temp_node);
					break;
				}
				// exception
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name + "'", "critical");
				}
			}
		}		
	}
	
	// **************
	// set config_xml
	// **************
	public function set_config_xml (x:XMLNode):Void
	{
		// try to parse the config node
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			
			// since bg_image have additional nodes
			if (temp_name != "bg_image")
			{
				temp_value = temp_node.firstChild.nodeValue;
				
			}
			
			switch (temp_name)
			{
				// x position of the page content
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the page content
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// background color of the page content
				case "bg_color":
				{
					var temp_color:Color;
					
					temp_color = new Color (mc_ref.bg_color);
					temp_color.setRGB (parseInt (temp_value));
					break;
				}
				// background image of the page content
				case "bg_image":
				{
					// since background image still have many nodes, so need to iterate again
					for (var j in temp_node.childNodes)
					{
						var temp_name_2:String;
						var temp_value_2:String;
						
						temp_name_2 = temp_node.childNodes [j].nodeName;
						temp_value_2 = temp_node.childNodes [j].firstChild.nodeValue;
						
						switch (temp_name_2)
						{
							// x position of the bg image
							case "x":
							{
								mc_ref.bg_image._x = parseInt (temp_value_2);
								break;
							}
							// y position of the bg image
							case "y":
							{
								mc_ref.bg_image._y = parseInt (temp_value_2);
								break;
							}
							// path of the bg image
							case "url":
							{
								var temp_loader:MovieClipLoader;
								var temp_listener:Object;
								
								// if the file doesn't exists... report error
								temp_listener = new Object ();
								temp_listener.onLoadError = function ()
								{
									_root.status_mc.add_message ("(PageContentMC.as) background image doesn't exists.", "critical");
								}
								
								temp_loader = new MovieClipLoader ();
								temp_loader.addListener (temp_listener);
								temp_loader.loadClip (temp_value_2, mc_ref.bg_image);
								
								break;
							}
							// alpha of the bg image
							case "alpha":
							{
								mc_ref.bg_image._alpha = parseInt (temp_value_2);
								break;
							}
							// exception
							default:
							{
								_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name_2 + "'", "critical");
							}
						}
					}
					break;
				}
				// exception
				default:
				{
					_root.status_mc.add_message (file_name + " node skipped with node name '" + temp_name_2 + "'", "critical");
				}
			}
		}
	}
	
	// ************
	// add new item
	// ************
	public function add_new_item (s:String, x:XMLNode):Void
	{
		var lib_name:String;
		var temp_name:String;
		
		switch (s)
		{
			// TextField
			case "TextFieldMC":
			{
				lib_name = "lib_page_content_textfield";
				temp_name = "text_field_";
				break;
			}
			// Image
			case "ImageMC":
			{
				lib_name = "lib_page_content_image";
				temp_name = "image_";
				break;
			}
			// Link
			case "LinkMC":
			{
				lib_name = "lib_page_content_link";
				temp_name = "link_";
				break;
			}
			// Rectangle Shape
			case "RectangleMC":
			{
				lib_name = "lib_shape_rectangle";
				temp_name = "rectangle_";
				break;
			}
			// exception
			default:
			{
				_root.status_mc.add_message (file_name + " item skipped with item name '" + s + "'", "critical");
			}
		}
		
		var temp_id:Number;
		
		// if it is added by loading data, then must have depth data
		if (x != null)
		{
			temp_id = parseInt (x.attributes.depth);
			max_depth = Math.max (max_depth, temp_id);
		}
		// else it means this is brand new item
		else	
		{
			temp_id = max_depth + 1;
			max_depth = max_depth + 1;
		}
		
		content_mc_array [temp_id] = mc_ref.attachMovie (lib_name, temp_name + temp_id, temp_id, {_x: 50, _y:50});
		
		// if it is added by loading data, then set the xml data
		if (x)	{	content_mc_array [temp_id].set_data_xml (x);	}
		// else try to open the properties window, because this is brand new item
		else
		{
			content_mc_array [temp_id].broadcaster_event (_root.sys_func.get_edit_mode ());
			content_mc_array [temp_id].properties_function ();
		}
		
		_root.mode_broadcaster.add_observer (content_mc_array [temp_id]);
	}
	
	// ************
	// set data_xml
	// ************
	public function set_data_xml (x:XMLNode):Void
	{
		// try to find out the page content mc nodes
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			
			temp_node = x.childNodes [i];
			
			var lib_name:String;
			var temp_name:String;
			
			add_new_item (temp_node.nodeName, temp_node);
		}
	}

	// ********
	// save_xml
	// ********
	public function save_xml ():Void
	{
		_root.status_mc.add_message ("Saving page content...", "normal");
		
		var out_xml:XML;
		var out_string:String;
		var return_xml:XML;
		
		var root_node:XMLNode;
		var config_node:XMLNode;
		var data_node:XMLNode;
		
		var temp_node:XMLNode;
		var temp_node_2:XMLNode;
		var temp_node_3:XMLNode;
		
		out_string = "<?xml version='1.0'?>";
		
		out_xml = new XML ();
		
		// building root node
		root_node = out_xml.createElement ("PageContent");
		root_node.attributes ["xmlns"] = "http://www.w3schools.com";
		root_node.attributes ["xmlns:xsi"] ="http://www.w3.org/2001/XMLSchema-instance";
		out_xml.appendChild (root_node);
		
		// building config node
		config_node = out_xml.createElement ("config");
			
			// x of page content
			temp_node = out_xml.createElement ("x");
			temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// y of page content
			temp_node = out_xml.createElement ("y");
			temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// bg color of page content
			temp_node = out_xml.createElement ("bg_color");
			
			var temp_color:Color;
			temp_color = new Color (mc_ref.bg_color);
			
			temp_node_2 = out_xml.createTextNode ("0x" + temp_color.getRGB ().toString (16));
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// bg image of navigation menu
			temp_node = out_xml.createElement ("bg_image");
			
			temp_node_2 = out_xml.createElement ("x");
			temp_node_3 = out_xml.createTextNode (mc_ref.bg_image._x);
			temp_node_2.appendChild (temp_node_3);
			temp_node.appendChild (temp_node_2);
			
			temp_node_2 = out_xml.createElement ("y");
			temp_node_3 = out_xml.createTextNode (mc_ref.bg_image._y);
			temp_node_2.appendChild (temp_node_3);
			temp_node.appendChild (temp_node_2);
			
			temp_node_2 = out_xml.createElement ("url");
			temp_node_3 = out_xml.createTextNode (mc_ref.bg_image._url);
			temp_node_2.appendChild (temp_node_3);
			temp_node.appendChild (temp_node_2);
			
			temp_node_2 = out_xml.createElement ("alpha");
			temp_node_3 = out_xml.createTextNode (mc_ref.bg_image._alpha);
			temp_node_2.appendChild (temp_node_3);
			temp_node.appendChild (temp_node_2);
			
			config_node.appendChild (temp_node);
			
		root_node.appendChild (config_node);
		
		// building data node
		data_node = out_xml.createElement ("data");
			
			// calling each navigation item instance to return their xml
			for (var i in content_mc_array)
			{
				temp_node = content_mc_array [i].export_xml ();
				data_node.appendChild (temp_node);
			}
			
		root_node.appendChild (data_node);
		
		return_xml = new XML ();
		return_xml.onLoad = function (b: Boolean)
		{
			if (b)
			{
				_root.status_mc.add_message (return_xml.toString (), "");
			}
		}
		
		// append those string contents to the xml and rebuild it
		out_string = out_string + out_xml.toString ();
		out_xml = new XML (out_string);
		out_xml.contentType = "text/xml";
		
		out_xml.sendAndLoad ("function/update_xml.php?target_file=" + loaded_file, return_xml);
	}
}
