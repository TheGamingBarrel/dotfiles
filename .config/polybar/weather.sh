#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:filetype=python

import urllib.request, json

city = "Bordeaux,fr"
api_key = "d363eb1a3bbf81a7a4730519c8aee689"
units = "metric"
unit_key = "C"

weather = eval(str(urllib.request.urlopen("http://api.openweathermap.org/data/2.5/weather?q={}&APPID={}&units={}".format(city, api_key, units)).read())[2:-1])

info = weather["weather"][0]["description"].capitalize()
temp = int(float(weather["main"]["temp"]))

print("%s, %i°%s" % (info, temp, unit_key))

