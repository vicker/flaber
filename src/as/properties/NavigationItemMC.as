// **********************
// NavigationItemMC class
// **********************
class as.properties.NavigationItemMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// reference to the movie clip
	private var target_ref:MovieClip;			// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function NavigationItemMC ()
	{
		mc_ref = this;
		
		setup_component_object ();
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
		
		// link type and url
		switch (target_ref.get_link_type ())
		{
			case 0:
			{
				// internal link
				mc_ref.internal_radiobutton.selected = true;
				mc_ref.link_radiobuttongroup.dispatchEvent({type:"click"});
				
				mc_ref.link_combobox.select_item (target_ref.get_link_url ());
				
				break;
			}
			case 1:
			{
				// external link
				mc_ref.external_radiobutton.selected = true;
				mc_ref.link_radiobuttongroup.dispatchEvent({type:"click"});
				
				mc_ref.link_textinput.text = target_ref.get_link_url ();
				break;
			}
		}
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "x_textinput", 1, {_x:110, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "y_textinput", 2, {_x:190, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "item_label_textinput", 3, {_x:80, _y:95, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "internal_radiobutton", 4, {_x:80, _y:155, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "external_radiobutton", 5, {_x:160, _y:155, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "link_textinput", 6, {_x:80, _y:175, _width:150, _height:20});
		mc_ref.createClassObject (as.component.ComboBoxExtend, "link_combobox", 7, {_x:80, _y:175, _width:150, _height:20});

		mc_ref.attachMovie ("lib_button_mc", "apply_button", 8, {_x:10, _y:230});
		mc_ref.attachMovie ("lib_button_mc", "ok_button", 9, {_x:100, _y:230});
		mc_ref.attachMovie ("lib_button_mc", "cancel_button", 10, {_x:190, _y:230});
		
		setup_component_style ();
		
		setup_internal_radiobutton ();
		setup_external_radiobutton ();
		setup_link_radiobuttongroup ();
		setup_link_textinput ();
		setup_link_combobox ();
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
		mc_ref.link_textinput.text = "http://";
		
		mc_ref.link_textinput.enabled = false;
		mc_ref.link_textinput.visible = false;
	}
	
	// *******************
	// setup link combobox
	// *******************
	public function setup_link_combobox ():Void
	{
		var temp_array:Array;
		
		temp_array = _root.flaber.get_page_dir_array ();
		
		for (var i = 0; i < temp_array.length; i++)
		{
			mc_ref.link_combobox.addItem ({label:temp_array [i], data:temp_array [i]});
		}
		
		mc_ref.link_combobox.enabled = false;
		mc_ref.link_combobox.visible = false;
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
	
	// ******************
	// setup apply button
	// ******************
	public function setup_apply_button ():Void
	{
		mc_ref.apply_button.set_toggle_flag (false);
		mc_ref.apply_button.set_dimension (80, 20);
		mc_ref.apply_button.set_text ("Apply");

		mc_ref.apply_button ["class_ref"] = mc_ref;
		mc_ref.apply_button.onRelease = function ()
		{
			if (this.class_ref.data_validation () == true)
			{
				var item_xml:XML;
				var item_node:XMLNode;
				var temp_node:XMLNode;
				var temp_node_2:XMLNode;
				
				item_xml = new XML ();
				
				item_node = item_xml.createElement ("NavigationItemMC");
				item_node.attributes.style = "global";
				
				temp_node = item_xml.createElement ("x");
				temp_node_2 = item_xml.createTextNode (this.class_ref.x_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("y");
				temp_node_2 = item_xml.createTextNode (this.class_ref.y_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("text");
				temp_node_2 = item_xml.createTextNode (this.class_ref.item_label_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("type");
				temp_node_2 = item_xml.createTextNode (this.class_ref.link_radiobuttongroup.selectedData);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("url");
				
				if (this.class_ref.link_radiobuttongroup.selectedData == "0")
				{
					temp_node_2 = item_xml.createTextNode (this.class_ref.link_combobox.value);
				}
				else
				{
					temp_node_2 = item_xml.createTextNode (this.class_ref.link_textinput.text);
				}
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				this.class_ref.target_ref.set_data_xml (item_node, this.class_ref.target_ref.get_text_format ());
				this.class_ref.target_ref.broadcaster_event (true);
			}
		}
	}
	
	// ***************
	// setup ok button
	// ***************
	public function setup_ok_button ():Void
	{
		mc_ref.ok_button.set_toggle_flag (false);
		mc_ref.ok_button.set_dimension (80, 20);
		mc_ref.ok_button.set_text ("Ok");

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
		mc_ref.cancel_button.set_toggle_flag (false);
		mc_ref.cancel_button.set_dimension (80, 20);
		mc_ref.cancel_button.set_text ("Cancel");

		mc_ref.cancel_button ["class_ref"] = mc_ref;
		mc_ref.cancel_button.onRelease = function ()
		{
			this.class_ref._parent.close_window ();
		}
	}
}
