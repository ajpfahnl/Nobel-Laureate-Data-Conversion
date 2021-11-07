import json
from os import write

'''
# load data
data = json.load(open("./data/nobel-laureates.json", "r"))

# get the id, givenName, and familyName of the first laureate
laureate = data["laureates"][0]
id = laureate["id"]
givenName = laureate["givenName"]["en"]
familyName = laureate["familyName"]["en"]

# print the extracted information
print(id + "\t" + givenName + "\t" + familyName)
'''

##############################################################
DEBUG = False
NULL = '\\N'

def printd(s):
    if DEBUG:
        print(s)

# load data
data = json.load(open("./data/nobel-laureates.json", "r"))
laureates = data["laureates"]

# create del files
d_people = {}
d_birthfounded = {}
d_org = {}
d_aff = {}
d_nobelprize = {}

for laureate in laureates:
    id = laureate["id"]

    person = True if "givenName" in laureate else False

    # People and Org tables
    if person:
        givenName = laureate["givenName"]["en"]
        familyName = laureate["familyName"]["en"] if "familyName" in laureate else NULL
        gender = laureate["gender"]

        for nobel_prize in laureate["nobelPrizes"]:  
            p_award_year = nobel_prize["awardYear"]

            printd(f"{givenName} {familyName}")
            d_people[id+p_award_year] = (id, givenName, familyName, gender, p_award_year)
    else:
        org = laureate["orgName"]["en"]

        for nobel_prize in laureate["nobelPrizes"]:  
            o_award_year = nobel_prize["awardYear"]

            printd(org)
            d_org[id+o_award_year] = (id, org, o_award_year)

    # Birth/Founding table
    if person:
        if "birthCountry" in laureate:
            printd("\tbirth country only")
            date = NULL
            place = NULL
            place_city = NULL
            place_country = laureate['birthCountry']['en']
        else:
            date = laureate["birth"]["date"]
            place = laureate["birth"]["place"]
            place_city = place["city"]["en"] if "city" in place else NULL
            place_country = place["country"]["en"] if "country" in place else NULL

    else:
        # organization founding
        if "founded" not in laureate:
            printd('\tno founding')
            date = NULL
            place = NULL
            place_city = NULL
            place_country = NULL
        else:
            date = laureate["founded"]["date"]
            place = laureate["founded"]["place"]
            place_city = place["city"]["en"] if "city" in place else NULL
            place_country = place["country"]["en"] if "country" in place else NULL

    d_birthfounded[id] = (id, date, place_city, place_country)

    # nobel prize table
    for nobel_prize in laureate["nobelPrizes"]:  
        award_year = nobel_prize["awardYear"]
        category = nobel_prize["category"]["en"]
        sort_order = nobel_prize["sortOrder"]

        d_nobelprize[id+award_year] = (id, award_year, category, sort_order)

        # Affiliations table
        if person and "affiliations" in nobel_prize:
            for affiliation in nobel_prize["affiliations"]:
                aff_name = affiliation["name"]["en"] 
                aff_city = affiliation["city"]["en"] if "city" in affiliation else NULL
                aff_country = affiliation["country"]["en"] if "country" in affiliation else NULL

                d_aff[id+aff_name] = (id, aff_name, aff_city, aff_country)

def write_d2f(filename, d):
    with open(filename, 'w') as f:
        for tup in d.values():
            f.write(';'.join(tup) + '\n')

write_d2f("./People.del", d_people)
write_d2f("./BirthFounded.del", d_birthfounded)
write_d2f("./Org.del", d_org)
write_d2f("./Affiliations.del", d_aff)
write_d2f("./NobelPrize.del", d_nobelprize)