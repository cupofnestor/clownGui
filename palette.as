﻿package  {		import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.media.Sound;	import flash.media.SoundChannel;		public class palette extends MovieClip {		public var theme1:Object = {};		public var theme2:Object = {};		private var r,g,b,yel,bl,wh:uint;		private var rouge,coral,sherbert,cab,brick,dusty;		private var currentColor:uint =  0xffffff;		private var currentTin:colorTin;		private var tins:Object = new Object();		private var clk:Sound = new scratch();				private var sc:SoundChannel = new SoundChannel();				public function palette() {			// constructor code						addEventListener(MouseEvent.MOUSE_UP, colorSelected);			addEventListener(Event.ADDED_TO_STAGE, init);		}				public function get color():uint{			return currentColor;		}				public function set theme(t:Number):void{			(t>0) ? setTheme(theme2) : setTheme(theme1);		}				private function init(e:Event):void{			setupColors();			//dispatchEvent(new PaletteEvent(PaletteEvent.COLOR_CHOSEN,false,false,0xffffff));		}				private function setupColors():void		{			r	=	0xFF0000;			g	=	0x00ff00;			b	=	0x0000ff;			yel	=	0xffff00;			bl	=	0x000000;			wh	=	0xffffff;						theme1.color1	=	r;			theme1.color2	=	g;			theme1.color3	=	b;			theme1.color4	=	yel;			theme1.color5	=	bl;			theme1.color6	=	wh;						rouge		=	0xe77084;			coral		=	0xecaf8c;			sherbert	=	0xe3897b;			cab			=	0x9e654e;			brick		=	0xbb8167;			dusty		=	0xefafa9;						theme2.color1	=	rouge;			theme2.color2	=	coral;			theme2.color3	=	sherbert;			theme2.color4	=	cab;			theme2.color5	=	brick;			theme2.color6	=	dusty;												for (var k:String in theme1 ){				var tin:* = this.getChildByName(k) as colorTin;				tins[k] = tin;			}			currentTin = tins.color6;			currentColor = currentTin.color;			theme = 0;								}				private function setTheme(theme:Object):void{			for (var k:String in theme ){				tins[k].color = theme[k];			}			currentColor = currentTin.color;			dispatchEvent(new PaletteEvent(PaletteEvent.COLOR_CHOSEN,false,false,currentTin.color));		}						private function colorSelected(m:MouseEvent):void{						if(m.target is colorTin){				currentTin = m.target as colorTin;				currentColor = currentTin.color;				dispatchEvent(new PaletteEvent(PaletteEvent.COLOR_CHOSEN,false,false,currentTin.color));				sc = clk.play();			}					}	}	}