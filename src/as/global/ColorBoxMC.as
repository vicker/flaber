// ****************
// ColorBoxMC class
// ****************
class as.global.ColorBoxMC extends MovieClip
{
	// MC variables
	// MovieClip			color_box_content
	
	// private variables
	private var color_code:Number;						// color code of the mc
	private var mc_color:Color;							// color obj of the mc
	
	private var mc_ref:MovieClip;							// interface for the color box
  
	// ***********
	// constructor
	// ***********
	public function ColorBoxMC ()
	{
		mc_ref = this;
		mc_color = new Color (mc_ref.color_box_content);
		color_code = 0;
	}

	// *******************
	// onrollover override
	// *******************
	public function onRollOver ()
	{
		mc_ref.gotoAndStop ("over");
	}
	
	// ******************
	// onrollout override
	// ******************
	public function onRollOut ()
	{
		mc_ref.gotoAndStop ("normal");
	}

	// *************************
	// onreleaseoutside override
	// *************************
	public function onReleaseOutside ()
	{
		mc_ref.onRollOut ();
	}
	
	// *************
	// set color rgb
	// *************
	public function set_color_rgb (r:Number, g:Number, b:Number):Void 
	{
		color_code = (r << 16) | (g << 8) | (b);
		mc_color.setRGB (color_code);
	}

	// *************
	// set color num
	// *************
	public function set_color_num (n:Number):Void
	{
		color_code = n;
		mc_color.setRGB (color_code);
	}

	// **************
	// get color code
	// **************
	public function get_color_code ():String	   
	{
		var temp_string:String;
		
		temp_string = color_code.toString (16).toUpperCase ();
		
		while (temp_string.length != 6)
		{
			temp_string = "0" + temp_string;
		}
		temp_string = "#" + temp_string;
		
		return temp_string; 
	}
	
	// *************
	// get color num
	// *************
	public function get_color_num ():Number
	{
		return color_code;
	}
}
