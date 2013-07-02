﻿package  {	import flash.display.Sprite;		import flash.display.Bitmap;		import flash.events.Event;	import flash.display.Shape;			import flash.display.BitmapData;	import flash.display.BlendMode;	import com.nocircleno.graffiti.tools.BrushType;		import com.nocircleno.graffiti.tools.BrushTool;			import com.nocircleno.graffiti.tools.ToolMode;	import flash.text.TextField;	import flash.text.TextFormat;	public class makeupTool extends Sprite {		public static const DEFAULT_COLOR:uint = 0xffffff;				private var wide,high:Number;		private var colorSP:Sprite;		private var colorMask:Bitmap;		private var currentColor:uint;		public var brProperties:Object;		public var grBrush:BrushTool;		public var debug:Boolean = true;		private var db:TextField;		public function makeupTool(clrMask:BitmapData, _defColor:uint = DEFAULT_COLOR) {			// constructor code			this.mouseChildren = false;			colorSP = new Sprite();			colorMask = new Bitmap(clrMask);						colorSP.cacheAsBitmap = true;			colorMask.cacheAsBitmap = true;						addEventListener(Event.ADDED_TO_STAGE, init);		}				[Inspectable]		public function set color(c:uint):void		{			currentColor = grBrush.color = c;						with (colorSP.graphics){				clear;				beginFill(c);				drawRect(0,0,this.width,this.height);			}			this.addChild(colorSP);c			colorSP.blendMode = (c != 0xffffff) ? BlendMode.MULTIPLY : BlendMode.HARDLIGHT;			if (colorSP.contains(colorMask)) colorSP.removeChild(colorMask);						colorSP.addChild(colorMask);			colorSP.mask = colorMask;		}				public function set size(n:Number):void{			grBrush.size = n;			this.db.text = String(n);		}				public function get size():Number{			return grBrush.size;					}				public function set isActive(b:Boolean):void		{			color = (b) ? DEFAULT_COLOR : currentColor;			colorSP.blendMode = BlendMode.MULTIPLY;		}				public function get brushProperties():Object{			return brProperties;		}				private function init(e:Event):void{			if(debug){				db = new TextField();				db.textColor = 0xffff00;				var format:TextFormat = new TextFormat();			format.size = 26;			db.setTextFormat(format);				addChild(db);											}								}				public function buildBrush(size:Number = 8, color:uint = DEFAULT_COLOR, alpha:Number = 1, blur:Number = 1, type:String = BrushType.DIAMOND, mode = ToolMode.NORMAL ){			grBrush = new BrushTool(size,color,alpha,blur,type,mode);		}											}	}