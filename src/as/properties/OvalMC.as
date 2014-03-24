// ************
// OvalMC class
// ************
class as.properties.OvalMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;				// reference to the movie clip
	private var target_ref:MovieClip;			// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function OvalMC ()
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
		
		var temp_param:Object = new Object ();
		temp_param = target_ref.get_shape_param (); 
		
		// position
		mc_ref.x_textinput.text = target_ref._x;
		mc_ref.y_textinput.text = target_ref._y;
		
		// dimension
		mc_ref.width_textinput.text = temp_param ["w"];
		mc_ref.height_textinput.text = temp_param ["h"];
		mc_ref.rotation_textinput.text = target_ref._rotation;
		
		// line style
		var line_style:Array;
		
		line_style = new Array ();
		line_style = target_ref.get_line_style ();
		
		mc_ref.line_width_textinput.text = temp_param ["ls"];
		mc_ref.line_color_palette.set_color_num (temp_param ["lc"]);
		mc_ref.line_alpha_textinput.text = temp_param ["la"];
		
		// fill style
		mc_ref.fill_color_palette.set_color_num (temp_param ["fc"]);
		mc_ref.fill_alpha_textinput.text = temp_param ["fa"];
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "x_textinput", 1, {_x:50, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "y_textinput", 2, {_x:130, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "width_textinput", 3, {_x:100, _y:95, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "height_textinput", 4, {_x:100, _y:120, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "rotation_textinput", 5, {_x:100, _y:145, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "line_width_textinput", 6, {_x:260, _y:95, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "line_alpha_textinput", 7, {_x:260, _y:145, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "fill_alpha_textinput", 8, {_x:430, _y:120, _width:40, _height:20});

		mc_ref.attachMovie ("lib_button_mc", "apply_button", 9, {_x:230, _y:190});
		mc_ref.attachMovie ("lib_button_mc", "ok_button", 10, {_x:320, _y:190});
		mc_ref.attachMovie ("lib_button_mc", "cancel_button", 11, {_x:410, _y:190});
		
		mc_ref.attachMovie ("lib_normal_palette", "line_color_palette", 12, {_x:260, _y:120});
		mc_ref.attachMovie ("lib_normal_palette", "fill_color_palette", 13, {_x:430, _y:95});
		
		setup_component_style ();
		
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
		mc_ref.dimension_label.setStyle ("styleName", "label_style");
		mc_ref.width_label.setStyle ("styleName", "label_style");
		mc_ref.height_label.setStyle ("styleName", "label_style");
		mc_ref.rotation_label.setStyle ("styleName", "label_style");
		mc_ref.line_style_label.setStyle ("styleName", "label_style");
		mc_ref.line_width_label.setStyle ("styleName", "label_style");
		mc_ref.line_color_label.setStyle ("styleName", "label_style");
		mc_ref.line_alpha_label.setStyle ("styleName", "label_style");
		mc_ref.fill_style_label.setStyle ("styleName", "label_style");
		mc_ref.fill_color_label.setStyle ("styleName", "label_style");
		mc_ref.fill_alpha_label.setStyle ("styleName", "label_style");
		
		mc_ref.x_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.y_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.width_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.height_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.rotation_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.line_width_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.line_alpha_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.fill_alpha_textinput.setStyle ("styleName", "textinput_style");
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
		
		if (mc_ref.width_textinput.text == "")
		{
			mc_ref.width_textinput.text = "5";
		}
		
		if (mc_ref.height_textinput.text == "")
		{
			mc_ref.height_textinput.text = "5";
		}
		
		if (mc_ref.rotation_textinput.text == "")
		{
			mc_ref.rotation_textinput.text = "0";
		}
		
		if (mc_ref.line_width_textinput.text == "")
		{
			mc_ref.line_width_textinput.text = "0";
		}
		
		if (mc_ref.line_alpha_textinput.text == "")
		{
			mc_ref.line_alpha_textinput.text = "0";
		}
		
		if (mc_ref.fill_alpha_textinput.text == "")
		{
			mc_ref.fill_alpha_textinput.text = "0";
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
				
				item_node = item_xml.createElement ("OvalMC");
				
				temp_node = item_xml.createElement ("x");
				temp_node_2 = item_xml.createTextNode (this.class_ref.x_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("y");
				temp_node_2 = item_xml.createTextNode (this.class_ref.y_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("width");
				temp_node_2 = item_xml.createTextNode (this.class_ref.width_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("height");
				temp_node_2 = item_xml.createTextNode (this.class_ref.height_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("rotation");
				temp_node_2 = item_xml.createTextNode (this.class_ref.rotation_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				temp_node = item_xml.createElement ("line_style");
				temp_node_2 = item_xml.createTextNode (this.class_ref.line_width_textinput.text + "|" + this.class_ref.line_color_palette.get_color_string () + "|" + this.class_ref.line_alpha_textinput.text);
				temp_node.appendChild (temp_node_2);
				item_node.appendChild (temp_node);
				
				if (this.class_ref.fill_color_palette.get_color_num () != null)
				{
					temp_node = item_xml.createElement ("fill_color");
					temp_node_2 = item_xml.createTextNode (this.class_ref.fill_color_palette.get_color_string ());
					temp_node.appendChild (temp_node_2);
					item_node.appendChild (temp_node);
					
					temp_node = item_xml.createElement ("alpha");
					temp_node_2 = item_xml.createTextNode (this.class_ref.fill_alpha_textinput.text);
					temp_node.appendChild (temp_node_2);
					item_node.appendChild (temp_node);
				}
				
				this.class_ref.target_ref.set_data_xml (item_node);
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
