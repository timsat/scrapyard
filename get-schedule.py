from bs4 import BeautifulSoup
import urllib, codecs

def getStopsForRoute(routeId):
    getStopsUrl = 'http://izhget.ru/rasp/st_list.php?order=0&route={0}&r=776'.format(routeId)
    print getStopsUrl
    f = urllib.urlopen(getStopsUrl)
    try:
        soup = BeautifulSoup(f.read().decode('cp1251'))
        stopsTags = soup.find('select', id='stn').find_all('option')
        return map(lambda optTag: (optTag['value'], optTag.string), stopsTags)

    finally:
        f.close()
def getTimesForStopsOnRoute(fromId, toId, routeId):
    getScheduleUrl = 'http://izhget.ru/rasp/st_time.php?dstn={1}&id_s={0}&timeint=1440&d_r=2012-11-25&th_r=00&tm_r=00&r0.35106312238447035'


with codecs.open('out', 'w', 'utf8') as outF:
    outF.write(u'[\n')
    for stopId,stopName in getStopsForRoute(1):
        outF.write(u'\t{\n')
        outF.write(u'\t\t"id":{},\n'.format(stopId))
        outF.write(u'\t\t"name":"{}",\n'.format(stopName))
        outF.write(u'\t\t"coords":[\n')
        outF.write(u'\t\t\t{\n')
        outF.write(u'\t\t\t\t"longitude": 53.0,\n')
        outF.write(u'\t\t\t\t"latitude" : 56.0\n')
        outF.write(u'\t\t\t},\n')
        outF.write(u'\t\t\t{\n')
        outF.write(u'\t\t\t\t"longitude": 53.0,\n')
        outF.write(u'\t\t\t\t"latitude" : 56.0\n')
        outF.write(u'\t\t\t}\n')
        outF.write(u'\t\t]\n')
        outF.write(u'\t},\n')
    outF.write(u']\n')
