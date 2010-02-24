package {
	
	import flash.xml.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
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
		 
		var xmlLoader:URLLoader = new URLLoader();
		var xmlData:XML = new XML();

		// Global Variables
		var recipePage = new mc_recipePage();
		var ingredientOutline:MovieClip = new MovieClip();
		
		var musicPage = new mc_musicPage();
		var modal = new mc_modal();
		
		// Create a new Timer object with a delay of 500 ms
		var myTimer:Timer = new Timer(50);

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
		var guestCount:TextField = new TextField();
		var manualLabel:TextField = new TextField();
		var autoLabel:TextField = new TextField();
<<<<<<< .mine
		var tempDisplay:TextField = new TextField();
=======
		var recipeWords:TextField = new TextField();
		var recipeLabels:TextField = new TextField();
>>>>>>> .r20
		var ingredientsArray:Array = new Array();
		var startSlider;
		var myFormat = new TextFormat();
		var switchFormat = new TextFormat();
		var guestFormat = new TextFormat();
<<<<<<< .mine
		var tempFormat = new TextFormat();
=======
		var recipeFormat = new TextFormat();
>>>>>>> .r20
		var guestCounter:int = 1;
		var timeline = new mc_timeline();
		var timelineScroller = new mc_timelineScroller();
		var currentState:int = new int(); // 1 = auto, 0 = manual
		var numberOfButtons:int = 1;
		var buttons:Array = new Array();
		var deleteIcon = new btn_deleteIcon();
		var i:int = 0;
		var recipeArray:Array = new Array();
		var recipeIndex:Number = 0;
		
		// Tween declarations to avoid Garbage collecting
		var recipeScreenStart:Tween;
		var sliderSnapDown:Tween;
		var sliderSnapUp:Tween;
		var ingredientStuff:Tween;
		var recipeDisplayStart:Tween;
		var timelineDown:Tween;
		var timelineUp:Tween;
		var timelineDown2:Tween;
		var timelineUp2:Tween;
		var recipeResults:Array = new Array();
		var a:Number = 0;
		var fajitas:Number = 0;
		var burgers:Number = 0;
		
		var flame = new mc_grillFlame();
		var flameBorder = new mc_grillFlameBorder();
		var barLine:Sprite = new Sprite();
		
		function showXML(e:Event):void {
			xmlData = new XML(e.target.data);
			//trace(xmlData);
			
			for each (var element:XML in xmlData.*)
			{
				//tempSong.filename = element.@filename;
				//pDocClass.addSong(tempSong);
				//trace(element);
				//var playlistItem:PlaylistItem = new PlaylistItem(element.@filename);
				//pDocClass.addChild(playlistItem);
			}
		}
		
		function parseRecipes(recipeInput:XML):void {
		
		/*
			for (a = 0; a < 2; a++) // for each recipe...
			{
				trace(a);
				var recipeChildren:XMLList = recipeInput.recipe[a].ingredient.children(); 
				
				var counter:Number = 0;
				for each(var recipeInfo:XML in recipeChildren) { // for each current recipe ingredient...
					for(var i:Number = 0; i <= ingredientsArray.length; i++) { // for each ingredient typed in...
						if(ingredientsArray[i] == recipeInfo[a]) { // if ingredients match...
							trace(ingredientsArray[i]);
							trace(recipeInfo[a]);
							recipeResults.push(a); // push recipe #
							trace("adding: " +a);
							trace(recipeInput.recipe[a].title.text());
							trace(recipeInput.recipe[a].prep.text());
						}
					}
					counter++;
				}
			}
		*/
		
		}
		
		public function document() {
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.load(new URLRequest("../code/recipes.xml"));
			
			currentState = 1; // auto
			myTimer.addEventListener("timer", timelineTimer);
			
			myFormat.font = "Myriad Pro";
				myFormat.color = "0xFFFFFF";
				myFormat.size = 22;
			switchFormat.font = "Myriad Pro";
				switchFormat.color = "0x000000";
				switchFormat.size = 18;
			guestFormat.font = "Myriad Pro";
				guestFormat.color = "0x000000";
				guestFormat.size = 60;
<<<<<<< .mine
			tempFormat.font = "Myriad Pro";
				tempFormat.color = "0xFF0000";
				tempFormat.size = 24;
=======
			recipeFormat.font = "Myriad Pro";
				recipeFormat.color = "0x000000";
				recipeFormat.bold = true;
				recipeFormat.size = 18;
>>>>>>> .r20
			
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
			
			recipeArray
			
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
			mc_mainScreen.mc_slideArea.mc_sliderButton.useHandCursor;
			mc_mainScreen.mc_slideArea.mc_sliderButton.buttonMode = true;
		}
		
		var sliderBind:Rectangle = new Rectangle(11.8, 22, 0, 145);  
		
		function sliderDrag(event:MouseEvent):void {
			startSlider = mc_mainScreen.mc_slideArea.mc_sliderButton.y;
			mc_mainScreen.mc_slideArea.mc_sliderButton.startDrag(false, sliderBind);
		}
		
		function sliderDrop(event:MouseEvent):void {
			mc_mainScreen.mc_slideArea.mc_sliderButton.stopDrag();
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
			sliderSnapDown = new Tween(mc_mainScreen.mc_slideArea.mc_sliderButton, "y", null, mc_mainScreen.mc_slideArea.mc_sliderButton.y,167,0.1, true);
			mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(2);
			if(currentState == 1) {
				timelineDown = new Tween(timeline, "alpha", Strong.easeIn, 1,0,.3, true);
				timelineDown2 = new Tween(timelineScroller, "alpha", Strong.easeIn, 1,0,.3, true);
			}
			currentState = 0;
		}
		
		function snapUp() {
			//mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(1);
			sliderSnapUp = new Tween(mc_mainScreen.mc_slideArea.mc_sliderButton, "y", null, mc_mainScreen.mc_slideArea.mc_sliderButton.y,22,0.1, true);
			mc_mainScreen.mc_slideArea.mc_sliderButton.gotoAndStop(1);
			if(currentState == 0) {
				timelineUp = new Tween(timeline, "alpha", Strong.easeIn, 0,1,.3, true);
				timelineUp2 = new Tween(timelineScroller, "alpha", Strong.easeIn, 0,1,.3, true);
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
			ingredientOutline.addChild(guestCount);
			
			recipePage.x = 59.6;
			recipePage.y = 59.0;
												  
			recipeScreenStart = new Tween(recipePage, "alpha", Strong.easeIn, 0,1,1, true);
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
				ingredientList.setTextFormat(switchFormat);
			guestDisplay.x = 21.3;
			guestDisplay.y = 395.8;
			guestCount.x = 44;
			guestCount.y = 395.8;
				//guestCount.type = TextFieldType.DYNAMIC;
				guestCount.wordWrap = true;
				guestCount.width =  100;
				guestCount.height = 220;
				guestCount.text = "1";
				guestCount.setTextFormat(guestFormat);
			guestIncrease.x = 140.0;
			guestIncrease.y = 392.4;
			guestDecrease.x = 140.0;
			guestDecrease.y = 442.6;
			guestIncrease.addEventListener(MouseEvent.MOUSE_DOWN, guestUp);
			guestDecrease.addEventListener(MouseEvent.MOUSE_DOWN, guestDown);
			ingredientSearch.x = 21.3;
			ingredientSearch.y = 563.1;
			
			ingredientSearch.addEventListener(MouseEvent.MOUSE_UP, showRecipes);
			
			searchArea.addChild(ingredients);
			ingredientDisplay.addChild(ingredientList);
			
			closeMe.x = 1178.4;
			closeMe.y = -4;
			closeMe.addEventListener(MouseEvent.MOUSE_UP, closeOverlays);
		}
		
		function guestDown(event:MouseEvent):void {
			if(guestCounter <= 1) {
				guestCounter = 1;
			}
			else {
				guestCounter--;
				if( guestCounter <= 9 ) {
					guestCount.x = 44;
				}
			}
			
			guestCount.text = String(guestCounter);
			guestCount.setTextFormat(guestFormat);
		}
		
		function guestUp(event:MouseEvent):void {
			if(guestCounter >= 15) {
				guestCounter = 15;
			}
			else {
				guestCounter++;
				if( guestCounter >= 10 ) {
					guestCount.x = 30;
				}
			}
				
			guestCount.text = String(guestCounter);
			guestCount.setTextFormat(guestFormat);
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
			if(String(ingredients.text).length >= 1) {
				ingredientList.appendText("- " +ingredients.text +"\n");
				ingredientsArray.push(ingredients.text);
			
			/*
				buttons[i] = UtilFunctions.clone(deleteIcon) as btn_deleteIcon;
				ingredientDisplay.addChild(buttons[i]);
				buttons[buttons.length].y = 24*(i+1);
				buttons[buttons.length].x = 40;
				trace("added at " +buttons[i].y +" " +buttons[i].x);
				i++;
			*/
			
				ingredientList.setTextFormat(switchFormat);
<<<<<<< .mine
=======
				//trace(ingredientsArray[ingredientsArray.length-1]);
>>>>>>> .r20
				ingredients.text = "";
			}
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
						recipeDisplay.addChild(recipeWords);
						recipeDisplay.addChild(recipeLabels);
						recipeDisplay.addChild(recipeGrill);
						recipeDisplay.addChild(recipeBack);
						recipeDisplay.addChild(recipeNext);
				recipeDisplay.x = 50000;
				
				recipeGrill.addEventListener(MouseEvent.MOUSE_UP, startGrilling);
				recipeGrill.addEventListener(MouseEvent.MOUSE_UP, closeOverlays);
				ingredientSearch.removeEventListener(MouseEvent.MOUSE_UP, showRecipes);
			}
			fajitas = 0;
			burgers = 0;
			
			for(var i:Number = 0; i <= ingredientsArray.length; i++) {
				
				if(ingredientsArray[i] == "cheese" || ingredientsArray[i] == "chicken" || ingredientsArray[i] == "salsa" || ingredientsArray[i] == "tortillas" && fajitas == 0) {
					//                    title   prep    cook      desc                        pic          ing     ing    ing   ing
					recipeResults.push("Fajitas\n10 min.\n20 min.\nA Mexican dish that is awesome\nChicken\nCheese\nSalsa\nTortillas");
					fajitas = 1;
				}
				
				if(ingredientsArray[i] == "beef" || ingredientsArray[i] == "cheese" || ingredientsArray[i] == "buns" || ingredientsArray[i] == "onions" && burgers == 0) {
					recipeResults.push("Burgers\n10 min.\n25 min.\nAn All-American classic!\nGround beef\nCheese\nBurger buns\nOnions");
					burgers = 1;
				}
			}
			slideRecipe();
		}
		
		function startGrilling(event:MouseEvent):void {
			recipeGrill.removeEventListener(MouseEvent.MOUSE_UP, startGrilling);
			mc_mainScreen.addChild(flameBorder);
			mc_mainScreen.addChild(flame);
			flameBorder.mouseEnabled = false;
			flameBorder.mouseChildren = false;
			flame.buttonMode = true;
			
			var dragMask:Sprite = new Sprite();
			dragMask.graphics.beginFill(0xFFFFFF);
			dragMask.graphics.drawRect(1000, 73, 52, 230);
			
			mc_mainScreen.addChild(dragMask);
			
			dragMask.alpha = 0;
			dragMask.mouseEnabled = false;
			
			flame.mask = dragMask;
			
			flame.x = 1002;
			flame.y = 75;
			flame.width = 50;
			flameBorder.x = 1000;
			flameBorder.y = 105;
			flameBorder.width = 51;
			
			
			barLine.graphics.beginFill(0xFFFFFF);
			barLine.graphics.drawRect(10, 50, 90, 1);
			flame.addChild(barLine);
			
			flameBorder.addChild(tempDisplay);
			
			tempDisplay.type = TextFieldType.DYNAMIC;
				tempDisplay.text = "500°";
				tempDisplay.x = 3;
				tempDisplay.y = -30;
				tempDisplay.width = 60;
				tempDisplay.height = 30;
				tempDisplay.setTextFormat(tempFormat);
				
			flame.addEventListener(MouseEvent.MOUSE_DOWN, flameDrag);
			flame.addEventListener(MouseEvent.MOUSE_UP, flameDrop);
			
			myTimer.start();
			//var timelineTween:Tween = new Tween(timelineScroller, "x", null, timelineScroller.x,1000,400, true);
		}
		
		function timelineTimer(event:TimerEvent):void {
			timelineScroller.x++;
			
			if(currentState == 1) { // if Auto
				if(timelineScroller.x == 100.5) {
					trace("first event");
				}
				else if(timelineScroller.x == 226.5) {
					trace("second event");
				}
				else if(timelineScroller.x == 352.5) {
					trace("third event");
				}
				else if(timelineScroller.x == 478.5) {
					trace("fourth event");
				}
				else if(timelineScroller.x == 604.5) {
					trace("fifth event");
				}
				else if(timelineScroller.x == 730.5) {
					trace("sixth event");
				}
				else if(timelineScroller.x == 856.5) {
					trace("seventh event");
				}
			}
		}
		
		function alert():void {
			timeline.gotoAndStop(2);
			timeline.gotoAndStop(1);
		}
		
		var flameBind:Rectangle = new Rectangle(1002, 75, 0, 165);  
		
		function flameDrag(event:MouseEvent):void {
			flame.startDrag(false, flameBind);
		}
		
		function flameDrop(event:MouseEvent):void {
			flame.stopDrag();
			tempDisplay.text = Math.abs(148-flame.y)*3 + "°";
			tempDisplay.setTextFormat(tempFormat);
		}
		
		function slideRecipe() {
			if(ingredientOutline.x == 400) {
				ingredientStuff = new Tween(ingredientOutline, "x", Strong.easeIn, 400,0,0.5, true);
				recipeDisplay.x = 542.0;
				recipeDisplay.y = 28.7;
				recipeGrill.x = 100.0;
				recipeGrill.y = 446.9;
				recipeBack.x = 152.0;
				recipeBack.y = 539.6;
				recipeBack.addEventListener(MouseEvent.MOUSE_DOWN, recipeSeekBack);
				recipeNext.x = 453.7;
				recipeNext.y = 539.6;
				recipeNext.addEventListener(MouseEvent.MOUSE_DOWN, recipeSeekNext);
				recipeWords.x = 220;
				recipeWords.y = 50;
				recipeWords.height = 500;
				recipeWords.width = 600;
				recipeLabels.x = 100;
				recipeLabels.y = 50;
				recipeLabels.height = 500;
				recipeLabels.width = 100;
				recipeLabels.text = "Recipe:\nPrep Time:\nCook Time:\nDescription:\nIngredients:";
				recipeLabels.setTextFormat(recipeFormat);
				recipeDisplayStart = new Tween(recipeDisplay, "alpha", Strong.easeIn, 0,1,1, true);
			}
			else {
				ingredientSearch.removeEventListener(MouseEvent.MOUSE_UP, showRecipes);
			}
			
			recipeWords.text = recipeResults[recipeIndex];
			recipeWords.setTextFormat(switchFormat);
		}
		
		function recipeSeekBack(event:MouseEvent):void {
			if(recipeIndex-1 >= 0) {
				recipeIndex--;
				recipeWords.text = recipeResults[recipeIndex];
				recipeWords.setTextFormat(switchFormat);
			}
		}
		
		function recipeSeekNext(event:MouseEvent):void {
			if(recipeIndex+1 <= recipeResults.length-1) {
				recipeIndex++;
				recipeWords.text = recipeResults[recipeIndex];
				recipeWords.setTextFormat(switchFormat);
			}
		}
		
		function textFocus(event:FocusEvent):void {
			ingredients.text = "";
		}
		
		function textFocusOut(event:FocusEvent):void {
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