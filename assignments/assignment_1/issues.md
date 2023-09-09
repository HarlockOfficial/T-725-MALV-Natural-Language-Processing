# Questions & Issues
In this file I am going to write all my questions and issues that rose during the development of this project.

## 1: Python Gutenberg Corpus
- Is the result ordering important?
    - for example: the results obtained with carroll-alice.txt for the 'ation' suffix were ordered differently
        Results from the professor:
        ```
        Nouns ending with 'ation': [’usurpation’, ’station’, ’accusation’, ’invitation’, ’consultation’, ’sensation’, ’explanation’, ’Multiplication’, ’conversation’, ’Uglification’, ’exclamation’]
        ```
        My Results:
        ```
        Nouns ending with 'ation': ['consultation', 'invitation', 'accusation', 'usurpation', 'Multiplication', 'Uglification', 'sensation', 'conversation', 'explanation', 'station', 'exclamation']
        ```
    - I think the ordering is not important, but I am not sure.
- Should I strip symbols like ```_``` and ```s``` (from the plurals) from the start/end of the tokens?
    - In my results, I have 
      ```
      Long types: ['_appropriation_', ..., '_introduction_', ..., 'accommodations', ..., 'communications', ..., 'congratulations', ..., 'considerations', ..., 'gratifications', ..., 'mortifications', ..., 'recommendations', ..., 'representations', ...] 
      ```  
      That are not included in the list of words ending with 'ation', I may agree on the absence of plural words, but I'm not sure about the ones with underscores.