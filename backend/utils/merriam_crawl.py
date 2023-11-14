# rotating proxy source: 
# https://www.zenrows.com/blog/how-to-rotate-proxies-in-python#separate
import re
import requests
from bs4 import BeautifulSoup
import random
from threading import Timer

def reset_proxy(proxy):
    print("reset_proxy", proxy)
    unchecked.add(proxy)
    working.discard(proxy)
    not_working.discard(proxy)

def set_working(proxy):
    print("set_working", proxy)
    unchecked.discard(proxy)
    working.add(proxy)
    not_working.discard(proxy)

def set_not_working(proxy):
    print("set_not_working", proxy)
    unchecked.discard(proxy)
    working.discard(proxy)
    not_working.add(proxy)

    # move to unchecked after a certain time
    Timer(20.0, reset_proxy, [proxy]).start()

def get_random_proxy():
	# create a tuple from unchecked and working sets 
    available_proxies = tuple(unchecked.union(working))
    if not available_proxies:
        raise Exception("no proxies available")
    return random.choice(available_proxies)

VALID_STATUSES = [200, 301, 302, 307, 404]
session = requests.Session()

proxies_list = open("rotating_proxy_list.txt", "r").read().strip().split("\n") 
unchecked = set(proxies_list[0:10]) # limited to 10 to avoid too many requests 
working = set() 
not_working = set() 

def get(url, proxy = None):
    if not proxy: 
        proxy = get_random_proxy() 

    try:
        # Send proxy requests to the final URL
        response = session.get(url, proxies={'http': f"http://{proxy}"}, timeout=10)
        if response.status_code in VALID_STATUSES:
            set_working(proxy)
        else:
            set_not_working(proxy)
        
        return response
    except Exception as e: 
        set_not_working(proxy)
        raise e # raise exception

print("unchecked ->", unchecked) # unchecked -> set() 
print("working ->", working) # working -> {"152.0.209.175:8080", ...} 
print("not_working ->", not_working) # not_working -> {"167.71.5.83:3128", ...}

def merriam_crawl(in_file, out_file, **kwargs):
    in_fp = open(in_file, 'r', encoding='utf-8')
    out_fp = open(out_file, 'w')
    ctr = 1
    endpoint = 'https://www.merriam-webster.com/dictionary/'
    pattern1 = re.compile(r"\s\(([A-Za-z0-9]+( [A-Za-z0-9]+)+)\)", re.IGNORECASE)
    pattern2 = re.compile(r"\s\(([A-Za-z0-9]+( [A-Za-z0-9]+)+)\([0-9]+\)\)", re.IGNORECASE)
    input_lines = in_fp.readlines()
    for line in input_lines:
        try:
            line = line.strip('\n')
            url = endpoint+line
            response = get(url)
            soup = BeautifulSoup(response.content, 'html.parser')
            entry1 = soup.find("div",{"id": "dictionary-entry-1"})
            entry2 = soup.find("div",{"id": "dictionary-entry-2"})
            if entry2 is not None:
                meaning1 = entry1.find("span", {"class":"dtText"}).text
                pos1 = entry1.find("h2", {"class": "parts-of-speech"}).text
                meaning2 = entry2.find("span", {"class":"dtText"}).text
                pos2 = entry2.find("h2", {"class": "parts-of-speech"}).text
                first_clean_m1 = re.sub(pattern1, '', meaning1).strip()
                final_m1 = re.sub(pattern2, '', first_clean_m1)
                first_clean_m2 = re.sub(pattern1, '', meaning2).strip()
                final_m2 = re.sub(pattern2, '', first_clean_m2)
                out_fp.write(f'{line}(1)({pos1}){final_m1}\n')
                out_fp.write(f'{line}(2)({pos2}){final_m2}\n')
                print(f'Write {ctr}: "{line}" SUCCESS')
                print(response.status_code)
                ctr += 1
            else:
                meaning = entry1.find("span", {"class":"dtText"}).text
                pos = entry1.find("h2", {"class": "parts-of-speech"}).text
                initial_clean = re.sub(pattern1, '', meaning).strip()
                final_clean = re.sub(pattern2, '', initial_clean)
                out_fp.write(f'{line}({pos}){final_clean}\n')
                print(f'Write {ctr}: "{line}" SUCCESS')
                print(response.status_code)
                ctr += 1
        except Exception as e:
            print(e)
            print(f'Write {ctr} FAILED')
            ctr += 1
def daum_dic_crawl(in_file, out_file, **kwargs):
    ctr = 1
    in_fp = open(in_file, 'r', encoding='utf-8')
    out_fp = open(out_file, 'w')
    input_lines = in_fp.readlines()
    for line in input_lines:
        try:
            line = line.strip('\n')
            url = f'https://m.dic.daum.net/search.do?q={line}&dic=eng'
            response = get(url)
            soup = BeautifulSoup(response.content, 'html.parser')
        except Exception as e:
            print(e)

def main():
    # in case proxies don't work, manually make undefined word list
    ## in_fp = open('extra_words.txt', 'r')
    ## out_fp = open('merriam_dfn_v4.txt', 'a')
    # if proxies fail, manually change ctr to last defined word line number
    merriam_crawl(in_file='clean_actual_vocab_list.txt', out_file='merriam_dfn_v4.txt')
main()