// *****************
// TextFieldMC class
// *****************
class as.page_content.TextFieldMC extends MovieClip
{
	// MC variables
	// Dynamic Text Field			content_field
	
	// private variables
	private var mc_ref:MovieClip;						// interface for the navigation item mc
	
	// constructor
	public function TextFieldMC ()
	{
		mc_ref = this;
		mc_ref.content_field.html = true;
		mc_ref.content_field.multiline = true;
		mc_ref.content_field.wordWrap = true;
	}
	
	// ***************
	// data_xml setter
	// ***************
	public function set_data_xml (x:XMLNode):Void
	{
		for (var i in x.childNodes)
		{
			var temp_node:XMLNode;
			var temp_name:String;
			var temp_value:String;
			
			temp_node = x.childNodes [i];
			temp_name = temp_node.nodeName;
			temp_value = temp_node.firstChild.nodeValue;
			
			switch (temp_name)
			{
				// x position of the textfield
				case "x":
				{
					mc_ref._x = parseInt (temp_value);
					break;
				}
				// y position of the textfield
				case "y":
				{
					mc_ref._y = parseInt (temp_value);
					break;
				}
				// width of the textfield
				case "width":
				{
					mc_ref.content_field._width = parseInt (temp_value);
					break;
				}
				// height of the textfield
				case "height":
				{
					mc_ref.content_field._height = parseInt (temp_value);
					break;
				}
				// content of the textfield
				case "text":
				{
					mc_ref.content_field.htmlText = temp_node.childNodes.toString ();
					break;
				}
			}
		}
		
		if (x.attributes ["scroll_bar"] == "true")
		{
			// setup full mc's scroll bar
			mc_ref.attachMovie ("lib_scroll_bar", "scroll_bar", mc_ref.getNextHighestDepth ());
			mc_ref.scroll_bar.set_scroll_ref (mc_ref.content_field);
		}
	}
}
