# coding: utf-8
from __future__ import unicode_literals

from math import pi, asin, atan, sin, cos, radians, degrees, sqrt, acos, tan, floor, ceil
from datetime import date, timedelta


def ftime(n):
    hours = floor(n)
    mins = ceil((n - hours)*60)
    if hours >= 24: hours -= 24
    return "%02d:%02d" % (int(hours), int(mins))


def calctimes(date, alt, lat, lon, tz, asr, gd, gn, ftime):
    yearday = date.timetuple()[7]
    lat, gd, gn = radians(lat), radians(gd), radians(gn)
    acot, sign = lambda x: atan(1.0/x), lambda x: abs(x)/x
    alt = 1 if alt == 0 else alt
    times = [0, 0, 0, 0, 0, 0]
    b = (2*pi*yearday)/365.0
    d = 0.006918 - (0.399912*cos(b)) + (0.070257*sin(b)) - (0.006758*cos(2*b)) + (0.000907*sin(2*b)) - (0.002697*cos(3*b)) + (0.001480*sin(3*b))
    t = 229.18*(0.000075 + (0.001868*cos(b)) - (0.032077*sin(b)) - (0.014615*cos(2*b)) - (0.040849*sin(2*b)))
    r = 15.0*tz
    z = 12.0 + ((r - lon)/15.0) - (t/60.0)
    x = (sin(radians(-0.8333 - 0.0347*sign(alt)*sqrt(abs(alt)))) - sin(d)*sin(lat))/(cos(d)*cos(lat))
    if -1 <= x <= 1:
        u = degrees(1/15.0*acos(x))
    else:
        if x < -1:
            raise Exception('no sunset')
        else:
            raise Exception('no sunrise')
    x = (-sin(gd) - sin(d)*sin(lat))/(cos(d)*cos(lat))
    vd = degrees(1/15.0*acos(x))
    x = (sin(acot(asr + tan(abs(lat-d)))) - sin(d)*sin(lat))/(cos(d)*cos(lat))
    w = degrees(1/15.0*acos(x))
    if gn == 0:
        vn = u + 1.5
    else:
        x = (-sin(gn) - sin(d)*sin(lat))/(cos(d)*cos(lat))
        vn = degrees(1/15.0*acos(x))
    #Fajr and Isha correction incase of no night
    er = asin(cos(d)*cos(lat) - sin(d)*sin(lat))
    #print "%.2f"%degrees(er)
    x = True
    if er < max(gd, gn):
        vd = -12
        vn = -12
        x = False
    return z - vd, z - u, z, z + w, z + u, z + vn


def namaz_times(date, alt, lat, lon, tz, asr, gd, gn, ftime):
    times = calctimes(date, alt, lat, lon, tz, asr, gd, gn, ftime)
    return map(ftime, times)


def salat_times_pairs(date, alt, lat, lon, tz, asr, gd, gn, ftime):
    times = calctimes(date, alt, lat, lon, tz, asr, gd, gn, ftime)
    times = map(ftime, times)
    times = zip(times, times)
    return times

if __name__ == '__main__':
    #print namaz_times(date.today(), 0, 54.7355, 55.99198, 6, 2, 19.0, 0, ftime)

    i = date(1980, 1, 1)
    delta = timedelta(days=1)
    print
    t = {}
    while i.year <= 2019:
        day_of_year = i.timetuple().tm_yday
        if day_of_year not in t:
            t[day_of_year] = []
        t[day_of_year].append(namaz_times(i, 0, 21.4225, 39.826111, 6, 2, 19.0, 0, ftime)[2])
        i = i + delta
    i = date(2012, 1, 1)
    while i.year <= 2012:
        day_of_year = i.timetuple().tm_yday
        print '%03d' % day_of_year, reduce(lambda x, y: x if x == y else Falser, t[day_of_year])
        i = i + delta

'''
Sunrise Angle: 20 degrees
Sunset Angle: 18 degrees
This method is commonly used in Indonesia, Iraq, Jordan, Lebanon, Malaysia, Singapore, Syria, parts of Africa, and parts of the United States.

University of Islamic Sciences, Karachi
Sunrise Angle: 18 degrees
Sunset Angle: 18 degrees
This method is commonly used in Iran, Kuwait, and parts of Europe.

Islamic Society of North America
Sunrise Angle: 15 degrees
Sunset Angle: 15 degrees
This method is commonly used in Canada, Parts of the UK, and parts of the United States.

Muslim World League
Sunrise Angle: 18 degrees
Sunset Angle: 17 degrees
This method is commonly used in parts of Europe, the Far East, and parts of the United States.

Om Al-Qurra University
Sunrise Angle: 19 degrees
Sunset Angle: N/A
Isha is always 90 minutes after Maghrib. This method is commonly used in Saudi Arabia.

Fixed Ishaa Angle Interval
Sunrise Angle: 19.5 degrees
Sunset Angle: N/A
Isha is always 90 minutes after Maghrib. This method is commonly used in Bahrain, Oman, Qatar, and the United Arab Emirates.'''