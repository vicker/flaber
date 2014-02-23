// **********************
// NavigationMenuMC class
// **********************
class as.navigation_menu.NavigationMenuMC extends MovieClip
{
	// private variables
	private var data_xml:XMLNode;					// xml data
	private var config_xml:XMLNode;				// xml config
	
	private var text_format:TextFormat;			// text format of the menu items
	private var menu_style:Object;				// menu style's linkage name
	
	private var item_num:Number;					// number of menu items
	private var item_mc_array:Array;				// array storing all the menu items
	
	private var mc_ref:MovieClip;					// reference back to the navigation menu mc
	private var page_ref:MovieClip;				// reference back to the page content mc
	
	private var file_name:String;					// for tracer
	private var export_flag:Boolean;				// state that this mc have to be exported

	// ***********
	// constructor
	// ***********
	public function NavigationMenuMC ()
	{
		mc_ref = this; 
		
		text_format = new TextFormat ();
		menu_style = new Object ();
		item_mc_array = new Array ();
		
		file_name = "NavigationMenuMC.as";
		export_flag = true;
		
		// xml data loading
		var temp_xml:XML = new XML ();
		temp_xml ["class_ref"] = this;
		temp_xml.ignoreWhite = true;
		temp_xml.load ("NavigationMenu.xml");
		// temp_xml.load ("NavigationMenu.xml?break_cache=" + new Date ().getTime ());
		
		temp_xml.onLoad = function (b:Boolean)
		{
			// when xml loading is success
			if (b)
			{
				var temp_node:XMLNode;
				var temp_length:Number;
				
				temp_length = temp_xml.firstChild.childNodes.length;
				
				// try to find out the config node and data node
				for (var i = 0; i < temp_length; i++)
				{
					temp_node = temp_xml.firstChild.childNodes [i];
					
					switch (temp_node.nodeName)
					{
						// config node
						case "config":
						{
							// because within onLoad is outside class scope, so need a pointer point back
							this.class_ref.set_config_xml (temp_node);
							break;
						}
						// data node
						case "data":
						{
							// because within onLoad is outside class scope, so need a pointer point back
							this.class_ref.set_data_xml (temp_node);
							break;
						}
						// exception
						default:
						{
							trace (this.class_ref.file_name + " -> node skipped with node name - " + temp_node.nodeName);
						}
					}
				}
			}
			else
			{
				trace (this.class_ref.file_name + " -> Constructor load xml fail.");
			}
		}
	}
	
	// ******************
	// config_xml parsing
	// ******************
	public function parse_config_xml ():Void
	{
		var temp_node:XMLNode;
		var temp_length:Number;
		temp_length = config_xml.childNodes.length;
		
		// try to parse the config node
		for (var i = 0; i < temp_length; i++)
		{
			temp_node = config_xml.childNodes [i];
			
			switch (temp_node.nodeName)
			{
				// x position of the navigation menu
				case "x":
				{
					mc_ref._x = parseInt (temp_node.firstChild.nodeValue);
					break;
				}
				// y position of the navigation menu
				case "y":
				{
					mc_ref._y = parseInt (temp_node.firstChild.nodeValue);
					break;
				}
				// global menu style
				case "menu_style":
				{
					var temp_length_2:Number;
					
					temp_length_2 = temp_node.childNodes.length;
					
					// since menu style still have many nodes, so need to iterate again
					for (var j = 0; j < temp_length_2; j++)
					{
						menu_style [temp_node.childNodes [j].nodeName] = temp_node.childNodes [j].firstChild.nodeValue;
					}
					break;
				}
				// global text format
				case "text_format":
				{
					var temp_length_2:Number;
					
					temp_length_2 = temp_node.childNodes.length;
					
					// since text format still have many nodes, so need to iterate again
					for (var j = 0; j < temp_length_2; j++)
					{
						text_format [temp_node.childNodes [j].nodeName] = temp_node.childNodes [j].firstChild.nodeValue;
					}
					break;
				}
				default:
				{
					trace (file_name + " -> node skipped with node name - " + temp_node.nodeName);
				}
			}
		}
	}
	
	// ****************
	// data_xml parsing
	// ****************
	public function parse_data_xml ():Void
	{
		if (config_xml)
		{
			var temp_node:XMLNode;
			var temp_length:Number;
			
			var temp_x:Number;
			var temp_y:Number;
			var temp_text:String;
			
			var temp_style:Object;	  		 // in case the navigation item mc want to override the global
			var temp_format:TextFormat;	 // same reason as above
			
			item_num = data_xml.childNodes.length;
			
			// try to find out the navigation item mc nodes
			for (var i = 0; i < item_num; i++)
			{
				temp_node = data_xml.childNodes [i];
				
				if (temp_node.nodeName == "NavigationItemMC")
				{
				
					temp_length = temp_node.childNodes.length;
					
					// getting the contents of the navigation item mc to temp variables first before building mc
					for (var j = 0; j < temp_length; j++)
					{
						// initialize variables
						temp_style = new Object ();
						temp_format = new TextFormat ();
						
						switch (temp_node.childNodes [j].nodeName)
						{
							// x position of the navigation item respect to the menu
							case "x":
							{
								temp_x = parseInt (temp_node.childNodes [j].firstChild.nodeValue);
								break;
							}
							// y position of the navigation item respect to the menu
							case "y":
							{
								temp_y = parseInt (temp_node.childNodes [j].firstChild.nodeValue);
								break;
							}
							// text content of the navigation item
							case "text":
							{
								temp_text = temp_node.childNodes [j].firstChild.nodeValue;
								break;
							}
							// overriding global menu style
							case "menu_style":
							{
								//TODO hardcode now, to be completed
								temp_style ["name"] = "something else";
								break;
							}
							// overriding global text format
							case "text_format":
							{
								//TODO hardcode now, to be completed
								temp_format ["font"] = "something else";
								break;
							}
							// exception
							default:
							{
								trace (file_name + " -> node skipped with node name - " + temp_node.nodeName);
							}
						}
					}
					
					// building mc
					if (temp_style ["name"])
					{
						// have overriding style
						item_mc_array [i] = mc_ref.attachMovie (temp_style ["name"], "menu_item_" + i, mc_ref.getNextHighestDepth ());
					}
					else
					{
						// use global style
						item_mc_array [i] = mc_ref.attachMovie (menu_style ["name"], "menu_item_" + i, mc_ref.getNextHighestDepth ());
					}
					
					// applying text format
					if (temp_format ["font"] != null)
					{
						// have overriding style
						item_mc_array [i].set_global_flag (false);
						item_mc_array [i].set_text_format (null, temp_format);
					}
					else
					{
						// use global style
						item_mc_array [i].set_global_flag (true);
						item_mc_array [i].set_text_format (null, text_format);
					}
					
					// applying other properties
					item_mc_array [i]._x = temp_x;
					item_mc_array [i]._y = temp_y;
					item_mc_array [i].set_content_field (temp_text);
				}
				else
				{
					trace (file_name + " -> node skipped with node name - " + temp_node.nodeName);
				}
			}
		}
		else
		{
			trace (file_name + " -> config_xml not built before parsing data_xml.");
		}
	}

	// **********
	// export_xml
	// **********
	public function export_xml ():Void
	{
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
		root_node = out_xml.createElement ("NavigationMenu");
		root_node.attributes ["xmlns"] = "http://www.w3schools.com";
		root_node.attributes ["xmlns:xsi"] ="http://www.w3.org/2001/XMLSchema-instance";
		out_xml.appendChild (root_node);
		
		// building config node
		config_node = out_xml.createElement ("config");
			
			// x of navigation menu
			temp_node = out_xml.createElement ("x");
			temp_node_2 = out_xml.createTextNode (mc_ref._x.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// y of navigation menu
			temp_node = out_xml.createElement ("y");
			temp_node_2 = out_xml.createTextNode (mc_ref._y.toString ());
			temp_node.appendChild (temp_node_2);
			config_node.appendChild (temp_node);
			
			// menu style of navigation menu
			temp_node = out_xml.createElement ("menu_style");
			for (var i in menu_style)
			{
				temp_node_2 = out_xml.createElement (i);
				temp_node_3 = out_xml.createTextNode (menu_style [i]);
				temp_node_2.appendChild (temp_node_3);
				temp_node.appendChild (temp_node_2);
			}
			config_node.appendChild (temp_node);
			
			// text format of navigation menu
			temp_node = out_xml.createElement ("text_format");
			for (var i in text_format)
			{
				if (text_format [i] != null && i.indexOf ("getTextExtent") == -1)
				{
					temp_node_2 = out_xml.createElement (i);
					temp_node_3 = out_xml.createTextNode (text_format [i]);
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
			}
			config_node.appendChild (temp_node);
			
		root_node.appendChild (config_node);
		
		// building data node
		data_node = out_xml.createElement ("data");
			
			// calling each navigation item instance to return their xml
			for (var i in item_mc_array)
			{
				temp_node = item_mc_array [i].export_xml ();
				data_node.appendChild (temp_node);
			}
			
		root_node.appendChild (data_node);
		
		return_xml = new XML ();
		return_xml.onLoad = function (b: Boolean)
		{
			if (b)
			{
				_root.status_message.text = return_xml.toString ();
				//TODO start to write the system message class
			}
		}
		
		// append those string contents to the xml and rebuild it
		out_string = out_string + out_xml.toString ();
		out_xml = new XML (out_string);
		out_xml.contentType = "text/xml";
		out_xml.sendAndLoad ("update_xml.php?target_object=navigation_menu", return_xml);
	}
	
	// ****************************
	// config_xml setter and getter
	// ****************************
	public function set_config_xml (x:XMLNode):Void
	{
		config_xml = x;
		parse_config_xml ();
	}
	public function get_config_xml ():XMLNode	   { return config_xml; }	 
	
	// **************************
	// data_xml setter and getter
	// **************************
	public function set_data_xml (x:XMLNode):Void
	{
		data_xml = x;
		parse_data_xml ();
	}
	public function get_data_xml ():XMLNode		 { return data_xml; }
}
