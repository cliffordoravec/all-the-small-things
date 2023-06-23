import Toybox.Lang;
import Toybox.Math;
import Toybox.System;
import Toybox.Time;
import Toybox.Weather;

class Conversions {
    public function systemDistanceUnit(distanceUnits as Number) as String {
        if (distanceUnits == System.UNIT_METRIC) {
            return "km";
        }

        return "mi";
    }

    public function systemHeightUnit(heightUnits as Number) as String {
        if (heightUnits == System.UNIT_METRIC) {
            return "m";
        }

        return "ft";
    }

    public function celsiusToSystemTemperature(celsius as Number, temperatureUnits as Number) as Number {
        if (temperatureUnits == System.UNIT_METRIC) {
            return celsius;
        }

        return Math.round(Conversions.celsiusToFahrenheit(celsius)).toNumber();
    }

    public function metersToSystemHeight(meters as Float, heightUnits as Number) as Number {
        if (heightUnits == System.UNIT_METRIC) {
            return Math.round(meters).toNumber();
        }
        
        return Math.round(Conversions.metersToFeet(meters)).toNumber();
    }

    public function centimetersToSystemDistance(centimeters as Number, distanceUnits as Number) as Number {
        if (distanceUnits == System.UNIT_METRIC) {
            return Math.round(Conversions.centimetersToKilometers(centimeters)).toNumber();
        }

        return Math.round(Conversions.centimetersToMiles(centimeters)).toNumber();
    }

    public function gramsToSystemWeight(grams as Number, weightUnits as Number) as Number {
        if (weightUnits == System.UNIT_METRIC) {
            return Math.round(Conversions.gramsToKilograms(grams)).toNumber();
        }

        return Math.round(Conversions.gramsToPounds(grams)).toNumber();
    }

    public function metersPerSecondToSystemDistancePerHour(meters as Float, distanceUnits as Number) as Number {
        if (distanceUnits == System.UNIT_METRIC) {
            return Math.round(Conversions.metersPerSecondToKilometersPerHour(meters)).toNumber();
        }

        return Math.round(Conversions.metersPerSecondToMilesPerHour(meters)).toNumber();
    }

    public function celsiusToFahrenheit(celsius as Number) as Float {
        return (celsius * (9.0 / 5.0)) + 32.0;
    }

    public function centimetersToMiles(centimeters as Number) as Float {
        return (centimeters / 160900.0);
    }

    public function centimetersToKilometers(centimeters as Number) as Float {
        return (centimeters / 100000.0);
    }

    public function gramsToPounds(grams as Number) as Float {
        return (grams / 453.6);
    }

    public function gramsToKilograms(grams as Number) as Float {
        return (grams / 1000.0);
    }

    public function metersPerSecondToMilesPerHour(meters as Float) as Float {
        return (meters * 2.237);
    }

    public function metersPerSecondToKilometersPerHour(meters as Float) as Float {
        return (meters * 3.6);
    }

    public function metersToFeet(meters as Float) as Float {
        return Math.round(meters * 3.281);
    }

    public function windBearingToCardinalDirection(bearing as Number) as String {
        if (bearing >= 348.75 || bearing < 11.25) {
            return "N";
        }
        else if (bearing >= 11.25 && bearing < 33.75) {
            return "NNE";
        }
        else if (bearing >= 33.75 && bearing < 56.25) {
            return "NE";
        }
        else if (bearing >= 56.25 && bearing < 78.75) {
            return "ENE";
        }
        else if (bearing >= 78.75 && bearing < 101.25) {
            return "E";
        }
        else if (bearing >= 101.25 && bearing < 123.75) {
            return "ESE";
        }
        else if (bearing >= 123.75 && bearing < 146.25) {
            return "SE";
        }
        else if (bearing >= 146.25 && bearing < 168.75) {
            return "SSE";
        }
        else if (bearing >= 168.75 && bearing < 191.25) {
            return "S";
        }
        else if (bearing >= 191.25 && bearing < 213.75) {
            return "SSW";
        }
        else if (bearing >= 213.75 && bearing < 236.25) {
            return "SW";
        }
        else if (bearing >= 236.25 && bearing < 258.75) {
            return "WSW";
        }
        else if (bearing >= 258.75 && bearing < 281.25) {
            return "W";
        }
        else if (bearing >= 281.25 && bearing < 303.75) {
            return "WNW";
        }
        else if (bearing >= 303.75 && bearing < 326.25) {
            return "NW";
        }
        else if (bearing >= 326.25 && bearing < 348.75) {
            return "NNW";
        }
        else {
            return "??";
        }
    }
    
    public function getConditionText(condition as Number) as String {
        switch (condition) {
            case Weather.CONDITION_CLEAR:
                return "Clear";
            case Weather.CONDITION_PARTLY_CLOUDY:
                return "Partly cloudy";
            case Weather.CONDITION_MOSTLY_CLOUDY:
                return "Mostly cloudy";
            case Weather.CONDITION_RAIN:
                return "Rain";
            case Weather.CONDITION_SNOW:
                return "Snow";
            case Weather.CONDITION_WINDY:
                return "Windy";
            case Weather.CONDITION_THUNDERSTORMS:
                return "Thunderstorms";
            case Weather.CONDITION_WINTRY_MIX:
                return "Wintry mix";
            case Weather.CONDITION_FOG:
                return "Fog";
            case Weather.CONDITION_HAZY:
                return "Hazy";
            case Weather.CONDITION_HAIL:
                return "Hail";
            case Weather.CONDITION_SCATTERED_SHOWERS:
                return "Scattered showers";
            case Weather.CONDITION_SCATTERED_THUNDERSTORMS:
                return "Scattered thunderstorms";
            case Weather.CONDITION_UNKNOWN_PRECIPITATION:
                return "Unknown precipitation";
            case Weather.CONDITION_LIGHT_RAIN:
                return "Light rain";
            case Weather.CONDITION_HEAVY_RAIN:
                return "Heavy rain";
            case Weather.CONDITION_LIGHT_SNOW:
                return "Light snow";
            case Weather.CONDITION_HEAVY_SNOW:
                return "Heavy snow";
            case Weather.CONDITION_LIGHT_RAIN_SNOW:
                return "Light rain snow";
            case Weather.CONDITION_HEAVY_RAIN_SNOW:
                return "Heavy rain snow";
            case Weather.CONDITION_CLOUDY:
                return "Cloudy";
            case Weather.CONDITION_RAIN_SNOW:
                return "Rain snow";
            case Weather.CONDITION_PARTLY_CLEAR:
                return "Partly clear";
            case Weather.CONDITION_MOSTLY_CLEAR:
                return "Mostly clear";
            case Weather.CONDITION_LIGHT_SHOWERS:
                return "Light showers";
            case Weather.CONDITION_SHOWERS:
                return "Showers";
            case Weather.CONDITION_HEAVY_SHOWERS:
                return "Heavy showers";
            case Weather.CONDITION_CHANCE_OF_SHOWERS:
                return "Chance of showers";
            case Weather.CONDITION_CHANCE_OF_THUNDERSTORMS:
                return "Chance of thunderstorms";
            case Weather.CONDITION_MIST:
                return "Mist";
            case Weather.CONDITION_DUST:
                return "Dust";
            case Weather.CONDITION_DRIZZLE:
                return "Drizzle";
            case Weather.CONDITION_TORNADO:
                return "Tornado";
            case Weather.CONDITION_SMOKE:
                return "Smoke";
            case Weather.CONDITION_ICE:
                return "Ice";
            case Weather.CONDITION_SAND:
                return "Sand";
            case Weather.CONDITION_SQUALL:
                return "Squall";
            case Weather.CONDITION_SANDSTORM:
                return "Sandstorm";
            case Weather.CONDITION_VOLCANIC_ASH:
                return "Volcanic ash";
            case Weather.CONDITION_HAZE:
                return "Haze";
            case Weather.CONDITION_FAIR:
                return "Fair";
            case Weather.CONDITION_HURRICANE:
                return "Hurricane";
            case Weather.CONDITION_TROPICAL_STORM:
                return "Tropical storm";
            case Weather.CONDITION_CHANCE_OF_SNOW:
                return "Chance of snow";
            case Weather.CONDITION_CHANCE_OF_RAIN_SNOW:
                return "Chance of rain snow";
            case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN:
                return "Cloudy chance of rain";
            case Weather.CONDITION_CLOUDY_CHANCE_OF_SNOW:
                return "Cloudy chance of snow";
            case Weather.CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW:
                return "Cloudy chance of rain snow";
            case Weather.CONDITION_FLURRIES:
                return "Flurries";
            case Weather.CONDITION_FREEZING_RAIN:
                return "Freezing rain";
            case Weather.CONDITION_SLEET:
                return "Sleet";
            case Weather.CONDITION_ICE_SNOW:
                return "Ice snow";
            case Weather.CONDITION_THIN_CLOUDS:
                return "Thin clouds";
            case Weather.CONDITION_UNKNOWN:
            default:
                return "Unknown";
        }
    }
} 