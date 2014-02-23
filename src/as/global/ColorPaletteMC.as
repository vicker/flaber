// ********************
// ColorPaletteMC class
// ********************
class as.global.ColorPaletteMC extends MovieClip
{
	// MC variables
	// MovieClip				selection_mc
  
	// private variables
	private var mc_ref:MovieClip;	  				// interface for the normal palette
	private var panel_ref:MovieClip;				// reference to the edit panel
	private var panel_num:Number;					// specify edit panel want to do hook with what
	
	private var color_array:Array;				// array to store the color range
	
	private var lock_flag:Boolean;				// states that user is updating, dont allow changing
  
	// ***********
	// constructor
	// ***********
	public function ColorPaletteMC ()
	{
		mc_ref = this;
		panel_ref = null;
		color_array = new Array (0, 51, 102, 153, 204, 255);
		
		build_selection_mc ();
		build_current_mc ();
		
		close_selection_mc ();
	}
	
	// *****************
	// open selection mc
	// *****************
	public function open_selection_mc ():Void
	{
		lock_flag = true;
		
		mc_ref.selection_mc._visible = true;
		mc_ref.selection_mc.enabled = true;
		
		mc_ref.selection_mc.color_input_box.set_color_num (mc_ref.current_mc.get_color_num ());
	}
	
	// ******************
	// close selection mc
	// ******************
	public function close_selection_mc ():Void
	{
		lock_flag = false;
		
		mc_ref.selection_mc._visible = false;
		mc_ref.selection_mc.enabled = false;
		
		if (panel_ref != null)
		{
			panel_ref.palette_call (panel_num);
		}
	}
	
	// ******************
	// build selection mc
	// ******************
	public function build_selection_mc ():Void
	{
		// selection bg
		var temp_xml:XML;
		
		temp_xml = new XML ("<RectangleMC><x>-10</x><y>-10</y><width>220</width><height>180</height><corner>0</corner><line_style>1|0x666666|100</line_style><fill_color>0xFFFFFF</fill_color><alpha>100</alpha></RectangleMC>");
		
		mc_ref.selection_mc.attachMovie ("lib_shape_rectangle", "selection_bg", -5);
		mc_ref.selection_mc.selection_bg.set_data_xml (temp_xml.firstChild);
		
		// selection palette
		var temp_length:Number;
		
		temp_length = color_array.length;
		
		for (var loop_num = 0; loop_num < temp_length; loop_num++)
		{
			for (var loop_num_2 = 0; loop_num_2 < temp_length; loop_num_2++)
			{
				for (var loop_num_3 = 0; loop_num_3 < temp_length; loop_num_3++)
				{
					var temp_mc:MovieClip;
					var temp_name:String;
					var temp_depth:Number;
					var temp_x:Number;
					var temp_y:Number;
					var temp_width:Number;
					var temp_height:Number;
					
					temp_name = "color_box_" + loop_num + "_" + loop_num_2 + "_" + loop_num_3;
					temp_width = 11; // is funny that when get by _width is 1 px larger, so hard code here
					temp_height = 11;
					
					// finding the depth, x and y pos
					if (loop_num_2 * temp_length + loop_num_3 < Math.pow (temp_length, 2) / 2)
					{
						// first row
						temp_x = (loop_num_2 * temp_length + loop_num_3) * temp_width;
						temp_y = loop_num * temp_height;
						temp_depth = loop_num * Math.pow (temp_length, 2) + loop_num_2 * temp_length + loop_num_3;
					}
					else
					{
						// second row
						temp_x = ((loop_num_2 * temp_length + loop_num_3) - Math.pow (temp_length, 2) / 2) * temp_width;
						temp_y = (loop_num + temp_length) * temp_height;
						temp_depth = loop_num * Math.pow (temp_length, 2) + loop_num_2 * temp_length + loop_num_3 + Math.pow (temp_length, 3);
					}
					
					temp_mc = mc_ref.selection_mc.attachMovie("lib_color_box", temp_name, temp_depth);
					temp_mc._x = temp_x;
					temp_mc._y = temp_y;
					temp_mc.set_color_rgb (color_array [loop_num_2], color_array [loop_num_3], color_array [loop_num]);
					temp_mc.set_palette_mc (this);
					
					// onRollOver override
					temp_mc ["class_ref"] = mc_ref;
					
					temp_mc.onRollOver = function ()
					{
						this.class_ref.selection_mc.color_input_box.set_color_num (this.get_color_num ());
						this.class_ref.selection_mc.color_input_textinput.text = this.get_color_code ();
					}
					
					// onRelease override
					temp_mc.onRelease = function ()
					{
						this.class_ref.set_color_num (this.get_color_num ());
						this.class_ref.close_selection_mc ();
					}
				}
			}
		}
		
		// selection input
		mc_ref.selection_mc.attachMovie ("lib_color_box_large", "color_input_box", -3, {_x:85, _y:140});
		mc_ref.selection_mc.createClassObject (mx.controls.TextInput, "color_input_textinput", -2, {_x:110, _y:140, _width:60, _height:20});
		mc_ref.selection_mc.createClassObject (mx.controls.Button, "color_input_button", -1, {_x:180, _y:140, _width:20, _height:20});
		
		mc_ref.selection_mc.color_input_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.selection_mc.color_input_button.icon = "lib_button_tick";
		
		// setup color input textinput listener
		var temp_listener:Object;
		
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.change = function ()
		{
			this.class_ref.selection_mc.color_input_box.set_color_num (_root.sys_func.color_code_to_num (this.class_ref.selection_mc.color_input_textinput.text));
		}
		
		mc_ref.selection_mc.color_input_textinput.addEventListener ("change", temp_listener);
		
		// setup color input button action
		mc_ref.selection_mc.color_input_button ["class_ref"] = mc_ref;
		mc_ref.selection_mc.color_input_button.onRelease = function ()
		{
			this.class_ref.current_mc.set_color_num (this.class_ref.selection_mc.color_input_box.get_color_num ());
			this.class_ref.close_selection_mc ();
		}
	}
	
	// ****************
	// build current mc
	// ****************
	public function build_current_mc ():Void
	{
		mc_ref.attachMovie ("lib_color_box_large_arrow", "current_mc", 1, {_x:1, _y:1});
		
		mc_ref.current_mc ["class_ref"] = mc_ref;
		mc_ref.current_mc.onRelease = function ()
		{
			if (this.class_ref.selection_mc._visible == true)
			{
				this.class_ref.close_selection_mc ();
			}
			else
			{
				this.class_ref.open_selection_mc ();
			}
		}
	}
		
	// *************
	// set color num
	// *************
	public function set_color_num (n:Number):Void
	{
		mc_ref.current_mc.set_color_num (n);
	}
	
	// ****************
	// get color string
	// ****************
	public function get_color_string ():String
	{
		return (_root.sys_func.color_code_to_string (mc_ref.current_mc.get_color_code ()));
	}
	
	// *************
	// get lock flag
	// *************
	public function get_lock_flag ():Boolean
	{
		return (lock_flag);
	}
	
	// *************
	// set panel ref
	// *************
	// only used for textfield edit panel which requires dynamic update
	public function set_panel_ref (m:MovieClip, n:Number):Void
	{
		panel_ref = m;
		panel_num = n;
	}
}
