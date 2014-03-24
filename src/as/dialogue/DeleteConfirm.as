// *******************
// DeleteConfirm class
// *******************
class as.dialogue.DeleteConfirm extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function DeleteConfirm ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.Label, "object_label", 1, {_x:20, _y:35, _width:140, _height:20});

		mc_ref.attachMovie ("lib_button_mc", "yes_button", 2, {_x:10, _y:70});
		mc_ref.attachMovie ("lib_button_mc", "no_button", 3, {_x:90, _y:70});
		
		setup_component_style ();
		
		setup_object_label ();
		setup_yes_button ();
		setup_no_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.message_label.setStyle ("styleName", "label_style");
		mc_ref.object_label.setStyle ("textAlign", "center");
	}
	
	// ****************
	// setup file label
	// ****************
	public function setup_object_label ():Void
	{
		mc_ref.object_label.text = "(" + _root.handler_mc.get_target_ref ()._name + ")";
	}
	
	// ****************
	// setup yes button
	// ****************
	public function setup_yes_button ():Void
	{
		mc_ref.yes_button.set_toggle_flag (false);
		mc_ref.yes_button.set_dimension (70, 20);
		mc_ref.yes_button.set_text ("Yes");

		mc_ref.yes_button ["class_ref"] = mc_ref;
		mc_ref.yes_button.onRelease = function ()
		{
			_root.handler_mc.get_target_ref ().delete_function ();
			this.class_ref._parent.close_window ();
		}
	}
	
	// ***************
	// setup no button
	// ***************
	public function setup_no_button ():Void
	{
		mc_ref.no_button.set_toggle_flag (false);
		mc_ref.no_button.set_dimension (70, 20);
		mc_ref.no_button.set_text ("No");

		mc_ref.no_button ["class_ref"] = mc_ref;
		mc_ref.no_button.onRelease = function ()
		{
			this.class_ref._parent.close_window ();
		}
	}
}
