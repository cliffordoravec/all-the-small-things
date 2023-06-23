import Toybox.Lang;
import Toybox.System;
import Toybox.Test;
import Toybox.Weather;

class ConversionTests {
    (:test)
    function testSystemDistanceUnitMetric(logger as Logger) as Boolean {
        var units = System.UNIT_METRIC;
        var expected = "km";
        var actual = Conversions.systemDistanceUnit(units);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testSystemDistanceUnitStatute(logger as Logger) as Boolean {
        var units = System.UNIT_STATUTE;
        var expected = "mi";
        var actual = Conversions.systemDistanceUnit(units);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

        (:test)
    function testSystemHeightUnitMetric(logger as Logger) as Boolean {
        var units = System.UNIT_METRIC;
        var expected = "m";
        var actual = Conversions.systemHeightUnit(units);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testSystemHeightUnitStatute(logger as Logger) as Boolean {
        var units = System.UNIT_STATUTE;
        var expected = "ft";
        var actual = Conversions.systemHeightUnit(units);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testCelsiusToSystemTemperatureMetric(logger as Logger) as Boolean {
        var c = 17;
        var units = System.UNIT_METRIC;
        var expected = 17;
        var actual = Math.round(Conversions.celsiusToSystemTemperature(c, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCelsiusToSystemTemperatureStatute(logger as Logger) as Boolean {
        var c = 17;
        var units = System.UNIT_STATUTE;
        var expected = 63;
        var actual = Math.round(Conversions.celsiusToSystemTemperature(c, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersToSystemHeightMetric(logger as Logger) as Boolean {
        var m = 3.048;
        var units = System.UNIT_METRIC;
        var expected = 3;
        var actual = Math.round(Conversions.metersToSystemHeight(m, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersToSystemHeightStatute(logger as Logger) as Boolean {
        var m = 3.048;
        var units = System.UNIT_STATUTE;
        var expected = 10;
        var actual = Math.round(Conversions.metersToSystemHeight(m, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCentimetersToSystemDistanceMetric(logger as Logger) as Boolean {
        var cm = 200000;
        var units = System.UNIT_METRIC;
        var expected = 2;
        var actual = Math.round(Conversions.centimetersToSystemDistance(cm, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCentimetersToSystemDistanceStatute(logger as Logger) as Boolean {
        var cm = 160934;
        var units = System.UNIT_STATUTE;
        var expected = 1;
        var actual = Math.round(Conversions.centimetersToSystemDistance(cm, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testGramsToSystemWeightMetric(logger as Logger) as Boolean {
        var g = 67000;
        var units = System.UNIT_METRIC;
        var expected = 67;
        var actual = Math.round(Conversions.gramsToSystemWeight(g, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testGramsToSystemWeightStatute(logger as Logger) as Boolean {
        var g = 67000;
        var units = System.UNIT_STATUTE;
        var expected = 148;
        var actual = Math.round(Conversions.gramsToSystemWeight(g, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersPerSecondToSystemDistancePerHourMetric(logger as Logger) as Boolean {
        var ms = 3.75;
        var units = System.UNIT_METRIC;
        var expected = 14;
        var actual = Math.round(Conversions.metersPerSecondToSystemDistancePerHour(ms, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersPerSecondToSystemDistancePerHourStatute(logger as Logger) as Boolean {
        var ms = 3.75;
        var units = System.UNIT_STATUTE;
        var expected = 8;
        var actual = Math.round(Conversions.metersPerSecondToSystemDistancePerHour(ms, units));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCelsiusToFahrenheit(logger as Logger) as Boolean {
        var c = 17;
        var expected = 63;
        var actual = Math.round(Conversions.celsiusToFahrenheit(c));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCentimetersToMiles(logger as Logger) as Boolean {
        var cm = 160934;
        var expected = 1;
        var actual = Math.round(Conversions.centimetersToMiles(cm));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testCentimetersToKilometers(logger as Logger) as Boolean {
        var cm = 200000;
        var expected = 2;
        var actual = Math.round(Conversions.centimetersToKilometers(cm));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testGramsToPounds(logger as Logger) as Boolean {
        var g = 67000;
        var expected = 148;
        var actual = Math.round(Conversions.gramsToPounds(g));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testGramsToKilograms(logger as Logger) as Boolean {
        var g = 67000;
        var expected = 67;
        var actual = Math.round(Conversions.gramsToKilograms(g));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersPerSecondToMilesPerHour(logger as Logger) as Boolean {
        var ms = 3.75;
        var expected = 8;
        var actual = Math.round(Conversions.metersPerSecondToMilesPerHour(ms));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersPerSecondToKilometersPerHour(logger as Logger) as Boolean {
        var ms = 3.75;
        var expected = 14;
        var actual = Math.round(Conversions.metersPerSecondToKilometersPerHour(ms));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testMetersToFeet(logger as Logger) as Boolean {
        var m = 3.048;
        var expected = 10;
        var actual = Math.round(Conversions.metersToFeet(m));

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual == expected);
    }

    (:test)
    function testWindBearingToCardinalDirectionNorth(logger as Logger) as Boolean {
        var bearing = 0;
        var expected = "N";
        var actual = Conversions.windBearingToCardinalDirection(bearing);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testWindBearingToCardinalDirectionSouth(logger as Logger) as Boolean {
        var bearing = 180;
        var expected = "S";
        var actual = Conversions.windBearingToCardinalDirection(bearing);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testWindBearingToCardinalDirectionEast(logger as Logger) as Boolean {
        var bearing = 90;
        var expected = "E";
        var actual = Conversions.windBearingToCardinalDirection(bearing);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testWindBearingToCardinalDirectionWest(logger as Logger) as Boolean {
        var bearing = 270;
        var expected = "W";
        var actual = Conversions.windBearingToCardinalDirection(bearing);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }

    (:test)
    function testGetConditionText(logger as Logger) as Boolean {
        var condition = Weather.CONDITION_VOLCANIC_ASH;
        var expected = "Volcanic ash";
        var actual = Conversions.getConditionText(condition);

        logger.debug("expected = " + expected);
        logger.debug("actual = " + actual);

        return (actual.equals(expected));
    }
}