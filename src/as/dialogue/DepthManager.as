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
		mc_ref.createClassObject (mx.controls.List, "element_list", 1, {_x:20, _y:35, _width:170, _height:175});
		
		setup_component_style ();
		
		setup_element_list ();
		setup_up_button ();
		setup_down_button ();
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
			this.class_ref.up_button.enabled = true;
			this.class_ref.down_button.enabled = true;
			
			if (this.class_ref.element_list.selectedIndex == 0)
			{
				this.class_ref.up_button.enabled = false;
			}
			
			if (this.class_ref.element_list.selectedIndex == this.class_ref.element_list.length - 1)
			{
				this.class_ref.down_button.enabled = false;
			}
		}
		
		mc_ref.element_list.addEventListener ("change", temp_listener);
	}
	
	// ******************
	// input element list
	// ******************
	public function input_element_list ():Void
	{
		var temp_array:Array;
		
		_root.page_mc.rearrange_depth ();
		temp_array = _root.page_mc.get_content_mc_array ();
		
		for (var i in temp_array)
		{
			mc_ref.element_list.addItem ({label:temp_array [i]._name, data:temp_array [i].getDepth ()});
		}		
	}
	
	// ***************
	// setup up button
	// ***************
	public function setup_up_button ():Void
	{
		mc_ref.up_button ["class_ref"] = mc_ref;
		mc_ref.up_button.onRelease = function ()
		{
			_root.page_mc.change_depth (this.class_ref.element_list.selectedItem.data, 1);
			
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
		mc_ref.down_button ["class_ref"] = mc_ref;
		mc_ref.down_button.onRelease = function ()
		{
			_root.page_mc.change_depth (this.class_ref.element_list.selectedItem.data, -1);
			
			var temp_num:Number;
			temp_num = this.class_ref.element_list.selectedIndex;
			
			this.class_ref.element_list.removeAll ();
			this.class_ref.input_element_list ();
			
			this.class_ref.element_list.selectedIndex = temp_num + 1;
			this.class_ref.element_list.dispatchEvent({type: "change", target: this.class_ref.element_list});
		}
	}
}