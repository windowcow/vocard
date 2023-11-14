import random

# 파일에서 단어 목록을 읽어오는 함수
def read_words(file_path):
    with open(file_path, 'r') as file:
        words = file.readlines()
    # 파일에서 읽은 각 라인의 개행 문자를 제거
    words = [word.strip() for word in words]
    return words

# 랜덤하게 100개의 단어를 선택하고 결과 파일에 저장하는 함수
def pick_random_words_and_save(words, num_words, result_file_path):
    selected_words = random.sample(words, num_words)
    with open(result_file_path, 'w') as file:
        for word in selected_words:
            file.write(word + '\n')

# 메인 함수
def main():
    file_path = '500_word_list.txt'
    result_file_path = 'result.txt'
    words = read_words(file_path)
    # 중복을 피하기 위해 파일 내의 단어 수가 100개 이상인지 확인
    if len(words) < 100:
        print("There are less than 100 words in the file.")
        return
    pick_random_words_and_save(words, 100, result_file_path)
    print(f"100 random words have been written to {result_file_path}")

# 스크립트 실행
if __name__ == '__main__':
    main()

