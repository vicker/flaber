// ******************
// DepthManager class
// ******************
class as.dialogue.DepthManager extends MovieClip
{
	// private variables
	private var mc_ref:MovieClip;					// reference to the movie clip
	
	// ***********
	// constructor
	// ***********
	public function DepthManager ()
	{
		mc_ref = this;
		
		setup_component_object ();
	}
	
	// **********************
	// setup component object
	// **********************
	public function setup_component_object ():Void
	{
		mc_ref.createClassObject (mx.controls.List, "element_list", 1, {_x:20, _y:45, _width:170, _height:175});

		mc_ref.attachMovie ("lib_button_mc", "up_button", 2, {_x:120, _y:10});
		mc_ref.attachMovie ("lib_button_mc", "down_button", 3, {_x:155, _y:10});
		mc_ref.attachMovie ("lib_button_mc", "edit_button", 4, {_x:20, _y:230});
		mc_ref.attachMovie ("lib_button_mc", "delete_button", 5, {_x:110, _y:230});

		
		setup_component_style ();
		
		setup_element_list ();
		setup_up_button ();
		setup_down_button ();
		setup_edit_button ();
		setup_delete_button ();
	}
	
	// *********************
	// setup component style
	// *********************
	public function setup_component_style ():Void
	{
		mc_ref.element_label.setStyle ("styleName", "label_style");
		
		mc_ref.element_list.setStyle ("styleName", "list_style");
	}
	
	// ******************
	// setup element list
	// ******************
	public function setup_element_list ():Void
	{
		mc_ref.element_list.rowHeight = 17;
		
		input_element_list ();
		
		mc_ref.element_list.selectedIndex = 0;
		
		var temp_listener:Object;
		temp_listener = new Object ();
		temp_listener ["class_ref"] = mc_ref;
		temp_listener.change = function ()
		{
			if (this.class_ref.element_list.selectedIndex == 0)
			{
				this.class_ref.up_button.enabled = false;
				this.class_ref.up_button._alpha = 25;
			}
			else
			{
				this.class_ref.up_button.enabled = true;
				this.class_ref.up_button._alpha = 100;
			}
			
			if (this.class_ref.element_list.selectedIndex == this.class_ref.element_list.length - 1)
			{
				this.class_ref.down_button.enabled = false;
				this.class_ref.down_button._alpha = 25;
			}
			else
			{
				this.class_ref.down_button.enabled = true;
				this.class_ref.down_button._alpha = 100;
			}
		}
		
		mc_ref.element_list.addEventListener ("change", temp_listener);
	}
	
	// ******************
	// input element list
	// ******************
	public function input_element_list ():Void
	{
		_root.page_mc.rearrange_depth ();

		var temp_array:Array;
		temp_array = _root.page_mc.get_content_mc_array ();
		
		for (var i in temp_array)
		{
			if (temp_array [i] != undefined)
			{
				mc_ref.element_list.addItem ({label:temp_array [i]._name, data:temp_array [i].getDepth (), index:i});
			}
		}		
	}
	
	// ***************
	// setup up button
	// ***************
	public function setup_up_button ():Void
	{
		mc_ref.up_button.enabled = false;
		mc_ref.up_button._alpha = 25;	
		
		mc_ref.up_button.set_toggle_flag (false);
		mc_ref.up_button.set_dimension (25, 20);
		mc_ref.up_button.set_text ("+");		
		
		mc_ref.up_button ["class_ref"] = mc_ref;
		mc_ref.up_button.onRelease = function ()
		{
			_root.page_mc.change_depth (this.class_ref.element_list.selectedItem.index, 1);
			
			var temp_num:Number;
			temp_num = this.class_ref.element_list.selectedIndex;
			
			this.class_ref.element_list.removeAll ();
			this.class_ref.input_element_list ();
			
			this.class_ref.element_list.selectedIndex = temp_num - 1;
			this.class_ref.element_list.dispatchEvent({type: "change", target: this.class_ref.element_list});
		}
	}
	
	// *****************
	// setup down button
	// *****************
	public function setup_down_button ():Void
	{
		mc_ref.down_button.set_toggle_flag (false);
		mc_ref.down_button.set_dimension (25, 20);
		mc_ref.down_button.set_text ("-");		
		
		mc_ref.down_button ["class_ref"] = mc_ref;
		mc_ref.down_button.onRelease = function ()
		{
			_root.page_mc.change_depth (this.class_ref.element_list.selectedItem.index, -1);
			
			var temp_num:Number;
			temp_num = this.class_ref.element_list.selectedIndex;
			
			this.class_ref.element_list.removeAll ();
			this.class_ref.input_element_list ();
			
			this.class_ref.element_list.selectedIndex = temp_num + 1;
			this.class_ref.element_list.dispatchEvent({type: "change", target: this.class_ref.element_list});
		}
	}
	
	// *****************
	// setup edit button
	// *****************
	public function setup_edit_button ():Void
	{
		mc_ref.edit_button.set_toggle_flag (false);
		mc_ref.edit_button.set_dimension (75, 20);
		mc_ref.edit_button.set_text ("Edit");

		mc_ref.edit_button ["class_ref"] = mc_ref;
		mc_ref.edit_button.onRelease = function ()
		{
			_root.page_mc.getInstanceAtDepth (this.class_ref.element_list.selectedItem.data).properties_function ();
			this.class_ref._parent.close_window ();
		}
	}
	
	// *******************
	// setup delete button
	// *******************
	public function setup_delete_button ():Void
	{
		mc_ref.delete_button.set_toggle_flag (false);
		mc_ref.delete_button.set_dimension (75, 20);
		mc_ref.delete_button.set_text ("Delete");

		mc_ref.delete_button ["class_ref"] = mc_ref;
		mc_ref.delete_button.onRelease = function ()
		{
			_root.page_mc.getInstanceAtDepth (this.class_ref.element_list.selectedItem.data).delete_function ();
			this.class_ref.element_list.removeItemAt (this.class_ref.element_list.selectedIndex);	
		}
	}
}
