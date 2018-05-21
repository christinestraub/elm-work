import json

KeyFns={
    "teams": lambda x: x["name"],
    "fixtures": lambda x: x["name"],
    "outrights": lambda x: "%s/%s" % (x["market"], x["team"])
}
    
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
            filename="fixtures/%s~%s.json" % (leaguename.replace(".", "~"),
                                              attr)
            struct=json.loads(file(filename).read())
            for item in struct:
                item["key"]=KeyFns[attr](item)
            destfilename="tmp/%s~%s.json" % (leaguename.replace(".", "~"),
                                             attr)
            dest=file(destfilename, 'w')                      
            dest.write(json.dumps(struct))
            dest.close()


