﻿package  {		import flash.display.MovieClip;	import com.greensock.TweenMax;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.display.DisplayObject;	import flash.text.StyleSheet;	import flash.text.TextField;	import flash.filters.BitmapFilter;	import flash.filters.BevelFilter;	import flash.filters.BitmapFilterQuality;    import flash.filters.BitmapFilterType;    import flash.filters.GlowFilter;    import flash.media.SoundChannel;    import flash.media.Sound;		public class alert extends MovieClip {		private var sc:SoundChannel = new SoundChannel();		private var sl:Sound = new slideMP3();		public static const TIP:Number = 0;		public static const CONFIRM:Number = 1;		public static const CONFIRM_CANCEL:Number = 2;		private var tweenTime = 0.35;		private var initX,initY,targetY:Number;		private var clock:Timer = new Timer(1000);		private var alertObj:Object;		private var sheet:StyleSheet = new StyleSheet();		private var bevel:BevelFilter;		private var glow:GlowFilter;		private var looping:Boolean = true;		private var padding = 25;		private var onStage:Boolean = false;		public function alert() {			// constructor code			addEventListener(Event.ADDED_TO_STAGE, init);		}				public function set evTarget(t:DisplayObject){			t.addEventListener(AlertEvent.ALERT, newAlert);		}						private function init(e:Event):void{			setStyles();			this.x = initX = 0;			this.y = initY = stage.stageHeight;			targetY = stage.stageHeight - this.height;			cancel.mouseChildren = ok.mouseChildren = false;			this.textBox.mouseEnabled = this.textBox.mouseChildren = false;			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);			addFilter();			bevelLoop();					}				private function addFilter():void{			var distance:Number       = 5;            var angle:Number = 45;            var highlightColor:Number = 0xffffff;            var highAlpha:Number = 0.8;            var blur:Number          = 15;            var strength:Number       = 1;         			bevel = new BevelFilter(distance,angle,highlightColor,highAlpha,0,0,blur,blur,strength,BitmapFilterQuality.HIGH,BitmapFilterType.INNER);									glow = new GlowFilter(0xffffdd,1,0,0,0,BitmapFilterQuality.HIGH);			this.filters = [bevel,glow];		}				private function bevelLoop(){			if (looping) { 				bevel.angle = 180;				TweenMax.to(bevel, tweenTime*4,{strength:2});				TweenMax.to(bevel, tweenTime*4, {delay: tweenTime*2, angle:0,strength:0, onComplete:bevelLoop}) 				}		}				private function blurLoopIn(){			if (looping) {				TweenMax.to(glow, tweenTime*2, {delay: tweenTime*2, blurY:30, strength:2, onComplete:blurLoopOut});			}		}				private function blurLoopOut(){			TweenMax.to(glow, tweenTime*2, {blurY:0, strength:0, onComplete:blurLoopIn});		}				private function applyFilter(e:Event){			this.filters = [bevel,glow];		}				private function setStyles():void		{						//field.autoSize = TextFieldAutoSize.LEFT;			//field.antiAliasType = AntiAliasType.ADVANCED;			this.textBox.message.multiline = true;			this.textBox.message.wordWrap = true;			this.textBox.message.embedFonts = true;			this.textBox.message.condenseWhite = true;						var largeHeaderFont:bert = new bert();			var headerFont:lib_bold = new lib_bold();			var bodyFont:gill_reg = new gill_reg();			var boldFont:lib_bold = new lib_bold();						var largeHeader:Object = {display:"block", fontFamily:largeHeaderFont.fontName, fontSize:26, fontWeight: "bold", letterSpacing: -1, textIndent:0};			var bodyBreak:Object = {display:"block", fontSize:2};			var header:Object = {display:"block", fontFamily:headerFont.fontName, fontSize:20, fontWeight: "bold", letterSpacing: -1, textIndent:0};			var body:Object = {display:"block", fontFamily:bodyFont.fontName, fontSize :20, textIndent:10};			var bold:Object = {fontFamily:boldFont.fontName, fontWeight: "bold", fontStyle:"bold", fontSize:18};						/*sheet.setStyle(".space", paperSpacer);			sheet.setStyle(".header", paperHeader);			sheet.setStyle(".body", paperBody);			sheet.setStyle(".bold", bold);*/			sheet.setStyle("br", bodyBreak);			sheet.setStyle("h1", largeHeader);			sheet.setStyle("h2", header);			sheet.setStyle("p", body);			sheet.setStyle(".bold", bold);									this.textBox.message.styleSheet = sheet;						//textField.textFlow.formatResolver = new CSSFormatResolver(sheet);//			field.textFlow.flowComposer.updateAllControllers();		}						private function startLoop():void{			looping = true;			if (!this.hasEventListener(Event.ENTER_FRAME)) addEventListener(Event.ENTER_FRAME, applyFilter);			blurLoopIn();			bevelLoop();		}				private function stopLoop():void{			looping = false;			removeEventListener(Event.ENTER_FRAME, applyFilter);		}				public function newAlert(a:AlertEvent):void{			startLoop();			var _alert:Object = a.alert;			this.textBox.message.htmlText = _alert.text;						var newHeight:Number = textBox.message.textHeight + textBox.y + padding;			targetY = stage.stageHeight - newHeight;						alertObj = _alert;			if (clock.running) clock.stop();			switch(alertObj.type){				case TIP:					this.ok.visible = this.cancel.visible = false;					this.ok.mouseEnabled = this.cancel.mouseEnabled = false;					break;				case CONFIRM:					this.ok.visible = this.ok.mouseEnabled = true;					this.cancel.visible = this.cancel.mouseEnabled = false;					break;				case CONFIRM_CANCEL:					this.ok.visible = this.cancel.visible = true;					this.ok.mouseEnabled = this.cancel.mouseEnabled = true;					break;			}			var timeout:Number = alertObj.time;			if (timeout > 0){				clock = new Timer(timeout*1000, 1);				clock.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);				clock.start();			}			if (!onStage){				sc = sl.play();			}			TweenMax.to(this, tweenTime, {y:targetY, onComplete:onStageHandler});					}				private function onStageHandler():void{			onStage = true;		}						private function timerCompleteHandler(t:TimerEvent):void{			clock.removeEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandler);						if (onStage){				sc = sl.play();				TweenMax.to(this, tweenTime, {y:initY, onComplete:alertOff});			}								}				private function mouseHandler(m:MouseEvent){			if(m.target is MovieClip){				alertObj.confirmed = m.target is ok_mc;								if (onStage){					sc = sl.play();					TweenMax.to(this, tweenTime, {y:initY, onComplete:alertOff});				}			}		}				private function alertOff():void{			onStage = false;			dispatchEvent(new AlertEvent(AlertEvent.ACTION, false,false,alertObj));			stopLoop();					}	}	}