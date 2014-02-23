// ********************
// ColorPaletteMC class
// ********************
class as.global.ColorPaletteMC extends MovieClip
{
	// MC variables
	// MovieClip				current_mc
	// MovieClip				selection_mc
  
	// private variables
	private var mc_ref:MovieClip;	  				// interface for the normal palette
	
	private var color_array:Array;				// array to store the color range
  
	// ***********
	// constructor
	// ***********
	public function ColorPaletteMC ()
	{
		mc_ref = this;
		color_array = new Array (0, 51, 102, 153, 204, 255);
		
		build_selection_mc ();
		build_current_mc ();
		build_current_textinput ();
		
		mc_ref.selection_mc._visible = false;
		mc_ref.selection_mc.enabled = false;
		
		setup_current_mc ();
	}
	
	// ******************
	// build selection mc
	// ******************
	public function build_selection_mc ():Void
	{
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
					
					// onRelease override
					temp_mc ["class_ref"] = mc_ref;
					temp_mc.onRelease = function ()
					{
						this.gotoAndStop ("normal");
						
						this.class_ref.current_mc.set_color_num (this.get_color_num ());
						this.class_ref.current_textinput.text = this.get_color_code ();
						
						this.class_ref.selection_mc._visible = false;
						this.class_ref.selection_mc.enabled = false;
					}
				}
			}
		}
	}
	
	// ****************
	// build current mc
	// ****************
	public function build_current_mc ():Void
	{
		mc_ref.attachMovie ("lib_color_box_large", "current_mc", 1, {_x:1, _y:1});
	}
	
	// ***********************
	// build current textinput
	// ***********************
	public function build_current_textinput ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "current_textinput", 2, {_x:25, _y:0, _width:60, _height:20});
		mc_ref.current_textinput.setStyle ("styleName", "textinput_style");
		
		var temp_listener:Object;
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function ()
		{
			this.class_ref.current_mc.set_color_num (_root.sys_func.color_code_to_num (this.class_ref.current_textinput.text));
		}
		
		mc_ref.current_textinput.addEventListener ("change", temp_listener);
	}
	
	// ****************
	// setup current mc
	// ****************
	public function setup_current_mc ():Void
	{
		mc_ref.current_mc ["class_ref"] = mc_ref;
		mc_ref.current_mc.onPress = function ()
		{
			if (this.class_ref.selection_mc._visible == true)
			{
				this.class_ref.selection_mc._visible = false;
				this.class_ref.selection_mc.enabled = false;
			}
			else
			{
				this.class_ref.selection_mc._visible = true;
				this.class_ref.selection_mc.enabled = true;
			}
		}
	}
	
	// *************
	// set color num
	// *************
	public function set_color_num (n:Number):Void
	{
		mc_ref.current_mc.set_color_num (n);
		mc_ref.current_textinput.text = _root.sys_func.color_num_to_code (n);
	}
	
	// ****************
	// get color string
	// ****************
	public function get_color_string ():String
	{
		return (_root.sys_func.color_code_to_string (mc_ref.current_textinput.text));
	}
}
