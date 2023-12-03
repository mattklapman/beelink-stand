$fn=60;

//include <Chamfers-for-OpenSCAD/Chamfer.scad>; // chamferCube starts at 0,0,0 and renders into the positive quadrant
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

hotendDiameter = 0.4;

wallThickness = 8; // * hotendDiameter;

minisWidth = 115.35 + 0.5;
minisLength = 102.35 + 0.5;
//minis12Height = 38.25;
minisHeight = 39.6 + 0.5; // with feet
minisRadial = 6;
minisLedge = 10; // from each edge of mini to not block vents

bottomAirGap = 10; // height off of the desk

renderHelp = 0.001;

module base()
{
    difference()
    {
        translate([0, 0, 0]) rounded_prismoid(size1=[2 * minisHeight, 1.4 * minisLength], size2=[minisHeight + 2 * wallThickness, 0.5 * minisLength], h=bottomAirGap + 0.4 * minisWidth, r=minisRadial, $fn=24);
        {
        // cut out minis
        translate([0, 0, bottomAirGap + minisWidth/2]) cuboid([minisHeight, minisLength, minisWidth], center=true, fillet=6, edges=EDGES_X_ALL);
        // cut out hole below minis
        translate([0, 0, 0]) cube([minisHeight, minisLength - 2 * minisLedge, minisWidth * 2], center=true);
        // cut out bottom side vents
        translate([0, 0, -renderHelp]) rounded_prismoid(size1=[4 * minisHeight, minisLength - 2 * minisLedge], size2=[4 * minisHeight, minisLength - 4 * minisLedge], h=0.5 * bottomAirGap, r=minisRadial, $fn=24);
        }
    }
}

base();
//color("blue") translate([0, 0, bottomAirGap + minisWidth/2]) cuboid([minisHeight, minisLength, minisWidth], center=true, fillet=6, edges=EDGES_X_ALL);