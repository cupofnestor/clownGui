﻿package  {		import flash.display.MovieClip;	import com.nocircleno.graffiti.tools.BrushType;	import flash.events.Event;	public class smBrush extends makeupTool {						public function smBrush() {			// constructor code			super(new smBrush_mask());			buildBrush(8,makeupTool.DEFAULT_COLOR,1,2,BrushType.ROUND);		}				public override function init(e:Event):void{			super.init(e);			_label = this.label;		}	}	}