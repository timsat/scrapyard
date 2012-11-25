from bs4 import BeautifulSoup
import urllib

def getStopsForRoute(routeId):
    getStopsUrl = 'http://izhget.ru/rasp/st_list.php?order=0&route={0}&r=776'.format(routeId)
    f = urllib.urlopen(getStopsUrl)
    try:
        soup = BeautifulSoup(f)
        stopsTags = soup.find('select', id='stn').find_all('option')
        return map(lambda optTag: (optTag['value'], optTag.string), stopsTags)

    finally:
        f.close()
def getTimesForStopsOnRoute(fromId, toId, routeId):
    getScheduleUrl = 'http://izhget.ru/rasp/st_time.php?dstn={1}&id_s={0}&timeint=1440&d_r=2012-11-25&th_r=00&tm_r=00&r0.35106312238447035'

for stopId,stopName in getStopsForRoute(1):
    print u'{}->{}'.format(stopId,stopName)


