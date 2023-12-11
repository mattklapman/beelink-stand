// Beelink Mini S12 Pro Vertical Desktop Stand
// 2023 Matt Klapman

// OpenSCAD units are millimeters

$fn=60; // number of resolved facets on curves

include <BOSL/constants.scad>
use <BOSL/shapes.scad>

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

module stand()
{
    difference()
    {
        translate([0, 0, 0]) rounded_prismoid(size1=[1.8 * miniHeight, 1.2 * miniLength], size2=[miniHeight + 2 * wallThickness, 0.5 * miniLength], h=bottomAirGap + 0.4 * miniWidth, r=miniRadial, $fn=24);
        {
        // cut out mini
        translate([0, 0, bottomAirGap + miniWidth/2]) cuboid([miniHeight, miniLength, miniWidth], center=true, fillet=6, edges=EDGES_X_ALL);
        // cut out hole below mini
        translate([0, 0, 0]) cube([miniHeight, miniLength - 2 * miniLedge, miniWidth * 2], center=true);
        // cut out bottom side vents
        translate([0, 0, -renderHelp]) rounded_prismoid(size1=[4 * miniHeight, miniLength - 2 * miniLedge], size2=[4 * miniHeight, miniLength - 4 * miniLedge], h=1.0 * bottomAirGap, r=miniRadial, $fn=24);
        }
    }
}

stand();
color("blue") translate([0, 0, bottomAirGap + (miniWidth - clearance)/2]) cuboid([miniHeight - clearance, miniLength - clearance, miniWidth - clearance], center=true, fillet=6, edges=EDGES_X_ALL);