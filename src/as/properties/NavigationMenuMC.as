// **********************
// NavigationMenuMC class
// **********************
class as.properties.NavigationMenuMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip					// reference to the movie clip
	private var target_ref:MovieClip				// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function NavigationMenuMC ()
	{
		mc_ref = this;
		
		setup_component_object ();
		setup_component_style ();
	}
	
	// **************
	// set target ref
	// **************
	public function set_target_ref (m:MovieClip):Void
	{
		target_ref = m;
		
		// position
		mc_ref.x_textinput.text = target_ref._x;
		mc_ref.y_textinput.text = target_ref._y;
		
		// graphic style
		var temp_style:Object;
		
		temp_style = target_ref.get_menu_style ();
		
		for (var i = 0; i < mc_ref.graphic_style_list.length; i++)
		{
			if (mc_ref.graphic_style_list.getItemAt (i).data == temp_style.name)
			{
				mc_ref.graphic_style_list.selectedIndex = i;
				mc_ref.preview_mc.attachMovie (mc_ref.graphic_style_list.getItemAt (i).data, "preview_item", 1);
				
				break;
			}
		}
		
		// font style
		var text_format:TextFormat;
		
		text_format = new TextFormat ();
		text_format = target_ref.get_text_format ();
		
		// font
		for (var i = 0; i < mc_ref.font_combobox.length; i++)
		{
			if (mc_ref.font_combobox.getItemAt (i).data == text_format.font)
			{
				mc_ref.font_combobox.selectedIndex = i;
				break;
			}
		}
		
		// font size
		var size_found:Boolean;
		
		size_found = false;
		
		for (var i = 0; i < mc_ref.font_size_combobox.length; i++)
		{
			if (parseInt (mc_ref.font_size_combobox.getItemAt (i).data) == text_format.size)
			{
				mc_ref.font_size_combobox.selectedIndex = i;
				size_found = true;
				break;
			}
		}
		
		if (size_found == false)
		{
			mc_ref.font_size_combobox.text = text_format.size;
		}
		
		// weight
		if (text_format.bold == true)
		{
			mc_ref.bold_button.selected = true;
		}
		
		// italic
		if (text_format.italic == true)
		{
			mc_ref.italic_button.selected = true;
		}
		
		// underline
		if (text_format.underline == true)
		{
			mc_ref.underline_button.selected = true;
		}
		
		// color
		if (text_format.color)
		{
			mc_ref.font_color_palette.set_color_num (text_format.color);
		}
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "x_textinput", 1, {_x:80, _y:40, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "y_textinput", 2, {_x:160, _y:40, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.ComboBox, "font_combobox", 3, {_x:20, _y:100, _width:110, _height:20});
		mc_ref.createClassObject (mx.controls.ComboBox, "font_size_combobox", 4, {_x:150, _y:100, _width:50, _height:20});
		mc_ref.createClassObject (mx.controls.Button, "bold_button", 5, {_x:20, _y:130, _width:20, _height:20});
		mc_ref.createClassObject (mx.controls.Button, "italic_button", 6, {_x:50, _y:130, _width:20, _height:20});
		mc_ref.createClassObject (mx.controls.Button, "underline_button", 7, {_x:80, _y:130, _width:20, _height:20});
		mc_ref.attachMovie ("lib_normal_palette", "font_color_palette", 8, {_x:115, _y:130});
		mc_ref.createClassObject (mx.controls.List, "graphic_style_list", 9, {_x:260, _y:40, _width:150, _height:80});
		
		setup_font_combobox ();
		setup_font_size_combobox ();
		setup_bold_button ();
		setup_italic_button ();
		setup_underline_button ();
		setup_graphic_style_list ();
		setup_apply_button ();
		setup_ok_button ();
		setup_cancel_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.position_label.setStyle ("styleName", "label_style");
		mc_ref.x_label.setStyle ("styleName", "label_style");
		mc_ref.y_label.setStyle ("styleName", "label_style");
		mc_ref.font_style_label.setStyle ("styleName", "label_style");
		mc_ref.graphic_style_label.setStyle ("styleName", "label_style");
		
		mc_ref.x_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.y_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.font_combobox.setStyle ("styleName", "combobox_style");
		mc_ref.font_size_combobox.setStyle ("styleName", "combobox_style");
		
		mc_ref.bold_button.setStyle ("themeColor", "haloOrange");
		mc_ref.italic_button.setStyle ("themeColor", "haloOrange");
		mc_ref.underline_button.setStyle ("themeColor", "haloOrange");
		
		mc_ref.graphic_style_list.setStyle ("styleName", "list_style");
	}
	
	// *******************
	// setup font combobox
	// *******************
	public function setup_font_combobox ():Void
	{
		var font_list:Array;
		font_list = new Array ();
		font_list = TextField.getFontList ();
		font_list.sort ();
		
		for (var i = 0; i < font_list.length; i++)
		{
			mc_ref.font_combobox.addItem (font_list [i], font_list [i]);
		}
	}
	
	// ************************
	// setup font size combobox
	// ************************
	public function setup_font_size_combobox ():Void
	{
		var font_size_list:Array;
		font_size_list = new Array (8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72);
		
		for (var i = 0; i < font_size_list.length; i++)
		{
			mc_ref.font_size_combobox.addItem (font_size_list [i], font_size_list [i]);
		}
		
		mc_ref.font_size_combobox.editable = true;	
	}
	
	// *****************
	// setup bold button
	// *****************
	public function setup_bold_button ():Void
	{
		mc_ref.bold_button.toggle = true;
		mc_ref.bold_button.icon = "lib_button_bold";
	}
	
	// *******************
	// setup italic button
	// *******************
	public function setup_italic_button ():Void
	{
		mc_ref.italic_button.toggle = true;
		mc_ref.italic_button.icon = "lib_button_italic";
	}
	
	// **********************
	// setup underline button
	// **********************
	public function setup_underline_button ():Void
	{
		mc_ref.underline_button.toggle = true;
		mc_ref.underline_button.icon = "lib_button_underline";
	}
		
	// ************************
	// setup graphic style list
	// ************************
	public function setup_graphic_style_list ():Void
	{
		mc_ref.graphic_style_list.rowHeight = 17;
		
		var graphic_array:Array;
		
		graphic_array = new Array ("lib_navigation_item_1", "lib_navigation_item_2");
		
		for (var i in graphic_array)
		{
			mc_ref.graphic_style_list.addItem ({label:graphic_array [i], data:graphic_array [i]});
		}
		
		mc_ref.graphic_style_list.sortItemsBy ("label", "ASC");
		
		var temp_listener:Object;
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function ()
		{
			this.class_ref.preview_mc.attachMovie (this.class_ref.graphic_style_list.selectedItem.data, "preview_item", 1);
		}
		
		mc_ref.graphic_style_list.addEventListener ("change", temp_listener);
	}
	
	// ***************
	// data validation
	// ***************
	public function data_validation ():Boolean
	{
		if (mc_ref.x_textinput.text == "")
		{
			mc_ref.x_textinput.text = "0";
		}
		
		if (mc_ref.y_textinput.text == "")
		{
			mc_ref.y_textinput.text = "0";
		}
		
		if (mc_ref.font_size_combobox.text == "")
		{
			mc_ref.font_size_combobox.text = "8";
		}
		
		return true;
	}
	
	// ******************
	// setup apply button
	// ******************
	public function setup_apply_button ():Void
	{
		mc_ref.apply_button ["class_ref"] = mc_ref;
		mc_ref.apply_button.onRelease = function ()
		{
			if (this.class_ref.data_validation () == true)
			{		
				var config_xml:XML;
				var config_node:XMLNode;
				var temp_node:XMLNode;
				var temp_node_2:XMLNode;
				var temp_node_3:XMLNode;
				
				config_xml = new XML ();
				
				config_node = config_xml.createElement ("config");
				
				temp_node = config_xml.createElement ("x");
				temp_node_2 = config_xml.createTextNode (this.class_ref.x_textinput.text);
				temp_node.appendChild (temp_node_2);
				config_node.appendChild (temp_node);
				
				temp_node = config_xml.createElement ("y");
				temp_node_2 = config_xml.createTextNode (this.class_ref.y_textinput.text);
				temp_node.appendChild (temp_node_2);
				config_node.appendChild (temp_node);
				
				temp_node = config_xml.createElement ("menu_style");
				temp_node_2 = config_xml.createElement ("name");
				temp_node_3 = config_xml.createTextNode (this.class_ref.graphic_style_list.selectedItem.data);
				temp_node_2.appendChild (temp_node_3);
				temp_node.appendChild (temp_node_2);
				config_node.appendChild (temp_node);
				
				temp_node = config_xml.createElement ("text_format");
				
				temp_node_2 = config_xml.createElement ("font");
				temp_node_3 = config_xml.createTextNode (this.class_ref.font_combobox.selectedItem.data);
				temp_node_2.appendChild (temp_node_3);
				temp_node.appendChild (temp_node_2);
				
				temp_node_2 = config_xml.createElement ("size");
				temp_node_3 = config_xml.createTextNode (this.class_ref.font_size_combobox.text);
				temp_node_2.appendChild (temp_node_3);
				temp_node.appendChild (temp_node_2);
				
				if (this.class_ref.bold_button.selected == true)
				{
					temp_node_2 = config_xml.createElement ("bold");
					temp_node_3 = config_xml.createTextNode ("true");
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
				
				if (this.class_ref.italic_button.selected == true)
				{
					temp_node_2 = config_xml.createElement ("italic");
					temp_node_3 = config_xml.createTextNode ("true");
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
				
				if (this.class_ref.underline_button.selected == true)
				{
					temp_node_2 = config_xml.createElement ("underline");
					temp_node_3 = config_xml.createTextNode ("true");
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
				
				if (this.class_ref.font_color_palette.get_color_string () != null)
				{
					temp_node_2 = config_xml.createElement ("color");
					temp_node_3 = config_xml.createTextNode (this.class_ref.font_color_palette.get_color_string ());
					temp_node_2.appendChild (temp_node_3);
					temp_node.appendChild (temp_node_2);
				}
				
				config_node.appendChild (temp_node);
				
				var update_xml:XML;
				
				update_xml = this.class_ref.target_ref.export_xml ();
				
				for (var i in update_xml.childNodes)
				{
					for (var j in update_xml.childNodes [i].childNodes)
					{
						var temp_node:XMLNode;
						
						temp_node = update_xml.childNodes [i].childNodes [j];
						if (temp_node.nodeName == "config")
						{
							temp_node.removeNode ();
							
							update_xml.childNodes [i].appendChild (config_node);
						}
					}
				}
				
				this.class_ref.target_ref.set_root_xml (update_xml);
				this.class_ref.target_ref.broadcaster_event (true);
			}
		}
	}
	
	// ***************
	// setup ok button
	// ***************
	public function setup_ok_button ():Void
	{
		mc_ref.ok_button ["class_ref"] = mc_ref;
		mc_ref.ok_button.onRelease = function ()
		{
			this.class_ref.apply_button.onRelease ();
			this.class_ref._parent.close_window ();
		}
	}
	
	// *******************
	// setup cancel button
	// *******************
	public function setup_cancel_button ():Void
	{
		mc_ref.cancel_button ["class_ref"] = mc_ref;
		mc_ref.cancel_button.onRelease = function ()
		{
			this.class_ref._parent.close_window ();
		}
	}
}