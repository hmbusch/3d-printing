/**
 * Ink Cartridge Stabilizer Ring for Pelikan Pura P40 Fountain Pen
 *
 * The Pelikan Pura P40 is a nice low-to-mid fountain pen and uses
 * standard international ink cartridges. Unfortunately, it lacks a 
 * close fitting guide channel for the cartridge, so that it can 
 * easily move sideways and even slide out.
 * This ring is supposed to be inserted into the section and reduces
 * the amount of play a cartridge or converter has.
 *
 * Copyright 2018, Hendrik Busch
 * https://github.com/hmbusch
 *
 * Licensed under Creative Commons Attribution Share Alike 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */

$fn = 128;

insetHeight = 9;
insetTopDia = 8.9;
insetBottomDia = 8.9;

cartridgeDiameter = 7.3;

color("Darkblue") difference()  {
    cylinder(d1 = insetBottomDia, d2 = insetTopDia, h = insetHeight);
    translate([0, 0, -0.1]) cylinder(d = cartridgeDiameter, h = insetHeight + 0.2);
}