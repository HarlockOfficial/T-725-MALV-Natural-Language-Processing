from typing import Union

import nltk
from nltk.corpus import gutenberg
from nltk.corpus import stopwords

nltk.download('punkt')
nltk.download('stopwords')
nltk.download('gutenberg')


def pretty_print(elements_to_pretty_print: dict[str, any]) -> str:
    out_string = ''
    for key, value in elements_to_pretty_print.items():
        out_string += f'{key}: {value}\n'
    return out_string


def extract_data(corpus: str, language: str, amount_characters_for_long_type: int, tokens_ending: str) -> dict[
        str, Union[str, int, list[tuple[str, int]]]]:
    out = dict()
    out['Text'] = corpus
    corpus_words = gutenberg.words(corpus)
    out['Tokens'] = len(corpus_words)
    corpus_types = set(corpus_words)
    out['Types'] = len(corpus_types)
    language_stopwords = stopwords.words(language)
    corpus_tokens_without_stopwords = [token for token in corpus_types if token not in language_stopwords]
    out['Types excluding stopwords'] = len(corpus_tokens_without_stopwords)
    corpus_frequence_distribution = nltk.FreqDist(corpus_words)
    out['10 most common tokens'] = corpus_frequence_distribution.most_common(10)
    # longest_type_length = len(max(corpus_types, key=len))
    # out['Long types'] = [token for token in corpus_types if len(token) == longest_type_length]
    out['Long types'] = sorted([token for token in corpus_types if len(token) > amount_characters_for_long_type], key=lambda x: x.lower())
    # Sorry, could not match the same ordering from the pdf
    out["Nouns ending with '" + tokens_ending + "'"] = [token for token in corpus_types if
                                                        token.endswith(tokens_ending)]
    return out


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Corpus Analysis')
    parser.add_argument('corpus', type=str, help='Corpus file')
    parser.add_argument('--language', type=str, default='english', help='Corpus language')
    parser.add_argument('--amount_characters_for_long_type', type=int, default=13,
                        help='Amount of characters for long type')
    parser.add_argument('--tokens_ending', type=str, default='ation', help='Tokens ending')
    parser.add_argument('--print', type=bool, default=True, help='Print to console')
    parser.add_argument('--save', action='store_true', help='Save to file')
    parser.add_argument('--output', type=str, default='output.txt', help='Output file')

    args = parser.parse_args()

    data = extract_data(args.corpus, args.language, args.amount_characters_for_long_type, args.tokens_ending)
    string_result = pretty_print(data)
    if args.print:
        print(string_result)
    if args.save:
        with open(args.output, 'w') as f:
            f.write(string_result)
