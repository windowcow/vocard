import pyrebase
import json
import re
with open('../vocard/secrets.json', 'r') as fp:
    data = json.load(fp)

# https://dic.daum.net/search.do?q=<word>&dic=eng
# crawl to get korean equivalent
with open('500_dfn_list.txt', 'r') as fp:
    lines = fp.readlines()
fp2 = open('500_word_list.txt', 'w')
firebase_config = {
    "apiKey": data["APIKEY"],
    "databaseURL": data["DATABASEURL"],
    "authDomain": data["AUTHDOMAIN"],
    "projectId": data["PROJECTID"],
    "storageBucket": data["STORAGEBUCKET"],
    "messagingSenderId": data["MESSAGINGSENDERID"],
    "appId": data["APPID"],
    "measurementId": data["MEASUREMENTID"]
}
firebase = pyrebase.initialize_app(firebase_config)
authen = firebase.auth()
db = firebase.database()

# PoS regex pattern
pos_pat = re.compile(r"\([A-Za-z]+\)", re.IGNORECASE)
# # Definition number pattern
# def_pat = re.compile(r"\([0-9]+\)", re.IGNORECASE)
for line in lines:
    word_split= line.split(":")
    word_name = word_split[0]
    word_dfn = word_split[1].strip()
    print(f'Word: {word_name}\nDefinition: {word_dfn}')
    pos = re.findall(pos_pat, word_name)
    print(f'Part of Speech: {pos[0]}')
    clean_word = word_name.split(f"{pos[0]}")
    print(f'Cleaned word name: {clean_word[0]}')
    fp2.write(f'{clean_word[0]}\n')

# db_data ={
#     'kr_name': 'placeholder',
#     'pos': pos[0],
#     'meaning': word_dfn,
# }
# db.child('words').child(clean_word[0]).set(db_data)
# entry = db.child('words').child(clean_word[0]).get()
# print(f"DB set: {entry.val()}")