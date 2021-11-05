import json

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

# load data
data = json.load(open("./data/nobel-laureates.json", "r"))
laureate = data["laureates"]

for i in laureate:
    id = laureate["id"]

    givenName = laureate["givenName"]["en"]
    familyName = laureate["familyName"]["en"]
    gender = laureate["gender"]

    org = laureate["orgName"]["en"]

    birth_date = laureate["birth"]["date"]
    birth_place = laureate["birth"]["place"]
    birth_place_city = birth_place["city"]["en"]
    birth_place_country = birth_place["country"]["en"]

    # organization founding
    founded_date = laureate["founded"]["date"]
    founded_place = laureate["founded"]["place"]
    founded_place_city = founded_place["city"]["en"]
    founded_place_country = founded_place["country"]["en"]

    # nobel prize
    nobel_prize = laureate["nobelPrizes"]
    award_year = nobel_prize["awardYear"]
    category = nobel_prize["category"]["en"]
    sort_order = nobel_prize["sortOrder"]

    # people with affiliations
    affiliations = nobel_prize["affiliations"]
    aff_name = affiliations["name"]["en"]
    aff_city = affiliations["city"]["en"]
    aff_country = affiliations["country"]["en"]