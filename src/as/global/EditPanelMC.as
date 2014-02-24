// *****************
// EditPanelMC class
// *****************
class as.global.EditPanelMC extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;						// interface for the edit panel mc
	private var target_ref:MovieClip;				// reference to the controlling mc
	
	// ***********
	// constructor
	// ***********
	public function EditPanelMC ()
	{
		mc_ref = this;
		
		draw_frame ();
		
		setup_move_button ();
		setup_resize_button ();
		setup_rotate_button ();
		setup_properties_button ();
		setup_delete_button ();
		setup_close_button ();
		
		throw_away ();
	}
	
	// **********
	// draw frame
	// **********
	public function draw_frame ():Void
	{
		var frame_width:Number;
		
		frame_width = 120;
		
		// clear all frame first
		mc_ref.frame_mc.clear ();
		
		// draw the outer border
		mc_ref.frame_mc.lineStyle (1, 0x666666, 100);
		mc_ref.frame_mc.beginFill (0xFFFFFF, 100);
		mc_ref.frame_mc.moveTo (0, 0);
		mc_ref.frame_mc.lineTo (frame_width, 0);
		mc_ref.frame_mc.lineTo (frame_width, 48);
		mc_ref.frame_mc.lineTo (0, 48);
		mc_ref.frame_mc.lineTo (0, 0);
		mc_ref.frame_mc.endFill ();
		
		// draw the shadow
		mc_ref.frame_mc.lineStyle (0, 0x000000, 0);
		mc_ref.frame_mc.beginFill (0x000000, 30);
		mc_ref.frame_mc.moveTo (frame_width, 10);
		mc_ref.frame_mc.lineTo (frame_width + 3, 10);
		mc_ref.frame_mc.lineTo (frame_width + 3, 48 + 3);
		mc_ref.frame_mc.lineTo (0 + 10, 48 + 3);
		mc_ref.frame_mc.lineTo (0 + 10, 48);
		mc_ref.frame_mc.lineTo (frame_width, 48);
		mc_ref.frame_mc.lineTo (frame_width, 10);
		mc_ref.frame_mc.endFill ();
		
		// draw text underline
		mc_ref.frame_mc.lineStyle (1, 0xCCCCCC, 100);
		mc_ref.frame_mc.moveTo (5, 23);
		mc_ref.frame_mc.lineTo (115, 23);
	}
	
	// **************
	// set target ref
	// **************
	public function set_target_ref (m:MovieClip):Void
	{
		target_ref = m;
		
		mc_ref.content_field.text = m._name;
	}

	// ************
	// set position
	// ************
	public function set_position (x:Number, y:Number):Void
	{
		// fix position if out bound
		if (x < 0)	{ x = 0; }
		if (y < 0)	{ y = 0; }
		if (x + mc_ref._width > Stage.width)		{ x = Stage.width - mc_ref._width; }
		if (y + mc_ref._height > Stage.height)		{ y = Stage.height - mc_ref._height; }
		
		x = x + 5;
		y = y - 5;
		
		mc_ref._x = x;
		mc_ref._y = y;
		
		// show the edit panel
		mc_ref._visible = true;
		mc_ref.enabled = false;
	}

	// ************
	// set function
	// ************
	public function set_function (m:Boolean, z:Boolean, r:Boolean, p:Boolean, d:Boolean):Void
	{
		if (m == true)
		{
			mc_ref.move_button.enabled = true;
			mc_ref.move_button._alpha = 100;
		}
		else
		{
			mc_ref.move_button.enabled = false;
			mc_ref.move_button._alpha = 25;
		}
		
		if (z == true)
		{
			mc_ref.resize_button.enabled = true;
			mc_ref.resize_button._alpha = 100;
		}
		else
		{
			mc_ref.resize_button.enabled = false;
			mc_ref.resize_button._alpha = 25;
		}
		
		if (r == true)
		{
			mc_ref.rotate_button.enabled = true;
			mc_ref.rotate_button._alpha = 100;
		}
		else
		{
			mc_ref.rotate_button.enabled = false;
			mc_ref.rotate_button._alpha = 25;
		}
		
		if (p == true)
		{
			mc_ref.properties_button.enabled = true;
			mc_ref.properties_button._alpha = 100;
		}
		else
		{
			mc_ref.properties_button.enabled = false;
			mc_ref.properties_button._alpha = 25;
		}
		
		if (d == true)
		{
			mc_ref.delete_button.enabled = true;
			mc_ref.delete_button._alpha = 100;
		}
		else
		{
			mc_ref.delete_button.enabled = false;
			mc_ref.delete_button._alpha = 25;
		}
	}

	// **********
	// throw away
	// **********
	public function throw_away ():Void
	{
		mc_ref._x = 0;
		mc_ref._y = -30;
		
		mc_ref._visible = false;
		mc_ref.enabled = false;
	}
	
	// *****************
	// setup move button
	// *****************
	public function setup_move_button ():Void
	{
		mc_ref.move_button ["class_ref"] = mc_ref;
		
		// onrollover override
		mc_ref.move_button.onRollOver = function ()
		{
			_root.tooltip_mc.set_content ("Move");
			_root.status_mc.add_message ("Click and drag to move the object" , "tooltip");
		}
		
		// onrollout override
		mc_ref.move_button.onRollOut = function ()
		{
			_root.tooltip_mc.throw_away ();
		}
		
		// onpress override
		mc_ref.move_button.onPress = function ()
		{
			_root.tooltip_mc.throw_away ();
			this.class_ref.target_ref.startDrag ();
			
			this.class_ref.onMouseMove = function ()
			{
				target_ref.pull_edit_panel ();
			}
		}
		
		// onrelease override
		mc_ref.move_button.onRelease = function ()
		{
			this.class_ref.target_ref.stopDrag ();
			_root.tooltip_mc.startDrag (true);
			
			delete this.class_ref.onMouseMove;
		}
		
		// onreleaseoutside override
		mc_ref.move_button.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}
	
	// *******************
	// setup resize button
	// *******************
	public function setup_resize_button ():Void
	{
		mc_ref.resize_button ["class_ref"] = mc_ref;
		
		// onrollover override
		mc_ref.resize_button.onRollOver = function ()
		{
			_root.tooltip_mc.set_content ("Resize");
			_root.status_mc.add_message ("Click and drag to resize the object" , "tooltip");
		}
		
		// onrollout override
		mc_ref.resize_button.onRollOut = function ()
		{
			_root.tooltip_mc.throw_away ();
		}
		
		// onpress override
		mc_ref.resize_button.onPress = function ()
		{
			_root.tooltip_mc.throw_away ();
			this.class_ref.target_ref.resize_function (1);
			
			this.class_ref.onMouseMove = function ()
			{
				target_ref.pull_edit_panel ();
			}
		}
		
		// onrelease override
		mc_ref.resize_button.onRelease = function ()
		{
			this.class_ref.target_ref.resize_function (-1);
				
			delete this.class_ref.onMouseMove;
		}
		
		// onreleaseoutside override
		mc_ref.resize_button.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}

	// *******************
	// setup rotate button
	// *******************
	public function setup_rotate_button ():Void
	{
		mc_ref.rotate_button ["class_ref"] = mc_ref;
		
		// onrollover override
		mc_ref.rotate_button.onRollOver = function ()
		{
			_root.tooltip_mc.set_content ("Rotate");
			_root.status_mc.add_message ("Click and drag to rotate the object" , "tooltip");
		}
		
		// onrollout override
		mc_ref.rotate_button.onRollOut = function ()
		{
			_root.tooltip_mc.throw_away ();
		}
		
		// onpress override
		mc_ref.rotate_button.onPress = function ()
		{
			_root.tooltip_mc.throw_away ();
			this.class_ref.target_ref.rotate_function (1);
			
			this.class_ref.onMouseMove = function ()
			{
				target_ref.pull_edit_panel ();
			}
		}
		
		// onrelease override
		mc_ref.rotate_button.onRelease = function ()
		{
			this.class_ref.target_ref.rotate_function (-1);
				
			delete this.class_ref.onMouseMove;
		}
		
		// onreleaseoutside override
		mc_ref.rotate_button.onReleaseOutside = function ()
		{
			this.onRelease ();
		}
	}

	// ***********************
	// setup properties button
	// ***********************
	public function setup_properties_button ():Void
	{
		mc_ref.properties_button ["class_ref"] = mc_ref;
		
		// onrollover override
		mc_ref.properties_button.onRollOver = function ()
		{
			_root.tooltip_mc.set_content ("Properties");
			_root.status_mc.add_message ("Click to setup some advanced object properties" , "tooltip");
		}
		
		// onrollout override
		mc_ref.properties_button.onRollOut = function ()
		{
			_root.tooltip_mc.throw_away ();
		}
		
		// onrelease override
		mc_ref.properties_button.onRelease = function ()
		{
			_root.tooltip_mc.throw_away ();
			this.class_ref.throw_away ();
			this.class_ref.target_ref.properties_function ();
		}
	}

	// *******************
	// setup delete button
	// *******************
	public function setup_delete_button ():Void
	{
		mc_ref.delete_button ["class_ref"] = mc_ref;
		
		// onrollover override
		mc_ref.delete_button.onRollOver = function ()
		{
			_root.tooltip_mc.set_content ("Delete");
			_root.status_mc.add_message ("Click to delete the current object" , "tooltip");
		}
		
		// onrollout override
		mc_ref.delete_button.onRollOut = function ()
		{
			_root.tooltip_mc.throw_away ();
		}
		
		// onrelease override
		mc_ref.delete_button.onRelease = function ()
		{
			_root.tooltip_mc.throw_away ();
			this.class_ref.throw_away ();
			this.class_ref.target_ref.delete_function ();
		}
	}
	
	// ******************
	// setup close button
	// ******************
	public function setup_close_button ():Void
	{
		mc_ref.close_button ["class_ref"] = mc_ref;
		
		// onrelease override
		mc_ref.close_button.onRelease = function ()
		{
			this.class_ref.throw_away ();
		}
	}
}