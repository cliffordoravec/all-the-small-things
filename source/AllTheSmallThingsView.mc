import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Position;
import Toybox.System;
import Toybox.Time;
import Toybox.UserProfile;
import Toybox.WatchUi;
import Toybox.Weather;

class AllTheSmallThingsView extends WatchUi.WatchFace {

    var _width as Number?;
    var _height as Number?;

    var _activeMinutesIcon as BitmapResource?;
    var _bluetoothConnectedIcon as BitmapResource?;
    var _bluetoothDisconnectedIcon as BitmapResource?;
    var _caloriesIcon as BitmapResource?;
    var _climbIcon as BitmapResource?;
    var _currentHeartRateIcon as BitmapResource?;
    var _distanceIcon as BitmapResource?;
    var _stepsIcon as BitmapResource?;
    var _recoveryTimeIcon as BitmapResource?;
    var _respirationRateIcon as BitmapResource?;
    var _weightIcon as BitmapResource?;
    var _vo2maxIcon as BitmapResource?;

    function initialize() {
        WatchFace.initialize();

        var deviceSettings = System.getDeviceSettings();
        _width = deviceSettings.screenWidth;
        _height = deviceSettings.screenHeight;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));

        _activeMinutesIcon = Application.loadResource(Rez.Drawables.ActiveMinutesIcon) as BitmapResource;
        _bluetoothConnectedIcon = Application.loadResource(Rez.Drawables.BluetoothConnectedIcon) as BitmapResource;
        _bluetoothDisconnectedIcon = Application.loadResource(Rez.Drawables.BluetoothDisconnectedIcon) as BitmapResource;
        _caloriesIcon = Application.loadResource(Rez.Drawables.CaloriesIcon) as BitmapResource;
        _climbIcon = Application.loadResource(Rez.Drawables.ClimbIcon) as BitmapResource;
        _currentHeartRateIcon = Application.loadResource(Rez.Drawables.CurrentHeartRateIcon) as BitmapResource;
        _distanceIcon = Application.loadResource(Rez.Drawables.DistanceIcon) as BitmapResource;
        _stepsIcon = Application.loadResource(Rez.Drawables.StepsIcon) as BitmapResource;
        _recoveryTimeIcon = Application.loadResource(Rez.Drawables.RecoveryTimeIcon) as BitmapResource;
        _respirationRateIcon = Application.loadResource(Rez.Drawables.RespirationRateIcon) as BitmapResource;
        _weightIcon = Application.loadResource(Rez.Drawables.WeightIcon) as BitmapResource;
        _vo2maxIcon = Application.loadResource(Rez.Drawables.VO2MaxIcon) as BitmapResource;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var deviceSettings = System.getDeviceSettings();

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!deviceSettings.is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
            else if (hours == 0) {
                hours = 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var timeDimensions = dc.getTextDimensions(timeString, Graphics.FONT_NUMBER_THAI_HOT);
        var timeWidth = timeDimensions[0];
        var timeHeight = timeDimensions[1];
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_width - timeWidth - 5, (_height / 2) - (timeHeight / 2), Graphics.FONT_NUMBER_THAI_HOT, timeString, Graphics.TEXT_JUSTIFY_LEFT);

        var lineY = (_height / 2) + (timeHeight / 2) - 20;
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(_width - timeWidth - 5, lineY, _width, lineY);

        var indent = 15;

        var conditions = Weather.getCurrentConditions();
        if (conditions != null) {
            var timeOffsetY = (_height / 2) - (timeHeight / 2);

            var factorsWidth = 0;
            var factorsHeight = 0;
            if (conditions.precipitationChance != null
                && conditions.relativeHumidity != null
                && conditions.windSpeed != null
                && conditions.windBearing != null) {
                var factorsString = Lang.format("P$1$% H$2$% W$3$ $4$", [
                    conditions.precipitationChance, 
                    conditions.relativeHumidity, 
                    self.metersPerSecondToMilesPerHour(conditions.windSpeed), 
                    self.windBearingToCardinalDirection(conditions.windBearing)]);
                var factorsDimensions = dc.getTextDimensions(factorsString, Graphics.FONT_XTINY);
                factorsWidth = factorsDimensions[0];
                factorsHeight = factorsDimensions[1];
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(_width - factorsWidth - (indent * 1), timeOffsetY, Graphics.FONT_XTINY, factorsString, Graphics.TEXT_JUSTIFY_LEFT);
            }

            var temperatureHeight = 0;

            var forecastConditionsWidth = 0;
            if (conditions.highTemperature != null
                && conditions.lowTemperature != null) {
                var forecastConditionsString = Lang.format("H$1$' L$2$'", [
                    self.celsiusToFahrenheit(conditions.highTemperature), 
                    self.celsiusToFahrenheit(conditions.lowTemperature)]);
                var forecastConditionsDimensions = dc.getTextDimensions(forecastConditionsString, Graphics.FONT_XTINY);
                forecastConditionsWidth = forecastConditionsDimensions[0];
                temperatureHeight = forecastConditionsDimensions[1];
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(_width - forecastConditionsWidth - (indent * 2), timeOffsetY - factorsHeight, Graphics.FONT_XTINY, forecastConditionsString, Graphics.TEXT_JUSTIFY_LEFT);
            }

            var currentConditionsWidth = 0;
            if (conditions.temperature != null
                && conditions.feelsLikeTemperature != null) {
                var currentConditionsString = Lang.format("$1$' F$2$' ", [
                    self.celsiusToFahrenheit(conditions.temperature), 
                    self.celsiusToFahrenheit(conditions.feelsLikeTemperature)]);
                var currentConditionsDimensions = dc.getTextDimensions(currentConditionsString, Graphics.FONT_XTINY);
                currentConditionsWidth = currentConditionsDimensions[0];
                temperatureHeight = currentConditionsDimensions[1];
                dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(_width - currentConditionsWidth - forecastConditionsWidth - (indent * 2), timeOffsetY - factorsHeight, Graphics.FONT_XTINY, currentConditionsString, Graphics.TEXT_JUSTIFY_LEFT);
            }

            var conditionWidth = 0;
            var conditionHeight = 0;
            if (conditions.condition != null) {
                var conditionString = self.getConditionText(conditions.condition);
                var conditionDimensions = dc.getTextDimensions(conditionString, Graphics.FONT_XTINY);
                conditionWidth = conditionDimensions[0];
                conditionHeight = conditionDimensions[1];
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(_width - conditionWidth - (indent * 3), timeOffsetY - factorsHeight - temperatureHeight, Graphics.FONT_XTINY, conditionString, Graphics.TEXT_JUSTIFY_LEFT);
            }
        }

        var dateOffsetY = lineY + 5;
        var now = Time.now();

        var calendar = Time.Gregorian.info(now, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$ $2$ $3$", [calendar.day_of_week, calendar.month, calendar.day]);
        var dateDimensions = dc.getTextDimensions(dateString, Graphics.FONT_XTINY);
        var dateWidth = dateDimensions[0];
        var dateHeight = dateDimensions[1];
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_width - dateWidth - (indent * 1), dateOffsetY, Graphics.FONT_XTINY, dateString, Graphics.TEXT_JUSTIFY_LEFT);

        var batteryWidth = 0;
        var systemStats = System.getSystemStats();
        if (systemStats != null) {
            var battery = systemStats.battery;
            var batteryTime = "";
            if (systemStats has :batteryInDays) {
                if (systemStats.batteryInDays < 1) {
                    batteryTime = Lang.format("$1$h ", [(systemStats.batteryInDays / 60).toNumber()]);
                }
                else {
                    batteryTime = Lang.format("$1$d ", [systemStats.batteryInDays.toNumber()]);
                }
            }

            var batteryString = Lang.format("$1$$2$%", [batteryTime, battery.toNumber()]);
            batteryWidth = dc.getTextWidthInPixels(batteryString, Graphics.FONT_XTINY);

            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(_width - dateWidth - batteryWidth - 5 - (indent * 1), dateOffsetY, Graphics.FONT_XTINY, batteryString, Graphics.TEXT_JUSTIFY_LEFT);
        }

        var bluetoothIcon = deviceSettings.phoneConnected
            ? _bluetoothConnectedIcon
            : _bluetoothDisconnectedIcon;

        var bluetoothIconWidth = bluetoothIcon.getWidth();
        var bluetoothIconHeight = bluetoothIcon.getHeight();
        dc.drawBitmap(_width - dateWidth - batteryWidth - 5 - bluetoothIconWidth - 3 - (indent * 1), dateOffsetY + 3, bluetoothIcon);

        // TODO: am/pm
        // TODO: icons for weather stats

        var sunriseSunsetWidth = 0;
        var sunriseSunsetHeight = 0;
        if (conditions != null) {
            var location = conditions.observationLocationPosition;
            if (location != null
                && Weather has :getSunrise
                && Weather has :getSunset) {
                var sunrise = Weather.getSunrise(location, now);
                var sunriseString = "";
                if (sunrise != null) {
                    var sunriseCalendar = Time.Gregorian.info(sunrise, Time.FORMAT_SHORT);
                    var sunriseHour = sunriseCalendar.hour;
                    var sunriseAMPM = sunriseHour >= 12 ? "pm" : "am";
                    if (sunriseHour > 12) {
                        sunriseHour = sunriseHour - 12;
                    }
                    else if (sunriseHour == 0) {
                        sunriseHour = 12;
                    }
                    sunriseString = Lang.format("$1$:$2$$3$", [sunriseHour, sunriseCalendar.min.format("%02u"), sunriseAMPM]);
                }

                var sunset = Weather.getSunset(location, now);
                var sunsetString = "";
                if (sunset != null) {
                    var sunsetCalendar = Time.Gregorian.info(sunset, Time.FORMAT_SHORT);
                    var sunsetHour = sunsetCalendar.hour;
                    var sunsetAMPM = sunsetHour >= 12 ? "pm" : "am";
                    if (sunsetHour > 12) {
                        sunsetHour = sunsetHour - 12;
                    }
                    else if (sunsetHour == 0) {
                        sunsetHour = 12;
                    }
                    sunsetString = Lang.format("$1$:$2$$3$", [sunsetHour, sunsetCalendar.min.format("%02u"), sunsetAMPM]);
                }

                if (sunriseString != "" || sunsetString != "") {
                    var sunriseSunsetString = Lang.format("R$1$ S$2$", [sunriseString, sunsetString]);
                    var sunriseSunsetDimensions = dc.getTextDimensions(sunriseSunsetString, Graphics.FONT_XTINY);
                    sunriseSunsetWidth = sunriseSunsetDimensions[0];
                    sunriseSunsetHeight = sunriseSunsetDimensions[1];
                    dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                    dc.drawText(_width - sunriseSunsetWidth - (indent * 2), dateOffsetY + dateHeight, Graphics.FONT_XTINY, sunriseSunsetString, Graphics.TEXT_JUSTIFY_LEFT);
                }
            }
        }

        var activityHistory = ActivityMonitor.getHistory();
        if (activityHistory != null) {
            var oneDay = new Time.Duration(Gregorian.SECONDS_PER_DAY);
            var weekStart = new Time.Moment(now.value());

            // Find Monday:
            while (true) {
                var weekStartCalendar = Gregorian.info(weekStart, Time.FORMAT_SHORT);
                if (weekStartCalendar.day_of_week == Gregorian.DAY_MONDAY) {
                    break;
                }

                weekStart = weekStart.subtract(oneDay);
            }

            // Calculate distance since Monday:
            var weeklyDistance = 0;
            for (var i = 0; i < activityHistory.size(); i++) {
                var activity = activityHistory[i];
                if (activity == null
                    || activity.startOfDay == null
                    || activity.startOfDay.compare(weekStart) < 0) {
                    break;
                }

                if (activity.distance != null) {
                    weeklyDistance = weeklyDistance + activity.distance;
                }
            }

            var weeklyDistanceString = Lang.format("$1$mi week", [self.centimetersToMiles(weeklyDistance)]);
            var weeklyDistanceWidth = dc.getTextWidthInPixels(weeklyDistanceString, Graphics.FONT_XTINY);
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(_width - weeklyDistanceWidth - (indent * 3), dateOffsetY + dateHeight + sunriseSunsetHeight, Graphics.FONT_XTINY, weeklyDistanceString, Graphics.TEXT_JUSTIFY_LEFT);
        }

        var statAngle = 180;

        var hrIterator = ActivityMonitor.getHeartRateHistory(null, true);
        var sample = hrIterator.next();
        if (sample != null
            && sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
            statAngle = self.drawStat(dc, statAngle, _currentHeartRateIcon, Lang.format("$1$", [sample.heartRate]), "bpm");
        }

        var info = ActivityMonitor.getInfo() as ActivityMonitor.Info;
        if (info != null) {
            if (info has :respirationRate
                && info.respirationRate != null) {
                statAngle = self.drawStat(dc, statAngle, _respirationRateIcon, Lang.format("$1$", [info.respirationRate]), "");
            }

            if (info has :steps
                && info.steps != null) {
                statAngle = self.drawStat(dc, statAngle, _stepsIcon, Lang.format("$1$", [info.steps]), "");
            }

            if (info has :activeMinutesDay
                && info.activeMinutesDay != null
                && info.activeMinutesDay.total != null) {
                statAngle = self.drawStat(dc, statAngle, _activeMinutesIcon, Lang.format("$1$", [info.activeMinutesDay.total]), "min");
            }

            if (info has :calories
                && info.calories != null) {
                statAngle = self.drawStat(dc, statAngle, _caloriesIcon, Lang.format("$1$", [info.calories]), "cal");
            }

            if (info has :distance
                && info.distance != null) {
                statAngle = self.drawStat(dc, statAngle, _distanceIcon, Lang.format("$1$", [self.centimetersToMiles(info.distance)]), "mi");
            }

            if (info has :metersClimbed) {
                statAngle = self.drawStat(dc, statAngle, _climbIcon, Lang.format("$1$", [self.metersToFeet(info.metersClimbed)]), "ft");
            }

            if (info has :timeToRecovery
                && info.timeToRecovery != null) {
                statAngle = self.drawStat(dc, statAngle, _recoveryTimeIcon, Lang.format("$1$", [info.timeToRecovery]), "h");
            }
        }

        var profile = UserProfile.getProfile() as UserProfile.Profile;
        if (profile != null) {
            if (profile has :weight
                && profile.weight != null) {
                statAngle = self.drawStat(dc, statAngle, _weightIcon, Lang.format("$1$", [self.gramsToPounds(profile.weight)]), "");
            }

            if (profile has :vo2maxRunning
                && profile.vo2maxRunning != null) {
                statAngle = self.drawStat(dc, statAngle, _vo2maxIcon, Lang.format("$1$", [profile.vo2maxRunning]), "vo2");
            }
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExtSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    function drawStat(dc as Dc, angle as Number, icon as BitmapResource, metric as String, unit as String) as Number {
        var r = (_width / 2) - 15;
        var h = (_width / 2) - 10;
        var k = ((_height / 2) - 10) * -1;

        var x = h + (r * Math.sin(Math.toRadians(angle)));
        var y = (k + (r * Math.cos(Math.toRadians(angle)))).abs();

        dc.drawBitmap(x, y, icon);

        var textX = x + icon.getWidth() + 3;
        var textY = y - (icon.getHeight() / 2) + 3;
        var metricWidth = dc.getTextWidthInPixels(metric, Graphics.FONT_XTINY);

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textX, textY, Graphics.FONT_XTINY, metric, Graphics.TEXT_JUSTIFY_LEFT);

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(textX + metricWidth + 1, textY, Graphics.FONT_XTINY, unit, Graphics.TEXT_JUSTIFY_LEFT);

        return angle + 20;
    }

    function celsiusToFahrenheit(celsius as Number) as Number {
        return (celsius * (9 / 5)) + 32;
    }

    function centimetersToMiles(centimeters as Number) as Number {
        return Math.round((centimeters / 160900).toNumber() * 100) / 100;
    }

    function gramsToPounds(grams as Number) as Number {
        return (grams / 453.6).toNumber();
    }

    function metersPerSecondToMilesPerHour(meters as Float) as Number {
        return (meters * 2.237).toNumber();
    }

    function metersToFeet(meters as Float) as Number {
        return Math.round(meters * 3.281).toNumber();
    }

    function metersToMiles(meters as Number) as Number {
        return Math.round(meters / 1609).toNumber();
    }
    
    function windBearingToCardinalDirection(bearing as Number) as String {
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
    
    function getConditionText(condition as Number) as String {
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
