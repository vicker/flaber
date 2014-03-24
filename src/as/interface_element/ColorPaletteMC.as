// ********************
// ColorPaletteMC class
// ********************
class as.interface_element.ColorPaletteMC extends MovieClip
{
	// MC variables
	// MovieClip				selection_mc
  
	// private variables
	private var mc_ref:MovieClip;	  				// interface for the normal palette
	private var panel_ref:MovieClip;				// reference to the color box with arrow
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
		
		color_array = new Array (	0x000000, 0x333333, 0x666666, 0x999999, 0xCCCCCC, 0xFFFFFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF, 0xFF00FF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, null,
											0x000000, 0x003300, 0x006600, 0x009900, 0x00CC00, 0x00FF00, 0x330000, 0x333300, 0x336600, 0x339900, 0x33CC00, 0x33FF00, 0x660000, 0x663300, 0x666600, 0x669900, 0x66CC00, 0x66FF00,
											0x000033, 0x003333, 0x006633, 0x009933, 0x00CC33, 0x00FF33, 0x330033, 0x333333, 0x336633, 0x339933, 0x33CC33, 0x33FF33, 0x660033, 0x663333, 0x666633, 0x669933, 0x66CC33, 0x66FF33,
											0x000066, 0x003366, 0x006666, 0x009966, 0x00CC66, 0x00FF66, 0x330066, 0x333366, 0x336666, 0x339966, 0x33CC66, 0x33FF66, 0x660066, 0x663366, 0x666666, 0x669966, 0x66CC66, 0x66FF66,
											0x000099, 0x003399, 0x006699, 0x009999, 0x00CC99, 0x00FF99, 0x330099, 0x333399, 0x336699, 0x339999, 0x33CC99, 0x33FF99, 0x660099, 0x663399, 0x666699, 0x669999, 0x66CC99, 0x66FF99,
											0x0000CC, 0x0033CC, 0x0066CC, 0x0099CC, 0x00CCCC, 0x00FFCC, 0x3300CC, 0x3333CC, 0x3366CC, 0x3399CC, 0x33CCCC, 0x33FFCC, 0x6600CC, 0x6633CC, 0x6666CC, 0x6699CC, 0x66CCCC, 0x66FFCC,
											0x0000FF, 0x0033FF, 0x0066FF, 0x0099FF, 0x00CCFF, 0x00FFFF, 0x3300FF, 0x3333FF, 0x3366FF, 0x3399FF, 0x33CCFF, 0x33FFFF, 0x6600FF, 0x6633FF, 0x6666FF, 0x6699FF, 0x66CCFF, 0x66FFFF,
											0x990000, 0x993300, 0x996600, 0x999900, 0x99CC00, 0x99FF00, 0xCC0000, 0xCC3300, 0xCC6600, 0xCC9900, 0xCCCC00, 0xCCFF00, 0xFF0000, 0xFF3300, 0xFF6600, 0xFF9900, 0xFFCC00, 0xFFFF00,
											0x990033, 0x993333, 0x996633, 0x999933, 0x99CC33, 0x99FF33, 0xCC0033, 0xCC3333, 0xCC6633, 0xCC9933, 0xCCCC33, 0xCCFF33, 0xFF0033, 0xFF3333, 0xFF6633, 0xFF9933, 0xFFCC33, 0xFFFF33,
											0x990066, 0x993366, 0x996666, 0x999966, 0x99CC66, 0x99FF66, 0xCC0066, 0xCC3366, 0xCC6666, 0xCC9966, 0xCCCC66, 0xCCFF66, 0xFF0066, 0xFF3366, 0xFF6666, 0xFF9966, 0xFFCC66, 0xFFFF66,
											0x990099, 0x993399, 0x996699, 0x999999, 0x99CC99, 0x99FF99, 0xCC0099, 0xCC3399, 0xCC6699, 0xCC9999, 0xCCCC99, 0xCCFF99, 0xFF0099, 0xFF3399, 0xFF6699, 0xFF9999, 0xFFCC99, 0xFFFF99,
											0x9900CC, 0x9933CC, 0x9966CC, 0x9999CC, 0x99CCCC, 0x99FFCC, 0xCC00CC, 0xCC33CC, 0xCC66CC, 0xCC99CC, 0xCCCCCC, 0xCCFFCC, 0xFF00CC, 0xFF33CC, 0xFF66CC, 0xFF99CC, 0xFFCCCC, 0xFFFFCC,
											0x9900FF, 0x9933FF, 0x9966FF, 0x9999FF, 0x99CCFF, 0x99FFFF, 0xCC00FF, 0xCC33FF, 0xCC66FF, 0xCC99FF, 0xCCCCFF, 0xCCFFFF, 0xFF00FF, 0xFF33FF, 0xFF66FF, 0xFF99FF, 0xFFCCFF, 0xFFFFFF);
		
		build_selection_mc ();
		build_current_mc ();
		
		close_selection_mc ();
	}
	
	// *****************
	// open selection mc
	// *****************
	private function open_selection_mc ():Void
	{
		lock_flag = true;
		
		mc_ref.selection_mc._visible = true;
		mc_ref.selection_mc.enabled = true;
		
		mc_ref.selection_mc.color_input_box.set_color_num (mc_ref.current_mc.get_color_num ());
		mc_ref.selection_mc.color_input_textinput.text = mc_ref.current_mc.get_color_code ();
	}
	
	// ******************
	// close selection mc
	// ******************
	private function close_selection_mc ():Void
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
	private function build_selection_mc ():Void
	{
		// selection bg
		mc_ref.selection_mc.attachMovie ("lib_frame_mc", "selection_bg", -5);
		mc_ref.selection_mc.selection_bg.clear_frame ();
		mc_ref.selection_mc.selection_bg.draw_rect (-10, -10, 215, 195, 1, 0x666666, 100, 0xFFFFFF, 100);
		
		// selection palette
		
		var temp_length:Number;
		var temp_row:Number = 0;
		var temp_col:Number = 0;
		
		temp_length = color_array.length;
		
		for (var i = 0; i < temp_length; i++)
		{
			var temp_mc:MovieClip;
			var temp_name:String = "";
			var temp_x:Number = 0;
			var temp_y:Number = 0;
			
			temp_name = "color_box_" + i;
			temp_x = temp_col * 11;
			temp_y = 30 + temp_row * 11;
			
			temp_mc = mc_ref.selection_mc.attachMovie("lib_color_box", temp_name, i, {_x: temp_x, _y: temp_y});
			temp_mc.set_color_num (color_array [i]);
								
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
			
			// increment next
			temp_col++;
			
			if (temp_col % 18 == 0)
			{
				temp_row++;
				temp_col = 0;
			}
		}
		
		// selection input
		mc_ref.selection_mc.attachMovie ("lib_color_box_large", "color_input_box", -3, {_x:0, _y:0});
		mc_ref.selection_mc.createClassObject (mx.controls.TextInput, "color_input_textinput", -2, {_x:30, _y:0, _width:60, _height:20});
		mc_ref.selection_mc.attachMovie ("lib_button_mc", "color_input_button", -1, {_x:100, _y:0});
		
		mc_ref.selection_mc.color_input_textinput.setStyle ("styleName", "textinput_style");
		
		setup_color_input_textinput ();
		setup_color_input_button ();
	}
	
	// ***************************
	// setup color input textinput
	// ***************************
	private function setup_color_input_textinput ():Void
	{
		var temp_listener:Object = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		
		temp_listener.change = function ()
		{
			this.class_ref.selection_mc.color_input_box.set_color_num (_root.sys_func.color_code_to_num (this.class_ref.selection_mc.color_input_textinput.text));
		}
		
		mc_ref.selection_mc.color_input_textinput.addEventListener ("change", temp_listener);		
	}
	
	// ************************
	// setup color input button
	// ************************
	private function setup_color_input_button ():Void
	{
		mc_ref.selection_mc.color_input_button.set_toggle_flag (false);
		mc_ref.selection_mc.color_input_button.set_dimension (20, 20);
		mc_ref.selection_mc.color_input_button.set_clip_mc ("lib_button_tick");
		mc_ref.selection_mc.color_input_button.set_tooltip ("Accept");
		
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
	private function build_current_mc ():Void
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
	
	// *************
	// get color num
	// *************
	public function get_color_num ():Number
	{
		return (mc_ref.current_mc.get_color_num ());
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
