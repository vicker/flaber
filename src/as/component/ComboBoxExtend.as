// ********************
// ComboBoxExtend class
// ********************
class as.component.ComboBoxExtend extends mx.controls.ComboBox
{
	// some static things that are essentials for component extension
	// Ref: http://www.flashgamer.com/2006/02/extending_the_macromedia_v2_co.html
	static var symbolOwner:Object = ComboBoxExtend;
	static var symbolName:String = "lib_combobox_extend";

	public function select_item (s:String):Number
	{
		// find inside the combobox
		for (var i = 0; i < this.length; i++)
		{
			if (s == this.getItemAt (i).data)
			{
				this.selectedIndex = i;
				return (i);
			}
		}
		
		// if not found but editable
		if (this.editable == true)
		{
			this.text = s;
			return (null);
		}
		
		// if not found and not editable
		return (-1);
	}
}
