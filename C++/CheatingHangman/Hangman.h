//
// Created by Lexxi Reddington on 3/11/20.
//

#ifndef ASSIGNMENT5CHEATINGHANGMAN_HANGMAN_H
#define ASSIGNMENT5CHEATINGHANGMAN_HANGMAN_H

#include <iostream>
#include <vector>
#include <map>


class Hangman {
public:
    Hangman();
    void read_file(std::string filename);
    char guess_prompt();
    std::string mask_word(std::string word, std::string guessed);
    void mask_word_test();
    void partition();
    void get_hint();
    void verify_guess();
    void list_possible_words();
    bool game_over();
private:
    std::string word;
    std::string guessed_letters;
    std::vector<std::string> current_word_list;
    std::map<std::string, std::vector<std::string>> map;
    int guesses_remaining;
    int correct_guesses;
};


#endif //ASSIGNMENT5CHEATINGHANGMAN_HANGMAN_H
