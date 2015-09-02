﻿/* ***********************************************************************AS3 class by Barbara Kaskosz and Dan Grieshttp://www.flashandmath.com/Last modified: January 18, 2011************************************************************************ */package flashandmath.as3 {		import flash.display.Sprite;		import flash.display.Shape;		import flash.display.GradientType;		import flash.display.BitmapData;			import flash.geom.Matrix;		import flash.geom.Point;		    public  class LiveKaleidoscope extends Sprite {		 	    private var imageData:BitmapData;				private var picWidth:Number;				private var picHeight:Number;				private var hexRad:Number;				private var ang:Number;				private var numCols:int;				private var numRows:int;				private var triangleSide:Number;				private var triangleHeight:Number;				private var hexesArray:Array;				private var container:Sprite;				private var isReady:Boolean;				private var wedgeEven:Shape;				private var wedgeOdd:Shape;				private var wedgesArray:Array;				private var maskShape:Shape;				private var areaWidth:Number;				private var areaHeight:Number;				private var displayWidth:Number;				private var displayHeight:Number;				//Constructor.		  	    public function LiveKaleidoscope(bd:BitmapData,hr:Number,w:Number=1368,h:Number=1524){						hexRad=hr;			            ang=60;			triangleSide=hexRad;						triangleHeight=Math.tan(Math.PI/3)*triangleSide/2;						displayWidth=w;						displayHeight=h;						isReady=false;						container=new Sprite();						this.addChild(container);						imageData = bd;  //Setting bitmap by reference rather than cloning as in other version.						initApp();		}				//End of constructor.		  private function initApp():void {	 	   picWidth=imageData.width;	 	   picHeight=imageData.height;	        createDisplay();	   	   drawDisplay();	 	   isReady=true;	   }     private function createDisplay():void {		 var i:int;	 	 var j:int;	 	 var k:int;	 	 numCols=Math.ceil(displayWidth/(3/2*triangleSide))+1;	 	 numRows=Math.ceil(displayHeight/(2*triangleHeight))+1;	  	 areaWidth=numCols*3/2*triangleSide+triangleSide/2;	 trace(areaWidth);	 	 areaHeight=numRows*2*triangleHeight+triangleHeight;	 trace(areaHeight);	 container.x=-areaWidth/2;	 	 container.y=-areaHeight/2;	 	 wedgeEven= new Shape();			 wedgeOdd=new Shape();	 	 maskShape=new Shape();	 	 this.addChild(maskShape);	 	 drawMask();	  	 container.mask=maskShape;	 	 hexesArray=[];	 	 wedgesArray=[];	 	 for(i=0;i<numRows;i++){		 		 hexesArray[i]=[];		 		 wedgesArray[i]=[];		 		 for(j=0;j<numCols;j++){			 			 wedgesArray[i][j]=[];			 			 hexesArray[i][j]=new Sprite();			 			 container.addChild(hexesArray[i][j]);			 			 hexesArray[i][j].x=3/2*triangleSide*j+triangleSide;			 			 if(j%2==0){			 			 hexesArray[i][j].y=2*triangleHeight*i+triangleHeight;			 			 } else {				 				 hexesArray[i][j].y=2*triangleHeight*i+2*triangleHeight;				 			 }			 			 for(k=0;k<6;k++){				 				 wedgesArray[i][j][k]=new Shape();				 				 hexesArray[i][j].addChild(wedgesArray[i][j][k]);				 				 wedgesArray[i][j][k].rotation=k*ang;				 				 				 }			 		 }			 }		  } private function drawDisplay():void {		var i:int;		var j:int;	 	var k:int;		var mat:Matrix=new Matrix();		mat.translate(picWidth/2,0);		var mat2:Matrix=mat.clone();		mat2.concat(new Matrix(-1,0,0,1,0,0));		wedgeEven.graphics.clear();		wedgeOdd.graphics.clear();		for(i=0;i<numRows;i++){		 		 for(j=0;j<numCols;j++){			 			 for(k=0;k<6;k++){				 				 wedgesArray[i][j][k].graphics.clear();				 				 }			 		 }		 	 }		wedgeEven.graphics.lineStyle();		wedgeEven.graphics.beginBitmapFill(imageData,mat,true,true);		wedgeEven.graphics.moveTo(0,0);		wedgeEven.graphics.lineTo(-triangleSide/2,-triangleHeight);		wedgeEven.graphics.lineTo(triangleSide/2,-triangleHeight);		wedgeEven.graphics.lineTo(0,0);		wedgeEven.graphics.endFill();			wedgeOdd.graphics.lineStyle();		wedgeOdd.graphics.beginBitmapFill(imageData,mat2,true,true);		wedgeOdd.graphics.moveTo(0,0);		wedgeOdd.graphics.lineTo(-triangleSide/2,-triangleHeight);		wedgeOdd.graphics.lineTo(triangleSide/2,-triangleHeight);		wedgeOdd.graphics.lineTo(0,0);		wedgeOdd.graphics.endFill();			for(i=0;i<numRows;i++){		 		 for(j=0;j<numCols;j++){			 			 for(k=0;k<6;k++){				 				 if (k % 2 == 0) {					 			wedgesArray[i][j][k].graphics.copyFrom(wedgeEven.graphics);		}				else {						wedgesArray[i][j][k].graphics.copyFrom(wedgeOdd.graphics);		}				 				 }			 		 }		 	 }}   private function drawMask():void {	   		   	   maskShape.graphics.beginFill(0x000000,0);	 	   maskShape.graphics.drawRect(-displayWidth/2,-displayHeight/2,displayWidth,displayHeight);	 	   maskShape.graphics.endFill();	      }	 	public function doSpin():void {	 	 if(isReady){		    drawDisplay();		 }  }     //You may want to call 'destroy' method if you wish to dispose of your instance    //of LiveKaleidoscope at runtime.    public function destroy():void {	  	  var i:int;	  	  var j:int;	 	  var k:int;	  	  if(!isReady){		  		return;			  }	  	  for(i=0;i<numRows;i++){		 		 for(j=0;j<numCols;j++){			 			 for(k=0;k<6;k++){				 				 wedgesArray[i][j][k].graphics.clear();				 				 }			 		 }		 	 }	   	    imageData.dispose();	  		isReady=false;	      }    	 } }