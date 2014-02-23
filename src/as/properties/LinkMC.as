// ************
// LinkMC class
// ************
class as.properties.LinkMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	private var target_ref:MovieClip;			// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function LinkMC ()
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
		
		// content
		if (target_ref.textfield_mc)
		{
			mc_ref.textfield_checkbox.selected = true;
			mc_ref.textfield_button.enabled = true;
		}
		
		if (target_ref.image_mc)
		{
			mc_ref.image_checkbox.selected = true;
			mc_ref.image_button.enabled = true;
		}
		
		// link type and url
		switch (target_ref.get_link_type ())
		{
			case 0:
			{
				// internal link
				mc_ref.internal_radiobutton.selected = true;
				mc_ref.link_radiobuttongroup.dispatchEvent({type:"click"});
				
				_root.sys_func.combobox_select_item (mc_ref.link_combobox, target_ref.get_link_url ());
				
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
		mc_ref.createClassObject (mx.controls.CheckBox, "textfield_checkbox", 3, {_x:80, _y:95, _width:80, _height:20});
		mc_ref.createClassObject (mx.controls.Button, "textfield_button", 4, {_x:170, _y:95, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.CheckBox, "image_checkbox", 5, {_x:80, _y:125, _width:80, _height:20});
		mc_ref.createClassObject (mx.controls.Button, "image_button", 6, {_x:170, _y:125, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "internal_radiobutton", 8, {_x:80, _y:185, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.RadioButton, "external_radiobutton", 9, {_x:160, _y:185, _width:60, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "link_textinput", 10, {_x:80, _y:205, _width:150, _height:20});
		mc_ref.createClassObject (mx.controls.ComboBox, "link_combobox", 11, {_x:80, _y:205, _width:150, _height:20});
		
		setup_component_style ();
		
		setup_textfield_checkbox ();
		setup_textfield_button ();
		setup_image_checkbox ();
		setup_image_button ();
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
		mc_ref.content_label.setStyle ("styleName", "label_style");
		mc_ref.link_label.setStyle ("styleName", "label_style");
		
		mc_ref.x_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.y_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.link_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.link_combobox.setStyle ("styleName", "combobox_style");
		
		mc_ref.textfield_checkbox.setStyle ("styleName", "checkbox_style");
		mc_ref.image_checkbox.setStyle ("styleName", "checkbox_style");
		
		mc_ref.internal_radiobutton.setStyle ("styleName", "radiobutton_style");
		mc_ref.external_radiobutton.setStyle ("styleName", "radiobutton_style");
		
		mc_ref.textfield_button.setStyle ("styleName", "button_style");
		mc_ref.image_button.setStyle ("styleName", "button_style");
	}
	
	// ************************
	// setup textfield checkbox
	// ************************
	public function setup_textfield_checkbox ():Void
	{
		mc_ref.textfield_checkbox.label = " TextField"
		
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.click = function ()		{
			this.class_ref.textfield_button.enabled = this.class_ref.textfield_checkbox.selected;
			
			if (this.class_ref.textfield_checkbox.selected == true)
			{
				var temp_name:String;
				var lib_name:String;
				
				temp_name = "textfield_mc";
				lib_name = "lib_page_content_textfield";
				
				this.class_ref.target_ref.attachMovie (lib_name, temp_name, 0);
			}
			else
			{
				this.class_ref.target_ref.textfield_mc.removeMovieClip ();
			}
		}
		
		mc_ref.textfield_checkbox.addEventListener ("click", temp_listener);
	}
	
	// **********************
	// setup textfield button
	// **********************
	public function setup_textfield_button ():Void
	{
		mc_ref.textfield_button.label = "Edit...";
		
		mc_ref.textfield_button.enabled = false;
		
		mc_ref.textfield_button ["class_ref"] = mc_ref;
		mc_ref.textfield_button.onRelease = function ()
		{
			var temp_lib:String;
			var temp_name:String;
			var temp_width:Number;
			var temp_height:Number;
			
			temp_lib = "lib_properties_textfield";
			temp_name = "Textfield Properties Window";
			temp_width = 470;
			temp_height = 460;
			
			var temp_x_adjust:Number;
			var temp_y_adjust:Number;
			
			temp_x_adjust = this.class_ref._parent._x;
			temp_y_adjust = this.class_ref._parent._y;
			
			this.class_ref.attachMovie ("lib_window", "window_mc", 9999);
			this.class_ref.window_mc.set_window_data (temp_name, temp_width, temp_height, temp_lib);
			this.class_ref.window_mc._x = this.class_ref.window_mc._x - temp_x_adjust;
			this.class_ref.window_mc._y = this.class_ref.window_mc._y - temp_y_adjust;
			this.class_ref.window_mc.content_mc.set_target_ref (this.class_ref.target_ref.textfield_mc);
		}
	}
	
	// ********************
	// setup image checkbox
	// ********************
	public function setup_image_checkbox ():Void
	{
		mc_ref.image_checkbox.label = " Image"
		
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.click = function ()
		{
			this.class_ref.image_button.enabled = this.class_ref.image_checkbox.selected;
			
			//TODO real image mc building function is not written yet
			//wait for the image mc panel first
		}
		
		mc_ref.image_checkbox.addEventListener ("click", temp_listener);
	}
	
	// ******************
	// setup image button
	// ******************
	public function setup_image_button ():Void
	{
		mc_ref.image_button.label = "Edit...";
		
		mc_ref.image_button.enabled = false;
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
				
				item_node = item_xml.createElement ("LinkMC");
				item_node.attributes.style = "global";
				
				temp_node = item_xml.createElement ("x");
				temp_node_2 = item_xml.createTextNode (this.class_ref.x_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("y");
				temp_node_2 = item_xml.createTextNode (this.class_ref.y_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				//TODO exporting the imagemc
				if (this.class_ref.target_ref.textfield_mc)
				{
					temp_node = this.class_ref.target_ref.textfield_mc.export_xml ();
					item_node.appendChild (temp_node);
				}
				
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

				this.class_ref.target_ref.set_data_xml (item_node);
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