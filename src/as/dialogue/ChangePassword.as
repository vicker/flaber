// ********************
// ChangePassword class
// ********************
class as.dialogue.ChangePassword extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function ChangePassword ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.TextInput, "password_textinput", 1, {_x:35, _y:35, _width:125, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "new_password_textinput", 2, {_x:35, _y:95, _width:125, _height:20});
		mc_ref.createClassObject (mx.controls.TextInput, "confirm_password_textinput", 3, {_x:35, _y:155, _width:125, _height:20});

		mc_ref.attachMovie ("lib_button_mc", "ok_button", 4, {_x:10, _y:200});
		mc_ref.attachMovie ("lib_button_mc", "cancel_button", 5, {_x:100, _y:200});
		
		setup_component_style ();
		
		setup_textinput ();
		setup_ok_button ();
		setup_cancel_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.password_label.setStyle ("styleName", "label_style");
		mc_ref.new_password_label.setStyle ("styleName", "label_style");
		mc_ref.confirm_password_label.setStyle ("styleName", "label_style");
		
		mc_ref.password_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.new_password_textinput.setStyle ("styleName", "textinput_style");
		mc_ref.confirm_password_textinput.setStyle ("styleName", "textinput_style");
	}
	
	// ***************
	// data validation
	// ***************
	public function data_validation ():Boolean
	{
		if (mc_ref.new_password_textinput.text != mc_ref.confirm_password_textinput.text)
		{
			_root.status_mc.add_message ("New password and confirm password not match", "critical");
			return false;
		}
		
		return true;
	}

	// ***************
	// setup textinput
	// ***************
	public function setup_textinput ():Void
	{
		mc_ref.password_textinput.password = true;
		mc_ref.new_password_textinput.password = true;
		mc_ref.confirm_password_textinput.password = true;
	}
	
	// ***************
	// change password
	// ***************
	public function change_password ():Void
	{
		if (data_validation () == true)
		{		
			var password_xml:as.datatype.XMLExtend;
			
			password_xml = new as.datatype.XMLExtend ();
			password_xml.ignoreWhite = true;
			password_xml ["class_ref"] = mc_ref;
			password_xml.sendAndLoad ("function/change_password.php?password=" + mc_ref.password_textinput.text + "&new_password=" + mc_ref.new_password_textinput.text, password_xml);
			password_xml.check_progress ("Changing password...");
			
			password_xml.onLoad = function (b:Boolean)
			{
				if (b)
				{
					// if it is login successful
					if (this.firstChild.nodeName == "changed")
					{
						_root.flaber.set_stored_password (this.class_ref.new_password_textinput.text);
						_root.status_mc.add_message ("Password changed successfully", "normal");
						this.class_ref._parent.close_window ();
					}
					// if have error
					else
					{
						this.stop_progress ();
						_root.status_mc.add_message (this.toString (), "");
					}
				}
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
			this.class_ref.change_password ();
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
