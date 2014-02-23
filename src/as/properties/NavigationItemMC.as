// **********************
// NavigationItemMC class
// **********************
class as.properties.NavigationItemMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip					// reference to the movie clip
	private var target_ref:MovieClip				// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function NavigationItemMC ()
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
		
		// item label
		mc_ref.item_label_textinput.text = target_ref.get_content_field ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "x_textinput", 1, {_x:120, _y:40, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "y_textinput", 2, {_x:200, _y:40, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "item_label_textinput", 3, {_x:90, _y:100, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "internal_radiobutton", 4, {_x:90, _y:160, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "external_radiobutton", 5, {_x:170, _y:160, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "link_textinput", 6, {_x:90, _y:180, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.ComboBox, "link_combobox", 7, {_x:90, _y:180, _width:150, _height:20});
		
		setup_internal_radiobutton ();
		setup_external_radiobutton ();
		setup_link_radiobuttongroup ();
		setup_link_textinput ();
		setup_link_combobox ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.position_label.setStyle ("styleName", "label_style");
		mc_ref.x_label.setStyle ("styleName", "label_style");
		mc_ref.y_label.setStyle ("styleName", "label_style");
		mc_ref.item_label_label.setStyle ("styleName", "label_style");
		mc_ref.link_label.setStyle ("styleName", "label_style");
		
		mc_ref.x_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.y_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.item_label_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.link_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.link_combobox.setStyle ("styleName", "combobox_style");
		
		mc_ref.internal_radiobutton.setStyle ("styleName", "radiobutton_style");
		mc_ref.external_radiobutton.setStyle ("styleName", "radiobutton_style");
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
		
		return true;
	}
	
	// **************************
	// setup internal radiobutton
	// **************************
	public function setup_internal_radiobutton ():Void
	{
		mc_ref.internal_radiobutton.label = "Internal";
		mc_ref.internal_radiobutton.labelPlacement = "left";
		mc_ref.internal_radiobutton.data = "0";
		mc_ref.internal_radiobutton.groupName = "link_radiobuttongroup";
	}
	
	// **************************
	// setup external radiobutton
	// **************************
	public function setup_external_radiobutton ():Void
	{
		mc_ref.external_radiobutton.label = "External";
		mc_ref.external_radiobutton.labelPlacement = "left";
		mc_ref.external_radiobutton.data = "1";
		mc_ref.external_radiobutton.groupName = "link_radiobuttongroup";
	}

	// ***************************
	// setup link radiobuttongroup
	// ***************************
	public function setup_link_radiobuttongroup ():Void
	{
		var temp_listener:Object;
		temp_listener = new Object ();
		
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.click = function ()
		{
			if (this.class_ref.internal_radiobutton.selected == true)
			{
				this.class_ref.link_combobox.enabled = true;
				this.class_ref.link_combobox.visible = true;
				this.class_ref.link_textinput.enabled = false;
				this.class_ref.link_textinput.visible = false;
			}
			if (this.class_ref.external_radiobutton.selected == true)
			{
				this.class_ref.link_textinput.enabled = true;
				this.class_ref.link_textinput.visible = true;
				this.class_ref.link_combobox.enabled = false;
				this.class_ref.link_combobox.visible = false;
			}
		}
		
		mc_ref.link_radiobuttongroup.addEventListener ("click", temp_listener);
	}

	// ********************
	// setup link textinput
	// ********************
	public function setup_link_textinput ():Void
	{
		mc_ref.link_textinput.enabled = false;
		mc_ref.link_textinput.visible = false;
	}
	
	// *******************
	// setup link combobox
	// *******************
	public function setup_link_combobox ():Void
	{
		//TODO hardcoding array now, should be from PHP
		var temp_array:Array;
		
		temp_array = new Array ("index.xml", "page2.xml");
		
		for (var i = 0; i < temp_array.length; i++)
		{
			mc_ref.link_combobox.addItem ({label:temp_array [i], data:temp_array [i]});
		}
		
		mc_ref.link_combobox.enabled = false;
		mc_ref.link_combobox.visible = false;
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