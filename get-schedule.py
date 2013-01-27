# -*- coding: utf-8 -*-
from bs4 import BeautifulSoup
import urllib, codecs
import httplib
import json
import re

class StopLocator:
    def __init__(self):
        self.izhGetStopsUrl = 'http://izhget.ru/rasp/st_list.php?order=0&route={0}&r=776'
        self.dgisSearchApiPath = '/station/search?'
        self.dgisSearchApiHost = 'transport.api.2gis.ru'

    def getStopsForRoute(self, routeId):
        getStopsUrl = self.izhGetStopsUrl.format(routeId)
        f = urllib.urlopen(getStopsUrl)
        try:
            soup = BeautifulSoup(f.read().decode('cp1251'))
            stopsTags = soup.find('select', id='stn').find_all('option')
            return map(lambda optTag: (optTag['value'], optTag.string), stopsTags)

        finally:
            f.close()

    def writeStop(self, f, stopInfo):
        print 'writing ' + stopInfo['stopName']
        f.write(u'\t{\n')
        f.write(u'\t\t"id":{},\n'.format(stopInfo['stopId']))
        f.write(u'\t\t"name":"{}",\n'.format(stopInfo['stopName']))
        f.write(u'\t\t"coords":[\n')
        for location in stopInfo['locations']:
            f.write(u'\t\t\t{\n')
            f.write(u'\t\t\t\t"longitude": {},\n'.format(location['longitude']))
            f.write(u'\t\t\t\t"latitude": {}\n'.format(location['latitude']))
            f.write(u'\t\t\t},\n')
        f.write(u'\t\t]\n')
        f.write(u'\t},\n')

    def getLocations(self, stopName):
        params =urllib.urlencode({ 'project': 41, 'pagesize':50, 'what': stopName.encode("utf8"), 'output': 'jsonp', 'key': 'ruokep8523', 'version': '1.3', 'lang': 'ru', 'callback': 'DG'})
        apiUrl = self.dgisSearchApiPath + params
        headers = {"Accept": "*/*", "Referer": "http://maps.2gis.ru"}
        self.dgisSearchApiConnection.request("GET", apiUrl, '', headers)
        response = self.dgisSearchApiConnection.getresponse()
        data = json.loads(response.read().strip('DG()'))
        result = []
        if data['response_code'] == '200' and data['total'] == 1 :
            for platform in data['result'][0]['platforms']:
                if 'tram' in platform['route_types']:
                    locationRe = r'POINT\(([0-9\.]+) ([0-9\.]+)\)'
                    m = re.search(locationRe, platform['location'])
                    result.append({'longitude': m.group(1), 'latitude': m.group(2)})
        return result

    def locate(self):
        self.dgisSearchApiConnection = httplib.HTTPConnection(self.dgisSearchApiHost)
        with codecs.open('out', 'w', 'utf8') as outF:
            
            outF.write(u'[\n')
            for stopId,stopName in self.getStopsForRoute(1):
                locations = self.getLocations(stopName)
                stopInfo={'stopId': stopId, 'stopName': stopName, 'locations': locations}
                self.writeStop(outF, stopInfo)
            outF.write(u']\n')
        self.dgisSearchApiConnection.close()

locator = StopLocator()
locator.locate()
