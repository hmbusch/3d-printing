function main(params) {
    checkParameters(params);
    var body = difference(
        cube({size: [params.beamWidth, 30, 5], center: [false, true, false]}),
        screwAndNutCutout(),
        mirror([1, 0, 0], screwAndNutCutout()).translate([params.beamWidth, 0, 0])
    );

    if (params.cutoutPercentage > 0) {
        body = body.subtract(centerCutout(params.beamWidth, params.cutoutPercentage));
    }

    return body.translate([params.beamWidth/-2, 0, 0])
}

function centerCutout(beamWidth, cutoutPercentage) {
    var availableSpace = (beamWidth - 55) * (cutoutPercentage / 100);
    //throw new Error(availableSpace);
    var cutoutOffset = (beamWidth - 55 - availableSpace) / 2 + 55/2;

    return linear_extrude({height: 5},
        hull(
            circle({r: 7.5, center: true}).translate([cutoutOffset, 0, 0]),
            circle({r: 7.5, center: true}).translate([cutoutOffset + availableSpace, 0, 0])
        )
    )
}

function screwAndNutCutout() {
    return union(
        cube({size: [5, 10, 5], center: [false, true, false]}),
        cube({size: [14, 3.3, 5], center: [false, true, false]}).translate([5, 0, 0]),
        cube({size: [3, 5.6, 5], center: [false, true, false]}).translate([9, 0, 0])
    );
}

function checkParameters(params) {
    if (params.beamWidth < 40) {
        throw new Error("The beam cannot be smaller than 40mm, this is the smallest viable size");
    }
    if (params.cutoutPercentage < 0 || params.cutoutPercentage > 100) {
        throw new Error("The cutout percentage must be a value between 0 and 100");
    }
}

function getParameterDefinitions() {
  return [
      { name: 'beamWidth', type: 'float', initial: 130, caption: "Width of the beam"},
      { name: 'cutoutPercentage', type: 'float', initial: 80, min: 0, max: 100, caption: "Width of the cutout in percent of available space"},
  ];
}
