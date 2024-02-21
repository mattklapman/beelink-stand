// Beelink Mini S12 Pro Vertical Desktop Stand
// 2023 Matt Klapman

// OpenSCAD units are millimeters

customSupport = 1; // set to 0 for no custom support

$fn=60; // number of resolved facets on curves

include <BOSL/constants.scad>
use <BOSL/shapes.scad>

nozzleDiameter = 0.4; // used for constructed supports

wallThickness = 8;

clearance = 0.5; // allow some space as 3D printing isn't perfect

// from a horizontal view looking at the front
miniWidth = 115.35 + clearance;  // measurement left to right
miniLength = 102.35 + clearance; // measurement front to back
//mini12Height = 38.25 + clearance; // without feet
miniHeight = 39.6 + clearance; // with feet
miniRadial = 6; // corners (eyeballed)

miniLedge = 10; // from each outer edge of mini to not block vents
bottomAirGap = 10; // height off of the desk

renderHelp = 0.001; // used during development to correct visual artifacts in OpenSCAD (OK to print with this)

module stand(sideAngleFactor)
{
    // sideAngleFactor is a lazy way to make a straight side (=1) or a wider base (=1.8)

    topWidth = miniHeight + 2 * wallThickness;

    difference()
    {
        translate([0, 0, 0]) rounded_prismoid(size1=[sideAngleFactor * topWidth, 1.2 * miniLength], size2=[topWidth, 0.5 * miniLength], h=bottomAirGap + 0.4 * miniWidth, r=miniRadial, $fn=24);    
        {
        // cut out mini
        translate([0, 0, bottomAirGap + miniWidth/2]) cuboid([miniHeight, miniLength, miniWidth], center=true, fillet=6, edges=EDGES_X_ALL);
        // cut out hole below mini
        translate([0, 0, 0]) cube([miniHeight, miniLength - 2 * miniLedge, miniWidth * 2], center=true);
        // cut out bottom side vents
        translate([0, 0, -renderHelp]) rounded_prismoid(size1=[4 * miniHeight, miniLength - 2 * miniLedge], size2=[4 * miniHeight, miniLength - 4 * miniLedge], h=1.0 * bottomAirGap, r=miniRadial, $fn=24);
        }
    }
 
    if (customSupport != 0)
    {
        // add custom supports
        difference()
        {
            union()
            {
                translate([0, 0, 0]) rounded_prismoid(size1=[sideAngleFactor * topWidth, 8 * nozzleDiameter], size2=[sideAngleFactor * topWidth, nozzleDiameter], h=1.0 * bottomAirGap, r=0);
                translate([0, -(miniLength - 4 * miniLedge)/5, 0]) rounded_prismoid(size1=[sideAngleFactor * topWidth, 8 * nozzleDiameter], size2=[sideAngleFactor * topWidth, nozzleDiameter], h=1.0 * bottomAirGap, r=0);
                translate([0, (miniLength - 4 * miniLedge)/5, 0]) rounded_prismoid(size1=[sideAngleFactor * topWidth, 8 * nozzleDiameter], size2=[sideAngleFactor * topWidth, nozzleDiameter], h=1.0 * bottomAirGap, r=0);
                translate([0, 0, 1/2]) cube([sideAngleFactor * topWidth, 2 * ((miniLength - 4 * miniLedge)/5 + 8 * nozzleDiameter), 1], center=true);
            }
        translate([0, 0, 0]) cube([miniHeight, miniLength - 2 * miniLedge, miniWidth * 2], center=true);
        }
    }
}

module n100()
{
    color("blue") translate([0, 0, bottomAirGap + (miniWidth - clearance)/2]) cuboid([miniHeight - clearance, miniLength - clearance, miniWidth - clearance], center=true, fillet=6, edges=EDGES_X_ALL);
}

// 1 stand
stand(1.3);
n100();


// create 2 overlapping
/*
middleGap = 6.1 * wallThickness;

translate([-middleGap/2, 0, 0]) stand(1);
translate([ middleGap/2, 0, 0]) stand(1);

translate([-middleGap/2, 0, 0]) n100();
translate([ middleGap/2, 0, 0]) n100();
*/