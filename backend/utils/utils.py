import re
import json
import pyrebase
from openai import OpenAI

# Given a file of words, find the definition from a dictionary file and
# copy from matching entries to "outfile"
def find_dfn_from_lst(lst: str, dfn: str, outfile: str):
    buf = []
    with open(lst, 'r') as infile:
        in_lines = infile.readlines()

    with open(dfn, 'r') as dictfile:
        dfns = dictfile.readlines()

    outfp = open(outfile, 'w')

    for line_a in in_lines:
        # splits word from parenthesis 
        word = re.split(r'\(.*', line_a.strip())
        if word[0] in buf:
            pass
        else:
            # any pattern that starts with "word("
            pattern = re.escape(word[0]) + r'\(.*'
            for line_b in dfns:
                # if word has 2 dfns, both dfns, 
                # regardless of if they are in the infile or not, 
                # get written into outfile
                if re.match(pattern, line_b):
                    print(f"Match found in dfn file for '{word[0]}': {line_b.strip()}")
                    outfp.write(line_b)
        buf.append(word[0])

# Given a file with "word(num)(pos):dfn" or "word(pos):dfn" entries, output a json file
def word_dfn_to_json(infile: str, outfile: str):
    with open(infile, 'r') as infp:
        in_lines = infp.readlines()

    pattern_with_num = re.compile(r"(\w+)\((\d*)\)\((\w+)\):\s(.+)")
    pattern_no_num = re.compile(r"(\w+)\((\w+)\):\s(.+)")
    word_dict = {}

    for line in in_lines:
        result_with_num = re.match(pattern_with_num, line)
        result_no_num = re.match(pattern_no_num, line)

        if result_with_num is not None:
            if result_with_num.group(1) in word_dict.keys():
                word_dict[result_with_num.group(1)]['pos'] += [result_with_num.group(3)]
                word_dict[result_with_num.group(1)]['meaning'] += [result_with_num.group(4)]
                word_dict[result_with_num.group(1)]['dfn_cnt'] += 1
            else:
                word_dict[result_with_num.group(1)] = {
                    "pos": [result_with_num.group(3)],
                    "meaning": [result_with_num.group(4)],
                    "dfn_cnt": 1
                }
        elif result_no_num is not None:
            word_dict[result_no_num.group(1)] = {
                "pos": result_no_num.group(2),
                "meaning": result_no_num.group(3),
                "dfn_cnt": 1
            }
    dict_to_json = json.dumps(word_dict, indent=4)
    with open(outfile, "w") as outfp:
        outfp.write(dict_to_json)

# Add Korean equivalent word to an existing json file containing word, dfn, dfn_cnt information  
def add_kr_word_to_json(in_file: str, out_file: str, api_key: str):
    client = OpenAI(api_key=api_key)
    two_dfn_sys_prompt = 'Respond with the Korean equivalent for each provided English definition. Have ONLY the Korean word in your response. DO NOT provide the English transcription. Format the response to have a comma in between the two words.'
    one_dfn_sys_prompt = 'Respond with the Korean equivalent. Have ONLY the Korean word in your response. DO NOT provide the English transcription.'
    with open(in_file, 'r', encoding='utf-8') as jfile:
        data = json.load(jfile)

    for key in data.keys():
        print(f'Hit: {key}')
        if data[key]['dfn_cnt'] == 1:
            dfn = data[key]['meaning']
            user_prompt = f'Word: {key}. Definition: {dfn}.'
            sys_prompt = one_dfn_sys_prompt
            print(f'{key} dfn_cnt = 1')
            print(f'User prompt: {user_prompt}')
        elif data[key]['dfn_cnt'] == 2:
            dfn1 = data[key]['meaning'][0]
            dfn2 = data[key]['meaning'][1]
            user_prompt = f'Word: {key}. Definition 1: {dfn1}. Definition 2: {dfn2}.'
            sys_prompt = two_dfn_sys_prompt
            print(f'{key} dfn_cnt = 2')
            print(f'User prompt: {user_prompt}')
        chat_completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {'role':'system', 'content': sys_prompt},
            {'role':'user', "content": user_prompt}
        ],
        temperature=0,
        max_tokens=2000,
    )
        response = chat_completion.choices[0].message.content.strip()
        print(f'{key} GPT reply: {response}')
        if ',' in response:
            data[key]['kr_word'] = response.split(', ')
        elif '.' in response:
            data[key]['kr_word'] = response.split('. ')
        else: 
            data[key]['kr_word'] = response

    with open(out_file, 'w', encoding='utf-8') as jfile:
        json.dump(obj=data, fp=jfile, indent=4, ensure_ascii=False)

# Adds img urls to pre-existing json file with: word names (as keys) and definition count
def add_img_to_json(in_file: str, out_file: str, config: dict, ):
    firebase = pyrebase.initialize_app(config)
    storage = firebase.storage()

    with open(in_file, 'r', encoding='utf-8') as jfile:
        data = json.load(jfile)

    for key in data.keys():
        if data[key]['dfn_cnt'] == 1:
            data[key]['img_url'] = storage.child(f"words/{key}/{key}_1.png").get_url(token=None)

        elif data[key]['dfn_cnt'] == 2:
            url1 = storage.child(f"words/{key}/{key}1_1.png").get_url(token=None)
            url2 = storage.child(f"words/{key}/{key}2_1.png").get_url(token=None)
            data[key]['img_url'] = [url1, url2]

    with open(out_file, 'w', encoding='utf-8') as jfile:
        json.dump(obj=data, fp=jfile, indent=4, ensure_ascii=False)