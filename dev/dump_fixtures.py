import datetime, json, re, time, urllib

from lxml import etree

Endpoint="http://iosport-iocurve.appspot.com"

Path="/api/%s?api_key=%s&league=%s"

ApiKey="Hufton123"

def parse_value(text):
    if re.search("^\\-?\\d+$", text):
        return int(text)
    elif re.search("^\\-?\\d+\\.\\d+$", text):
        return float(text)
    # elif re.search("^\\d{4}\\-\\d{1,2}\\-\\d{1,2}$", text):
    # return datetime.date.strptime(text, "%Y-%m-%d").date()
    elif text.lower() in ["true", "false"]:
        return bool(text.capitalize())
    else:
        return text

def fetch(leaguename, attr):
    url=Endpoint+Path % (attr, ApiKey, leaguename)
    root=etree.fromstring(urllib.urlopen(url).read())    
    return [{el.tag:parse_value(el.text) for el in team.getchildren()}
            for team in root.getchildren()]

if __name__=="__main__":    
    for leaguename in ["ENG.1",
                       "ENG.2",
                       "FRA.1",
                       "GER.1",
                       "SPA.1"]:
        for attr in ["teams",
                     "fixtures",
                     "outrights"]:
            print "%s/%s" % (leaguename, attr)
            items=fetch(leaguename, attr)
            destfilename="tmp/%s~%s.json" % (leaguename.replace(".", "~"),
                                             attr)
            dest=file(destfilename, 'w')                      
            dest.write(json.dumps(items))
            dest.close()
            time.sleep(1)
