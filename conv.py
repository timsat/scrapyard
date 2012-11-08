# alfa-bank to easymoney data converter

import io
import codecs
import re


def parse(s):
    months = {'01':'Jan','02':'Feb','03':'Mar','04':'Apr','05':'May','01':'Jun','07':'Jul','08':'Aug','09':'Sep','10':'Oct','11':'Nov','01':'Dec'}

    result = {}
    values = line.split(';') 

    # remove credit card number
    descStr = re.sub(r'\d{6}\+{6}\d{4}', u'', values[5])

    #parse date from description
    dateRe = r'\d\d\.\d\d\.\d\d \d\d.\d\d.\d\d'
    m = re.search(dateRe, descStr)
    if m != None:
        dateStrs = m.group(0).split(' ')[1].split('.')

        month = months[dateStrs[1]]
        if values[4] != u'HOLD' :
            day = int(dateStrs[0]) 
            year = int(dateStrs[2])+2000
        else :
            day = int(dateStrs[2]) 
            year = int(dateStrs[0])+2000
        result['date'] = u'{} {} {}'.format(day, month, year)
    else:
        dateValues = values[3].split('.')
        date = u'{0} {1} {2}'.format(int(dateValues[0]), months[dateValues[1]], dateValues[2]) if len(dateValues) == 3 else ''
        result['date'] = date

    #remove dates from description
    descStr = re.sub(dateRe, u'', refstr).strip(' ')
    result['amount'] = values[7]
    result['desc'] = descStr
    return type('Parsed', (object,), result)


with codecs.open('movementList.csv', 'r', 'utf8') as file:
    with codecs.open('out.csv', 'w', 'utf8') as outF:
        for line in file:
            parsed = parse(line)
            s = u'"{0.desc}";"Groceries";-{0.amount};"Cleared";"{0.date}";""\n'
            outF.write(s.format(parsed))

