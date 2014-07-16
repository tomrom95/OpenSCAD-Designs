//
//if (accessories=="ON"){
//	color([222/255,184/255,135/255]) translate([-50,33.5,-3]) board();
//	translate([-10,15,0]) Arduino(0,0,0);
//} 
//if (mode=="EXPLODED"){
//	baseWCuts();
//	translate([-45,-80,30]) backDoor();
//	translate([0,30,30]) frontPanel();
//	translate([0,30,30]) mirror([1,0,0]) frontPanel();
//}
//if (mode=="ASSEMBLED"){
//	baseWCuts();
//	translate([-45,-50,0]) backDoor();
//	frontPanel();
//	mirror([1,0,0]) frontPanel();
//}
//if (mode=="PARTS"){
//	baseWCuts();
//	translate([280,-10,40]) rotate([270,0,0]) frontPanel();
//	translate([-250,0,10]) rotate([270,0,0]) backDoor();
//	translate([230,-10,40]) mirror([1,0,0]) rotate([270,0,0]) frontPanel();
//
//}

translate([135,-30,0]) frontPanel();

//
///////////////////////////////
/* MAIN CONSTRUCTOR MODULES */
//////////////////////////////


//Creates exact front panel with cuts using frontPanelBasic()
module frontPanel(){ 
	difference(){
		translate([-126.5,52,0]) frontPanelBasic();
		baseWCuts();
		translate([-50,33.5,-3]) board();
		translate([65,10,95]) rotate([90,0,0]) cylinder(r=6.5,h=20);
		translate([-58,72.5,-10]) cylinder(r=3.25,h=20);//cuts panel screw holes
		translate([-84,72.5,-10]) cylinder(r=3.25,h=20);
	}
}

//Creates basic block front panel without cuts
module frontPanelBasic(){ 
	union(){
		cube([81.5,8,80]);
		translate([31.5,0,-3]) cube([50,33,8]);
		translate([73.5,-20,-5]) cube([8,20,85]);
		translate([-6.5,-23,0]) cube([8,31,80]);
	}
}

//Creates full base with sides, floor, and all necessary cuts
module baseWCuts(){
	difference(){
		base();
		translate([-50,33.5,-3]) board(); //cuts board
		translate([-10,15,0]) Arduino(0,0,0); //cuts arduino
		translate([-45,-50,0]) backDoor(); //cuts back door
		translate([-70,55,-3]) cube([140,30,3]); //cuts indent in prongs
		translate([-62.5,10,95]) rotate([90,0,0]) cylinder(r=3.25,h=20); //cuts hanger
		translate([62.5,10,95]) rotate([90,0,0]) cylinder(r=3.25,h=20);
		translate([-58,72.5,-10]) cylinder(r=3.25,h=20);//cuts panel screw holes
		translate([-84,72.5,-10]) cylinder(r=3.25,h=20);
		translate([58,72.5,-10]) cylinder(r=3.25,h=20);
		translate([84,72.5,-10]) cylinder(r=3.25,h=20);
		translate([-53,-5,2]) cube([15,15,15]); //cuts arduino extension port
		translate([-50,36.5,-3]) cube([100,20,3]);
	}
}

//Creates simple base with floor and sides
module base(){
	union(){
		translate([-53,-50,-8]) floor();
		translate([-53,-50,0]) sides();
		translate([-80,-4,80]) cube([35,12,25]); //creates top hinges 
		translate([45,-4,80]) cube([35,12,25]);
	}
}

//Creates back door that will fit into slots in the base.
module backDoor(){
	union(){
		cube([90,8,80]);
	
		translate([19.75,1.5,-5]) cube([5,5,5]); //bottom notches
		translate([44.5,1.5,-5]) cube([5,5,5]);
		translate([69.25,1.5,-5]) cube([5,5,5]);
	
		translate([-5,3,75]) cube([5,5,5]);//top notches
		translate([90,3,75]) cube([5,5,5]);
	
		translate([23,0,40]) rotate([90,0,0]) scale([1,1,1.5]) drawtext("metaLab."); //text
	}
}

//Creates walls including slants
module sides(){

	cube([8,85,80]);
	translate([98,0,0]) cube([8,85,80]);
	translate([-80,70,0]) slant();
	translate([186,70,0]) mirror([1,0,0]) slant();

}

//creates slanted L shaped wall
module slant(){
	polyhedron(
	points = [ [0,0,0],[80,0,0],[0,10,0],[8,10,0],[8,8,0], [80,8,0],
				[0,-20,80],[80,-20,80],[0,10,80],[8,10,80],[8,-12,80],
				[80,-12,80] ],

	faces = [ [0,1,5,4,3,2] ,[6,8,9,10,11,7], [2,8,6,0],
				[0,6,7,1], [1,7,11,5], [5,11,10,4], [4,10,9,3],
				[3,9,8,2]]


	);
}

//Creates floor of the enclosure
module floor(){
	union(){
		cube([106,86,8]);
		
		translate([-80,70,0]) cube([80,40,8]);//wings
		translate([106,70,0]) cube([80,40,8]);
	
		translate([-42,85,0]) cube([50,50,8]); //prongs
		translate([98,85,0]) cube([50,50,8]);
		diagonal();
		translate([106,0,0]) mirror([1,0,0]) diagonal();
	}
}

//Creates triangle inlet for floor
module diagonal(){
	polyhedron(
		points = [ [0,50,0],[0,70,0],[-20,70,0],[0,50,8],[0,70,8],[-20,70,8]],
		faces = [ [2,1,0],[3,4,5],[2,0,3,5],[0,1,4,3],[1,2,5,4] ]
	);
}

//Models enclosed circuit board
module board(){
	union(){
		cube([100,3,85]);
		translate([-87.5,-6,11.25]) cube([95,16,16]);//left
		translate([-87.5,-6,31.75]) cube([95,16,16]);
		translate([-87.5,-6,52.25]) cube([95,16,16]);
	
		translate([92.5,-6,11.25]) cube([95,16,16]);//right
		translate([92.5,-6,31.75]) cube([95,16,16]);
		translate([92.5,-6,52.25]) cube([95,16,16]);
	}
}

/////////////////////////
//TEXT DRAWING MODULES//
////////////////////////
//You can ignore these//

module drawtext(text) {
	//Characters
	chars = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}";

	//Chracter table defining 5x7 characters
	//Adapted from: http://www.geocities.com/dinceraydin/djlcdsim/chartable.js
	char_table = [ [ 0, 0, 0, 0, 0, 0, 0],
                  [ 4, 0, 4, 4, 4, 4, 4],
                  [ 0, 0, 0, 0,10,10,10],
                  [10,10,31,10,31,10,10],
                  [ 4,30, 5,14,20,15, 4],
                  [ 3,19, 8, 4, 2,25,24],
                  [13,18,21, 8,20,18,12],
                  [ 0, 0, 0, 0, 8, 4,12],
                  [ 2, 4, 8, 8, 8, 4, 2],
                  [ 8, 4, 2, 2, 2, 4, 8],
                  [ 0, 4,21,14,21, 4, 0],
                  [ 0, 4, 4,31, 4, 4, 0],
                  [ 8, 4,12, 0, 0, 0, 0],
                  [ 0, 0, 0,31, 0, 0, 0],
                  [12,12, 0, 0, 0, 0, 0],
                  [ 0,16, 8, 4, 2, 1, 0],
                  [14,17,25,21,19,17,14],
                  [14, 4, 4, 4, 4,12, 4],
                  [31, 8, 4, 2, 1,17,14],
                  [14,17, 1, 2, 4, 2,31],
                  [ 2, 2,31,18,10, 6, 2],
                  [14,17, 1, 1,30,16,31],
                  [14,17,17,30,16, 8, 6],
                  [ 8, 8, 8, 4, 2, 1,31],
                  [14,17,17,14,17,17,14],
                  [12, 2, 1,15,17,17,14],
                  [ 0,12,12, 0,12,12, 0],
                  [ 8, 4,12, 0,12,12, 0],
                  [ 2, 4, 8,16, 8, 4, 2],
                  [ 0, 0,31, 0,31, 0, 0],
                  [16, 8, 4, 2, 4, 8,16],
                  [ 4, 0, 4, 2, 1,17,14],
                  [14,21,21,13, 1,17,14],
                  [17,17,31,17,17,17,14],
                  [30,17,17,30,17,17,30],
                  [14,17,16,16,16,17,14],
                  [30,17,17,17,17,17,30],
                  [31,16,16,30,16,16,31],
                  [16,16,16,30,16,16,31],
                  [15,17,17,23,16,17,14],
                  [17,17,17,31,17,17,17],
                  [14, 4, 4, 4, 4, 4,14],
                  [12,18, 2, 2, 2, 2, 7],
                  [17,18,20,24,20,18,17],
                  [31,16,16,16,16,16,16],
                  [17,17,17,21,21,27,17],
                  [17,17,19,21,25,17,17],
                  [14,17,17,17,17,17,14],
                  [16,16,16,30,17,17,30],
                  [13,18,21,17,17,17,14],
                  [17,18,20,30,17,17,30],
                  [30, 1, 1,14,16,16,15],
                  [ 4, 4, 4, 4, 4, 4,31],
                  [14,17,17,17,17,17,17],
                  [ 4,10,17,17,17,17,17],
                  [10,21,21,21,17,17,17],
                  [17,17,10, 4,10,17,17],
                  [ 4, 4, 4,10,17,17,17],
                  [31,16, 8, 4, 2, 1,31],
                  [14, 8, 8, 8, 8, 8,14],
                  [ 0, 1, 2, 4, 8,16, 0],
                  [14, 2, 2, 2, 2, 2,14],
                  [ 0, 0, 0, 0,17,10, 4],
                  [31, 0, 0, 0, 0, 0, 0],
                  [ 0, 0, 0, 0, 2, 4, 8],
                  [15,17,15, 1,14, 0, 0],
                  [30,17,17,25,22,16,16],
                  [14,17,16,16,14, 0, 0],
                  [15,17,17,19,13, 1, 1],
                  [14,16,31,17,14, 0, 0],
                  [ 8, 8, 8,28, 8, 9, 6],
                  [14, 1,15,17,15, 0, 0],
                  [17,17,17,25,22,16,16],
                  [14, 4, 4, 4,12, 0, 4],
                  [12,18, 2, 2, 2, 6, 2],
                  [18,20,24,20,18,16,16],
                  [14, 4, 4, 4, 4, 4,12],
                  [17,17,21,21,26, 0, 0],
                  [17,17,17,25,22, 0, 0],
                  [14,17,17,17,14, 0, 0],
                  [16,16,30,17,30, 0, 0],
                  [ 1, 1,15,19,13, 0, 0],
                  [16,16,16,25,22, 0, 0],
                  [30, 1,14,16,15, 0, 0],
                  [ 6, 9, 8, 8,28, 8, 8],
                  [13,19,17,17,17, 0, 0],
                  [ 4,10,17,17,17, 0, 0],
                  [10,21,21,17,17, 0, 0],
                  [17,10, 4,10,17, 0, 0],
                  [14, 1,15,17,17, 0, 0],
                  [31, 8, 4, 2,31, 0, 0],
                  [ 2, 4, 4, 8, 4, 4, 2],
                  [ 4, 4, 4, 4, 4, 4, 4],
                  [ 8, 4, 4, 2, 4, 4, 8] ];

	//Binary decode table
	dec_table = [ "00000", "00001", "00010", "00011", "00100", "00101",
  	            "00110", "00111", "01000", "01001", "01010", "01011",
  	            "01100", "01101", "01110", "01111", "10000", "10001",
  	            "10010", "10011", "10100", "10101", "10110", "10111",
	            "11000", "11001", "11010", "11011", "11100", "11101",
	            "11110", "11111" ];

	//Process string one character at a time
	for(itext = [0:len(text)-1]) {
		//Convert character to index
		assign(ichar = search(text[itext],chars,1)[0]) {
			//Decode character - rows
			for(irow = [0:6]) {
				assign(val = dec_table[char_table[ichar][irow]]) {
					//Decode character - cols
					for(icol = [0:4]) {
						assign(bit = search(val[icol],"01",1)[0]) {
							if(bit) {
								//Output cube
								translate([icol + (6*itext), irow, 0])
									cube([1.0001,1.0001,1]);
							}
						}
					}
				}
			}
		}
	}
}


////////////////////////////
//ARDUINO DRAWING MODULES//
///////////////////////////
//You can ignore these//

board_height = 4;

module Arduino(solid_holes, combined_headers, extend_ports)
{
	echo(str("solid_holes: ", solid_holes));
	echo(str("combined_headers: ", combined_headers));
	echo(str("extend_ports: ", extend_ports));

	if (solid_holes == 1)
	{
		echo("solid holes");
		union()
		{
			Board();
			USB(extend_ports);
			PowerPlug(extend_ports);
			FemaleHeaders(combined_headers);
			MaleHeaders();
			ResetButton();
			ATMega();
			MountingHoles();
		}
	}
	else
	{
		echo("regular holes");
		difference()
		{
			union()
			{
				Board();
				USB(extend_ports);
				PowerPlug(extend_ports);
				FemaleHeaders(combined_headers);
				MaleHeaders();
				ResetButton();
				ATMega();
			}
			MountingHoles();
		}
	}
}

module ResetButton()
{
	translate([39, -26, board_height])
	{
		color([0.8, 0.8, 0.8])
		cube([6, 6, 2.2]);
		
		color([0.6, 0.4, 0.2])
		translate([3, 3, 0]) cylinder(r=1.4, h=3.5, $fn=25);
	}
}

module MaleHeaders()
{
	color([0.6, 0.6, 0.6])
	translate([0, 0, board_height])
	{
		translate([0, -7, 0]) cube([7, 5, 9.2]);
		translate([47.5, -26, 0]) cube([5, 7, 9.2]);
	}
}

module ATMega()
{
	color([0.3, 0.3, 0.3])
	translate([14, -39, board_height])
	{
		cube([35.5, 10, 7.5]);
	}
}

module FemaleHeaders(combined)
{
	color([0.3, 0.3, 0.3])
	translate([0, 0, board_height])
	{
		translate([0, -1, 0])
		{
			translate([7, 0, 0])
			{
				if(combined == 1)
				{
					cube([43, 2, 8.2]);
				}
				else
				{
					cube([21, 2, 8.2]);
					translate([22, 0, 0]) cube([21, 2, 8.2]);
				}
			}
		}

		translate([0, -50, 0])
		{
			translate([17, 0, 0])
			{
				if(combined == 1)
				{
					cube([33, 2, 8.2]);
				}
				else
				{
					cube([15.5, 2, 8.2]);
					translate([17.5, 0, 0]) cube([15.5, 2, 8.2]);
				}
			}
		}
	}
}

module PowerPlug(extended)
{
	if(extended == 1)
	{
		translate([-26.893, -47.4929962, board_height])
		color([0.3, 0.3, 0.3])
		cube([24, 9, 11]);
	}
	else
	{
		translate([-16.893, -47.4929962, board_height])
		color([0.3, 0.3, 0.3])
		cube([14, 9, 11]);
	}
}

module USB(extended)
{
	if(extended == 1)
	{
		translate([-31.465, -18.5623962, board_height])
		color([0.8, 0.8, 0.8])
		cube([26, 12, 11]);
	}
	else
	{
		translate([-61.465, -18.5623962, board_height])
		color([0.8, 0.8, 0.8])
		cube([56, 12, 11]);
	}
}


module Board()
{
	color([0, 0.6, 0.8])
	linear_extrude(height = board_height, convexity = 10, twist = 0)
	{
		polygon( points = [ [-15.115, 2.545],
						[49.4, 2.545],
						[50.925, 1.021],
						[50.925, -10.409],
						[53.465, -12.949],
						[53.465, -45.715],
						[50.925, -48.255],
						[50.925, -50.795],
						[-15.115, -50.795] ],
				paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8]],
				convexity = 10);
	}
}

module MountingHoles()
{
	translate([0, 0, -10])
	{
		ArduinoHole(25);
		translate([-1.0929112, -48.4026972, 0]) ArduinoHole(25);
		translate([51, -15.25, 0]) ArduinoHole(25);
		translate([51, -43.25, 0]) ArduinoHole(25);
	}
}

module ArduinoHole(length)
{
	color([0.7, 0.7, 0.7])
	cylinder(r=1.5, h=length, $fn=25);
}