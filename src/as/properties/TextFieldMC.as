// *****************
// TextFieldMC class
// *****************
class as.properties.TextFieldMC extends MovieClip
{
	// private variables
	private var sel_start:Number;
	private var sel_end:Number;
	private var sel_flag:Boolean;
	
	private var handling_flag:Boolean;
	
	private var mc_ref:MovieClip;					// reference to the movie clip
	private var target_ref:MovieClip;			// reference to the target
	
	// ***********
	// constructor
	// ***********
	public function TextFieldMC ()
	{
		mc_ref = this;
		
		handling_flag = false;
		
		setup_component_object ();
		setup_mouse_focus ();
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
		
		// dimension
		mc_ref.width_textinput.text = target_ref.content_field._width;
		mc_ref.height_textinput.text = target_ref.content_field._height;
		
		// content
		mc_ref.content_textarea.text = target_ref.content_field.htmlText;
		
		// scroll bar
		mc_ref.scroll_button.set_toggle_state (target_ref.get_scroll_flag ());
	}
		
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "x_textinput", 1, {_x:40, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "y_textinput", 2, {_x:120, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "width_textinput", 3, {_x:250, _y:35, _width:40, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "height_textinput", 4, {_x:350, _y:35, _width:40, _height:20});
		
		mc_ref.createClassObject (mx.controls.TextArea, "content_textarea", 5, {_x:20, _y:160, _width:370, _height:200});
		
		mc_ref.attachMovie ("lib_button_mc", "bold_button", 6, {_x:20, _y:100});
		mc_ref.attachMovie ("lib_button_mc", "italic_button", 7, {_x:50, _y:100});
		mc_ref.attachMovie ("lib_button_mc", "underline_button", 8, {_x:80, _y:100});
		
		mc_ref.attachMovie ("lib_button_mc", "left_button", 9, {_x:130, _y:100});
		mc_ref.attachMovie ("lib_button_mc", "center_button", 10, {_x:160, _y:100});
		mc_ref.attachMovie ("lib_button_mc", "right_button", 11, {_x:190, _y:100});
		
		mc_ref.attachMovie ("lib_button_mc", "bullet_button", 12, {_x:230, _y:100});
		mc_ref.attachMovie ("lib_button_mc", "scroll_button", 13, {_x:260, _y:100});
		
		mc_ref.createClassObject (as.component.ComboBoxExtend, "font_combobox", 14, {_x:20, _y:130, _width:120, _height:20});
		mc_ref.createClassObject (as.component.ComboBoxExtend, "font_size_combobox", 15, {_x:160, _y:130, _width:50, _height:20});
		
		mc_ref.attachMovie ("lib_normal_palette", "font_color_palette", 16, {_x:230, _y:130});
		mc_ref.attachMovie ("lib_link_panel", "font_link_panel", 17, {_x:300, _y:100});
		mc_ref.attachMovie ("lib_normal_palette", "bg_color_palette", 18, {_x:100, _y:370});

		mc_ref.attachMovie ("lib_button_mc", "apply_button", 19, {_x:130, _y:400});
		mc_ref.attachMovie ("lib_button_mc", "ok_button", 20, {_x:220, _y:400});
		mc_ref.attachMovie ("lib_button_mc", "cancel_button", 21, {_x:310, _y:400});
		
		setup_component_style ();
		
		setup_content_textarea ();
		setup_bold_button ();
		setup_italic_button ();
		setup_underline_button ();
		setup_left_button ();
		setup_center_button ();
		setup_right_button ();
		setup_bullet_button ();
		setup_scroll_button ();
		setup_font_combobox ();
		setup_font_size_combobox ();
		setup_cancel_button ();
		setup_apply_button ();
		setup_ok_button ();
		
		mc_ref.font_color_palette.set_panel_ref (mc_ref, 1);
		mc_ref.font_link_panel.set_panel_ref (mc_ref);
		mc_ref.bg_color_palette.set_panel_ref (mc_ref, 2);
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
		mc_ref.content_label.setStyle ("styleName", "label_style");
		mc_ref.textarea_bg_label.setStyle ("styleName", "label_style");
		
		mc_ref.x_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.y_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.width_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.height_textinput.setStyle ("styleName", "textinput_style");
		
		mc_ref.font_combobox.setStyle ("styleName", "combobox_style");
		mc_ref.font_size_combobox.setStyle ("styleName", "combobox_style");
	}
	
	// *****************
	// change textformat
	// *****************
	public function change_textformat (param:String, val:Object):Void
	{
		var temp_format:TextFormat;
		
		temp_format = new TextFormat ();
		temp_format = mc_ref.content_textarea.label.getTextFormat (sel_start, sel_end);
		
		switch (param)
		{
			// bold
			case "bold":
			{
				temp_format.bold = !temp_format.bold;
				break;
			}
			// italic
			case "italic":
			{
				temp_format.italic = !temp_format.italic;
				break;
			}
			// underline
			case "underline":
			{
				temp_format.underline = !temp_format.underline;
				break;
			}
			// align
			case "align":
			{
				temp_format.align = val.toString ();
				break;
			}
			// bullet
			case "bullet":
			{
				temp_format.bullet = !temp_format.bullet;
				break;
			}
			// color
			case "color":
			{
				temp_format.color = new Number (val);
				break;
			}
			// font
			case "font":
			{
				temp_format.font = val.toString ();
				break;
			}
			// size
			case "size":
			{
				temp_format.size = new Number (val);
				break;
			}
			// url
			case "url":
			{
				temp_format.url = val.toString ();
				
				if (val != "")
				{
					temp_format.underline = true;
					temp_format.target = "_blank";
				}
				else
				{
					temp_format.underline = false;
					temp_format.target = "";
				}
				
				break;
			}
		}
		
		mc_ref.content_textarea.label.setTextFormat (sel_start, sel_end, temp_format);
		
	}
	
	// *****************
	// setup bold button
	// *****************
	public function setup_bold_button ():Void
	{
		mc_ref.bold_button.set_toggle_flag (true);
		mc_ref.bold_button.set_dimension (20, 20);
		mc_ref.bold_button.set_clip_mc ("lib_button_bold");
		mc_ref.bold_button.set_tooltip ("Bold");
		
		mc_ref.bold_button ["class_ref"] = mc_ref;
		mc_ref.bold_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.set_toggle_state (null);
				this.class_ref.change_textformat ("bold", null);
			}
		}
	}
	
	// *******************
	// setup italic button
	// *******************
	public function setup_italic_button ():Void
	{
		mc_ref.italic_button.set_toggle_flag (true);
		mc_ref.italic_button.set_dimension (20, 20);
		mc_ref.italic_button.set_clip_mc ("lib_button_italic");
		mc_ref.italic_button.set_tooltip ("Italic");
		
		mc_ref.italic_button ["class_ref"] = mc_ref;
		mc_ref.italic_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.set_toggle_state (null);
				this.class_ref.change_textformat ("italic", null);
			}
		}
	}
	
	// **********************
	// setup underline button
	// **********************
	public function setup_underline_button ():Void
	{
		mc_ref.underline_button.set_toggle_flag (true);
		mc_ref.underline_button.set_dimension (20, 20);
		mc_ref.underline_button.set_clip_mc ("lib_button_underline");
		mc_ref.underline_button.set_tooltip ("Underline");
		
		mc_ref.underline_button ["class_ref"] = mc_ref;
		mc_ref.underline_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.set_toggle_state (null);
				this.class_ref.change_textformat ("underline", null);
			}
		}
	}
	
	// ******************
	// reset align button
	// ******************
	public function reset_align_button ():Void
	{
		mc_ref.left_button.set_toggle_state (false);
		mc_ref.center_button.set_toggle_state (false);
		mc_ref.right_button.set_toggle_state (false);
	}
	
	// *****************
	// setup left button
	// *****************
	public function setup_left_button ():Void
	{
		mc_ref.left_button.set_toggle_flag (true);
		mc_ref.left_button.set_dimension (20, 20);
		mc_ref.left_button.set_clip_mc ("lib_button_left");
		mc_ref.left_button.set_tooltip ("Left Alignment");
		
		mc_ref.left_button ["class_ref"] = mc_ref;
		mc_ref.left_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.class_ref.reset_align_button ();
				this.set_toggle_state (true);
				this.class_ref.change_textformat ("align", "left");
			}
		}
	}
	
	// *******************
	// setup center button
	// *******************
	public function setup_center_button ():Void
	{
		mc_ref.center_button.set_toggle_flag (true);
		mc_ref.center_button.set_dimension (20, 20);
		mc_ref.center_button.set_clip_mc ("lib_button_center");
		mc_ref.center_button.set_tooltip ("Center Alignment");
		
		mc_ref.center_button ["class_ref"] = mc_ref;
		mc_ref.center_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.class_ref.reset_align_button ();
				this.set_toggle_state (true);
				this.class_ref.change_textformat ("align", "center");
			}
		}
	}
	
	// ******************
	// setup right button
	// ******************
	public function setup_right_button ():Void
	{
		mc_ref.right_button.set_toggle_flag (true);
		mc_ref.right_button.set_dimension (20, 20);
		mc_ref.right_button.set_clip_mc ("lib_button_right");
		mc_ref.right_button.set_tooltip ("Right Alignment");
		
		mc_ref.right_button ["class_ref"] = mc_ref;
		mc_ref.right_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.class_ref.reset_align_button ();
				this.set_toggle_state (true);
				this.class_ref.change_textformat ("align", "right");
			}
		}
	}

	// *******************
	// setup bullet button
	// *******************
	public function setup_bullet_button ():Void
	{
		mc_ref.bullet_button.set_toggle_flag (true);
		mc_ref.bullet_button.set_dimension (20, 20);
		mc_ref.bullet_button.set_clip_mc ("lib_button_bullet");
		mc_ref.bullet_button.set_tooltip ("Bulleted List");
		
		mc_ref.bullet_button ["class_ref"] = mc_ref;
		mc_ref.bullet_button.onRelease = function ()
		{
			if (this.class_ref.sel_flag == true)
			{
				this.set_toggle_state (null);
				this.class_ref.change_textformat ("bullet", null);
			}
		}
	}

	// *******************
	// setup scroll button
	// *******************
	public function setup_scroll_button ():Void
	{
		mc_ref.scroll_button.set_toggle_flag (true);
		mc_ref.scroll_button.set_dimension (20, 20);
		mc_ref.scroll_button.set_clip_mc ("lib_button_scroll");
		mc_ref.scroll_button.set_tooltip ("Text Scroller");
		
		mc_ref.scroll_button.onRelease = function ()
		{
			this.set_toggle_state (null);
		}
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
		
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function ()
		{
			if (this.class_ref.handling_flag == false)
			{
				this.class_ref.handling_flag = true;
				
				if (this.class_ref.sel_flag == true)
				{
					this.class_ref.change_textformat ("font", this.class_ref.font_combobox.value);
				}
				
				this.class_ref.handling_flag = false;
			}
			
			break;
		}
		
		mc_ref.font_combobox.addEventListener ("change", temp_listener);
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
		
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function ()
		{
			if (this.class_ref.handling_flag == false)
			{
				this.class_ref.handling_flag = true;
				
				if (this.class_ref.sel_flag == true)
				{
					this.class_ref.change_textformat ("size", this.class_ref.font_size_combobox.value);
				}
				
				this.class_ref.handling_flag = false;
			}
		}
		
		mc_ref.font_size_combobox.addEventListener ("change", temp_listener);
	}
		
	// **********************
	// setup content textarea
	// **********************
	public function setup_content_textarea ():Void
	{
		mc_ref.content_textarea.html = true;
		mc_ref.content_textarea.wordWrap = true;
	}
	
	// ************
	// palette call
	// ************
	// this function is called by the color palette when the color is set
	public function palette_call (n:Number):Void
	{
		switch (n)
		{
			// hook with the textarea content
			case 1:
			{
				if (sel_flag == true)
				{
					change_textformat ("color", mc_ref.font_color_palette.get_color_string ());
				}
				break;
			}
			
			// hook with the textarea background
			case 2:
			{
				var temp_string:String = mc_ref.bg_color_palette.get_color_string ();
				
				if (temp_string == null)
				{
					temp_string = "0xFFFFFF";
				}
				
				mc_ref.content_textarea.setStyle ("backgroundColor", temp_string);
				break;
			}
		}
	}
	
	// *********
	// link call
	// *********
	// this function is called by the link panel when the link is set
	public function link_call ():Void
	{
		if (sel_flag == true)
		{
			change_textformat ("url", mc_ref.font_link_panel.get_link_url ());
		}
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
			mc_ref.width_textinput.text = "0";
		}
		
		if (mc_ref.height_textinput.text == "")
		{
			mc_ref.height_textinput.text = "0";
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
				
				item_node = item_xml.createElement ("TextFieldMC");
				
				item_node.attributes.scroll_bar = this.class_ref.scroll_button.get_toggle_state ().toString ();
				
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
				
				// content of textfield
				var temp_xml:XML;
				temp_xml = new XML ("<dummy>" + this.class_ref.content_textarea.label.htmlText + "</dummy>");
				
				temp_node = item_xml.createElement ("text");
				
				var temp_length:Number;
				temp_length = temp_xml.firstChild.childNodes.length;
				
				for (var i = 0; i < temp_length; i++)
				{
					// using clone to prevent node removal
					temp_node_2 = temp_xml.firstChild.childNodes [i].cloneNode (true);
					temp_node.appendChild (temp_node_2);
				}
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
	
	// ***********************
	// update component status
	// ***********************
	public function update_component_status ():Void
	{
		var temp_format:TextFormat;
		
		temp_format = mc_ref.content_textarea.label.getTextFormat (sel_start, sel_end);
		
		// bold
		mc_ref.bold_button.set_toggle_state (temp_format.bold || false);
		
		// italic
		mc_ref.italic_button.set_toggle_state (temp_format.italic || false);
		
		// underline
		mc_ref.underline_button.set_toggle_state (temp_format.underline || false);
		
		// align
		reset_align_button ();
		mc_ref [temp_format.align + "_button"].set_toggle_state (true);
		
		// bullet
		mc_ref.bullet_button.set_toggle_state (temp_format.bullet || false);
		
		// font
		mc_ref.font_combobox.select_item (temp_format.font);
		
		// size
		mc_ref.font_size_combobox.select_item (temp_format.size);
		
		// color
		if (mc_ref.font_color_palette.get_lock_flag () == false && temp_format.color != null)
		{
			mc_ref.font_color_palette.set_color_num (temp_format.color);
		}
		
		// url
		if (mc_ref.font_link_panel.get_lock_flag () == false)
		{
			if (temp_format.url != null)
			{
				mc_ref.font_link_panel.set_link_url (temp_format.url);
			}
			else
			{
				mc_ref.font_link_panel.set_link_url ("");
			}
		}
	}
	
	// **************
	// focus interval
	// **************
	public function focus_interval ():Void
	{
		// if current focus is on content textarea
		if (Selection.getFocus ().indexOf ("content_textarea") > 0)
		{
			// if it is a selection, update the selection indexes
			if (Selection.getBeginIndex () != Selection.getEndIndex ())
			{
				sel_flag = true;
				sel_start = Selection.getBeginIndex ();
				sel_end = Selection.getEndIndex ();
			}
			else
			{
				sel_flag = false;
			}
			update_component_status ();
		}
	}
	
	// *****************
	// setup mouse focus
	// *****************
	public function setup_mouse_focus ():Void
	{
		// always check the latest focus
		mc_ref.onMouseMove = function ()
		{
			focus_interval ();
		}
		//setInterval (mc_ref, "focus_interval", 500);
		
		var set_focus:Object;
		
		set_focus = new Object ();
		set_focus ["class_ref"] = mc_ref;
		
		// when the focus is changed, set the selection back to content textarea
		// this one works for all the button clicks which will loss textarea focus
		set_focus.onSetFocus = function (o, n)
		{
			if (this.class_ref.sel_flag == true)
			{
				Selection.setSelection (this.class_ref.sel_start, this.class_ref.sel_end);
			}
		}
		Selection.addListener (set_focus);
	}
}
