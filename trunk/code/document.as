package {
	
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.Timer;  
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class document extends MovieClip {
		
		/**
		 *  Main Variables
		 */
		 
		// Global Variables
		var recipePage = new mc_recipePage();
		var ingredientOutline:MovieClip = new MovieClip();
		
		var musicPage = new mc_musicPage();
		var modal = new mc_modal();

		// Recipe page variables
		var searchArea = new mc_searchArea();
		var addIcon = new btn_addIcon();
		var ingredientDisplay = new mc_ingredientDisplay();
		var guestDisplay = new mc_guestDisplayBox();
		var guestIncrease = new btn_guestIncrease();
		var guestDecrease = new btn_guestDecrease();
		var ingredientSearch = new btn_ingredientSearch();
		var recipeDisplay = new mc_recipeDisplay();
		var recipeGrill = new btn_recipeGrill();
		var recipeBack = new btn_recipeBack();
		var recipeNext = new btn_recipeNext();
		var closeMe = new btn_closeBorder();
		var ingredientList:TextField = new TextField();
		var ingredients:TextField = new TextField();
		var ingredientLabel:TextField = new TextField();
		var ingredientTitle:TextField = new TextField();
		var manualLabel:TextField = new TextField();
		var autoLabel:TextField = new TextField();
		var ingredientsArray:Array = new Array();
		var startSlider;
		var myFormat = new TextFormat();
		var switchFormat = new TextFormat();
		var timeline = new mc_timeline();
		var timelineScroller = new mc_timelineScroller();
		var currentState:int = new int(); // 1 = auto, 0 = manual
		
		var flame = new mc_grillFlame();
		var flameBorder = new mc_grillFlameBorder();
		
		public function document() {
			currentState = 1; // auto
			myFormat.font = "Myriad Pro";
			myFormat.color = "0xFFFFFF";
			myFormat.size = 22;
			switchFormat.font = "Myriad Pro";
			switchFormat.color = "0x000000";
			switchFormat.size = 18;
			
			autoLabel.type = TextFieldType.DYNAMIC;
				autoLabel.text = "Auto";
				autoLabel.x = 1330;
				autoLabel.y = 10;
				autoLabel.width = 400;
				autoLabel.setTextFormat(switchFormat);
			manualLabel.type = TextFieldType.DYNAMIC;
				manualLabel.text = "Manual";
				manualLabel.x = 1330;
				manualLabel.y = 160;
				manualLabel.width = 400;
				manualLabel.setTextFormat(switchFormat);
			
			mc_mainScreen.addChild(manualLabel);
			mc_mainScreen.addChild(autoLabel);
			
			timeline.x = 17.3;
			timeline.y = 723.3;
			timeline.width = 1080;
			timelineScroller.x = 21.5;
			timelineScroller.y = 723.3;
			
			mc_mainScreen.addChild(timeline);
			mc_mainScreen.addChild(timelineScroller);
			
			mc_mainScreen.mc_slideArea.mc_sliderButton.stop();
			mc_mainScreen.btn_navButton1.addEventListener(MouseEvent.CLICK, recipeButton);
			mc_mainScreen.btn_navButton2.addEventListener(MouseEvent.CLICK, musicButton);
			
			mc_mainScreen.mc_slideArea.mc_sliderButton.addEventListener(MouseEvent.MOUSE_DOWN, sliderDrag);
			mc_mainScreen.mc_slideArea.mc_sliderButton.stage.addEventListener(MouseEvent.MOUSE_UP, sliderDrop);
		}
		
		var sliderBind:Rectangle = new Rectangle(11.8, 22, 0, 145);  
		
		function sliderDrag(event:MouseEvent):void {
			startSlider = mc_mainScreen.mc_slideArea.mc_sliderButton.y;
			mc_mainScreen.mc_slideArea.mc_sliderButton.startDrag(false, sliderBind);
		}
		
		function sliderDrop(event:MouseEvent):void {
			mc_mainScreen.mc_slideArea.mc_sliderButton.stopDrag();
			//trace(mc_mainScreen.mc_slideArea.mc_sliderButton.y);
			if(mc_mainScreen.mc_slideArea.mc_sliderButton.y <= 95) {
				snapUp();
			}
			else if(mc_mainScreen.mc_slideArea.mc_sliderButton.y > 95) {
				snapDown();
			}
			else {
				if(startSlider > 95) {
					snapDown();
				}
				else {
					snapUp();
				}
			}
		}
		
		function snapDown() {
			//mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(5);
			var ingredientOutline:Tween = new Tween(mc_mainScreen.mc_slideArea.mc_sliderButton, "y", null, mc_mainScreen.mc_slideArea.mc_sliderButton.y,167,0.1, true);
			mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(2);
			trace(mc_mainScreen.mc_slideArea.mc_sliderButton.y);
			if(currentState == 1) {
				var timelineDown:Tween = new Tween(timeline, "alpha", Strong.easeIn, 1,0,.3, true);
				var timelineDown2:Tween = new Tween(timelineScroller, "alpha", Strong.easeIn, 1,0,.3, true);
			}
			currentState = 0;
		}
		
		function snapUp() {
			//mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(1);
			var ingredientOutline:Tween = new Tween(mc_mainScreen.mc_slideArea.mc_sliderButton, "y", null, mc_mainScreen.mc_slideArea.mc_sliderButton.y,22,0.1, true);
			mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(1);
			trace(mc_mainScreen.mc_slideArea.mc_sliderButton.y);
			if(currentState == 0) {
				var timelineUp:Tween = new Tween(timeline, "alpha", Strong.easeIn, 0,1,.3, true);
				var timelineUp2:Tween = new Tween(timelineScroller, "alpha", Strong.easeIn, 0,1,.3, true);
			}
			currentState = 1;
		}
		
		function recipeButton(event:MouseEvent):void {
			if( musicPage.parent == mc_mainScreen ) {
				musicPage.x = 50000;
			}
			
			showModal();
			
			mc_mainScreen.addChild(recipePage);
			recipePage.alpha = 0;
			recipePage.addChild(ingredientOutline);
				ingredientOutline.addChild(searchArea);
				ingredientOutline.addChild(addIcon);
				ingredientOutline.addChild(ingredientDisplay);
				ingredientOutline.addChild(guestDisplay);
				ingredientOutline.addChild(guestIncrease);
				ingredientOutline.addChild(guestDecrease);
				ingredientOutline.addChild(ingredientSearch);
				ingredientOutline.addChild(ingredientLabel);
				ingredientOutline.addChild(ingredientTitle);
			
			recipePage.addChild(closeMe);
			
			recipePage.x = 59.6;
			recipePage.y = 59.0;
												  
			var recipeScreenStart:Tween = new Tween(recipePage, "alpha", Strong.easeIn, 0,1,1, true);
			ingredientOutline.x = 400;
			ingredientOutline.y = 0;
			searchArea.x = 20.9;
			searchArea.y = 18.4;
				ingredients.type = TextFieldType.INPUT;
				ingredients.wordWrap = false;
				ingredients.width = 140;
				ingredients.height = 20;
				ingredients.x = 10;
				ingredients.y = 15;
				ingredients.text="Type ingredients here.";
				ingredients.addEventListener(FocusEvent.FOCUS_IN, textFocus);
				ingredients.addEventListener(FocusEvent.FOCUS_OUT, textFocusOut);
				ingredients.addEventListener(KeyboardEvent.KEY_DOWN, checkEnter);
			addIcon.x = 205.1;
			addIcon.y = 27.9;
				addIcon.addEventListener(MouseEvent.MOUSE_DOWN, addIngredient);
				ingredientLabel.type = TextFieldType.DYNAMIC;
				ingredientLabel.text = "Number of Guests:";
				ingredientLabel.y = 360;
				ingredientLabel.x = 20;
				ingredientLabel.width = 400;
				ingredientLabel.height = 30;
				ingredientLabel.setTextFormat(myFormat);
				ingredientTitle.type = TextFieldType.DYNAMIC;
				ingredientTitle.text = "Ingredients:";
				ingredientTitle.y = 80;
				ingredientTitle.x = 20;
				ingredientTitle.width = 400;
				ingredientTitle.setTextFormat(myFormat);
			ingredientDisplay.x = 21.3;
			ingredientDisplay.y = 109.7;
				ingredientList.type = TextFieldType.DYNAMIC;
				ingredientList.wordWrap = true;
				ingredientList.width =  346;
				ingredientList.height = 220;
				ingredientList.x = 10;
				ingredientList.y = 15;
				ingredientList.text="";
			guestDisplay.x = 21.3;
			guestDisplay.y = 395.8;
			guestIncrease.x = 140.0;
			guestIncrease.y = 392.4;
			guestDecrease.x = 140.0;
			guestDecrease.y = 442.6;
			ingredientSearch.x = 21.3;
			ingredientSearch.y = 563.1;
			
			ingredientSearch.addEventListener(MouseEvent.MOUSE_UP, showRecipes);
			
			searchArea.addChild(ingredients);
			ingredientDisplay.addChild(ingredientList);
			
			closeMe.x = 1178.4;
			closeMe.y = -4;
			closeMe.addEventListener(MouseEvent.MOUSE_UP, closeOverlays);
		}
		
		function closeOverlays(event:MouseEvent):void {
			// If recipePage exists, move it off screen.
			if( recipePage.parent == mc_mainScreen ) {
				recipePage.x = 50000;
				modal.x = 50000;
				// If recipeDisplay exists, move it off screen.
				if( recipeDisplay.parent == recipePage ) {
					recipeDisplay.x = 50000;
				}
				
			}
			// If musicPage exists, move it off screen.
			else if( musicPage.parent == mc_mainScreen ) {
				trace('closed the music page');
				musicPage.x = 50000;
				modal.x = 50000;
			}
		}
		
		// Add ingredient from search field to list
		function addIngredient(event:MouseEvent):void {
			ingredientList.appendText("- " +ingredients.text +"\n");
			ingredientsArray.push(ingredients.text);
			trace(ingredientsArray[ingredientsArray.length-1]);
			ingredients.text = "";
		}
		
		function showModal() {
			if( modal.parent == mc_mainScreen ) {
				modal.x = -50;
				modal.y = -50;
			}
			else {
				mc_mainScreen.addChild(modal);
			}
			modal.alpha = .6;
			modal.x = -50;
			modal.y = -50;
			modal.mouseChildren = false;
		}
		
		// Enter key functionality
		function checkEnter(event:KeyboardEvent):void {
			if(event.keyCode == 13) {
				addIngredient(null);
			}
		}
		
		function showRecipes(event:MouseEvent):void {
			if( !recipeDisplay.exists ) {
				recipePage.addChild(recipeDisplay);
						recipeDisplay.addChild(recipeGrill);
						recipeDisplay.addChild(recipeBack);
						recipeDisplay.addChild(recipeNext);
				recipeDisplay.x = 50000;
				
				recipeGrill.addEventListener(MouseEvent.MOUSE_UP, startGrilling);
				recipeGrill.addEventListener(MouseEvent.MOUSE_UP, closeOverlays);
				ingredientSearch.removeEventListener(MouseEvent.MOUSE_UP, showRecipes);
			}
			slideRecipe();
			
		}
		
		function startGrilling(event:MouseEvent):void {
			
			mc_mainScreen.addChild(flame);
			mc_mainScreen.addChild(flameBorder);
			
			flame.x = 1000;
			flame.y = 76;
			flameBorder.x = 1000;
			flameBorder.y = 96;
		}
		
		function slideRecipe() {
			if(ingredientOutline.x == 400) {
				var ingredientStuff:Tween = new Tween(ingredientOutline, "x", Strong.easeIn, 400,0,0.5, true);
				recipeDisplay.x = 542.0;
				recipeDisplay.y = 28.7;
				recipeGrill.x = 100.0;
				recipeGrill.y = 446.9;
				recipeBack.x = 152.0;
				recipeBack.y = 539.6;
				recipeNext.x = 453.7;
				recipeNext.y = 539.6;
				var recipeDisplayStart:Tween = new Tween(recipeDisplay, "alpha", Strong.easeIn, 0,1,1, true);
			}
			else {
				ingredientSearch.removeEventListener(MouseEvent.MOUSE_UP, showRecipes);
			}
		}
		
		function textFocus(event:FocusEvent):void {
			ingredients.text = "";
		}
		
		function textFocusOut(event:FocusEvent):void {
			//event.target.text = "Type ingredients here.";
		}
		
		function musicButton(event:MouseEvent):void {
			if( recipePage.parent == mc_mainScreen ) {
				recipePage.x = 50000;
			}
			
			else if( musicPage.exists  ) {
				mc_mainScreen.addChild(musicPage);
			}
			showModal();
			
			musicPage.alpha = 0;
			musicPage.x = 59.6;
			musicPage.y = 59.0;
			var musicScreenStart:Tween = new Tween(musicPage, "alpha", Strong.easeIn, 0,1,1, true);
			
			musicPage.addChild(closeMe);
			closeMe.x = 1178.4;
			closeMe.y = -4;
			closeMe.addEventListener(MouseEvent.MOUSE_UP, closeOverlays);
		}
		
	}	
	
}