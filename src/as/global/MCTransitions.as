import mx.transitions.*;
import mx.transitions.easing.*;

// *******************
// MCTransitions class
// *******************
class as.global.MCTransitions
{
	// private variables
	private var transition_style:String;
	private var transition_param:Object;
	private var transition_manager:TransitionManager;
	
	private var mc_ref:MovieClip;										// caller mc ref

	// ***********
	// constructor
	// ***********
	public function MCTransitions ()
	{
		transition_param = new Object ();
	}

	// ****************
	// start transition
	// ****************
	public function start_transition (d:String):Void
	{
		// 0 for in while 1 for out
		switch (d)
		{
			case "in":
			{
				transition_param.direction = 0;
				break;
			}
			case "out":
			{
				transition_param.direction = 1;
				break;
			}
		}

		transition_manager.startTransition (transition_param);
	}
	
	// *****************
	// set caller mc ref
	// *****************
	// caller means the mc which calls up the transition to start
	// it is important to ref this so that when transition done,
	// it can call back this mc to do further actions
	public function set_mc_ref (m:MovieClip):Void
	{
		mc_ref = m;
	}
	
	// ******************
	// set transition ref
	// ******************
	public function set_transition_ref (m:MovieClip):Void
	{
		transition_manager = new TransitionManager (m);
		
		setup_transition_listener ();
	}

	// *************************
	// setup transition listener
	// *************************
	private function setup_transition_listener ():Void
	{
		var transition_listener:Object = new Object ();
		transition_listener ["class_ref"] = this;
		
		transition_listener.allTransitionsOutDone = function ():Void
		{
			this.class_ref.mc_ref.transition_out_action ();		
			this.class_ref.start_transition ("in");
		}
		
		transition_manager.addEventListener ("allTransitionsOutDone", transition_listener);
	}
	
	// ********************
	// set transition style
	// ********************
	public function set_transition_style (s:String):Void
	{
		transition_style = s;
		
		switch (s)
		{
			// Iris
			case "iris":
			{
				transition_param.startPoint = 5;
				transition_param.duration = 1.5;
				transition_param.type = Iris;
				transition_param.shape = "CIRCLE";
				transition_param.easing = Bounce.easeOut;
				break;
			}
			
			// Fade
			case "fade":
			{
				transition_param.startPoint = 1;
				transition_param.duration = 1;
				transition_param.type = Fade;
				transition_param.easing = Strong.easeInOut;
				break;
			}
			
			// Fly
			case "fly":
			{
				transition_param.startPoint = 4;
				transition_param.duration = 1;
				transition_param.type = Fly;
				transition_param.easing = Elastic.easeOut;
				break;
			}
			
			// PixelDissolve
			case "pixel":
			{
				transition_param.startPoint = 1;
				transition_param.duration = 1.5;
				transition_param.type = PixelDissolve;
				transition_param.xSections = Math.round (Stage.width / 30);
				transition_param.ySections = Math.round (Stage.height / 30);
				transition_param.easing = Strong.easeInOut;
				break;
			}
			
			// Wipe
			case "wipe":
			{
				transition_param.startPoint = 2;
				transition_param.duration = 1;
				transition_param.type = Wipe;
				transition_param.easing = Strong.easeInOut;
				break;
			}
		}
	}
	
	// ********************
	// get transition style
	// ********************
	public function get_transition_style ():String
	{
		return (transition_style);
	}
}
