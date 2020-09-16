//
// Created by Lexxi Reddington on 3/11/20.
//

#include "Hangman.h"

#include <iostream>
#include <fstream>
#include <map>
#include <vector>


// Function to read the contents of a file into a string
void Hangman::read_file(std::string filename) {
    std::ifstream in(filename);
    if (!in.is_open()) {
        throw std::runtime_error("Couldn't open file");
    }
    std::vector<std::string> ret;
    std::string word;
    while (in >> word) {
        ret.push_back(word);
    }
    in.close();
    current_word_list = ret;
}

Hangman::Hangman() : guessed_letters(""), correct_guesses(0) {
    read_file("wordsSHORT");
    std::cout << "What word length do you want? ";
    int length;
    std::cin >> length;
    if (length >= 1) {
        // Initialize word to be entirely masked and of the desired length
        for (int i = 0; i < length; ++i) {
            word.append("_");
        }
    }
    // Initialize the map
   // map.insert(std::pair<std::string, std::vector<std::string>>(word, current_word_list));
    std::cout << "There are " << current_word_list.size() << " words of length " << length << "\n";
    std::cout << "------------------------------------------\n";

    //list_possible_words();

    guesses_remaining = length;
}

char Hangman::guess_prompt() {
    std::cout << "What letter do you want to guess? ";
    char letter;
    std::cin >> letter;
    while (!std::isalpha(letter)) {
        std::cout << "Invalid Entry! Only letters from the standard English alphabet are accepted.\n";
        std::cout << "What letter do you want to guess? ";
        std::cin >> letter;
    }
    int repeat = 0;
    for (int i = 0; i < guessed_letters.size(); ++i) {
        if (letter == guessed_letters[i]) {
            ++repeat;
        }
    }
    while (repeat > 0) {
        std::cout << "Invalid Entry! The letter \'" << letter << "\' was already guessed.\n";
        std::cout << "What letter do you want to guess? ";
        std::cin >> letter;
        repeat = 0;
        for (int i = 0; i < guessed_letters.size(); ++i) {
            if (letter == guessed_letters[i]) {
                ++repeat;
            }
        }
    }
    std::tolower(letter); // Ensure all letters in guessed_letters is lowercase
    guessed_letters.push_back(letter);
    std::cout << "You have guessed \'" << letter << "\'\n";
    return 0;
}

std::string Hangman::mask_word(std::string word, std::string guessed) {
    std::string ret = word;
    for (int i = 0; i < word.size(); ++i) {
        ret[i] = '_';
    }
    for (int j = 0; j < guessed.size(); ++j) {
        for (int i = 0; i < word.size(); ++i) {
            if (word[i] == guessed[j]) {
                ret[i] = word[i];
            }
        }
    }
    return ret;
}

void Hangman::mask_word_test() {
    std::string word = "dog";
    std::string guessed = "k";
    if (mask_word(word, guessed) != "___") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    guessed = "kg";
    if (mask_word(word, guessed) != "__g") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    guessed = "kgo";
    if (mask_word(word, guessed) != "_og") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    guessed = "kgod";
    if (mask_word(word, guessed) != "dog") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    word = "cat";
    guessed = "";
    if (mask_word(word, guessed) != "___") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    guessed = "a";
    if (mask_word(word, guessed) != "_a_") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    word = "Lexxi";
    guessed = "x";
    if (mask_word(word, guessed) != "__xx_") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
    guessed = "xe";
    if (mask_word(word, guessed) != "_exx_") {
        std::cout << "Error in masking \"" << word << "\" with the letters \"" << guessed << "\"\n";
    }
}

void Hangman::partition() {
    for (int i = 0; i < current_word_list.size(); ++i) {
        std::string mw = mask_word(current_word_list[i], guessed_letters);

        std::map<std::string, std::vector<std::string>>::iterator it = map.find(mw);
        if(it == map.end()) {
            // Key-value pair not already present in map
            std::vector<std::string> v = {current_word_list[i]};
            map[mw] = v;
        }
        else {
            std::vector<std::string> v = it->second;
            v.push_back(current_word_list[i]);
            map[mw] = v;
        }
    }
    int max_partite = 0;

    // Print out contents of map
    std::cout << "The partite sets from your guess are: \n";
    for (std::map<std::string, std::vector<std::string>>::iterator it = map.begin(); it != map.end(); ++it) {
        std::cout << it->first << ": ";
        for (int i = 0; i < it->second.size(); ++i) {
            std::cout << it->second[i] << " ";
        }
        std::cout << "\n";
        // Determine which partite set is the biggest and store that set as the new current_word_list
        if (it->second.size() > max_partite) {
            max_partite = it->second.size();
            current_word_list = it->second;
            word = it->first;
        }
    }
    // Reset the map for the next time
    map.clear();
    verify_guess();
}

void Hangman::get_hint() {
    std::cout << "You have " << guesses_remaining << " incorrect guesses left.\n";
    std::cout << "Current hint: " << word << "\n";
    std::cout << "Guessed letters: ";
    for (auto letter : guessed_letters) {
        std::cout << letter;
    }
    std::cout << "\n";
}

//verify guess
// Tell the user if their guess was correct
void Hangman::verify_guess() {
    int ct = 0;
    for (auto letter : word) {
        if (letter == guessed_letters[guessed_letters.size() - 1]) ++ct;
    }
    if (ct > 0) {
        std::cout << "You have guessed correctly!\n";
        std:: cout << "------------------------------------------\n";
        ++correct_guesses;
    }
    else {
        std::cout << "Unfortunately \'" << guessed_letters[guessed_letters.size() - 1] << "\' is not in the word\n";
        std:: cout << "------------------------------------------\n";
        --guesses_remaining;
    }
}

void Hangman::list_possible_words() {
    std::cout << "The possible words are: ";
    for (auto word : current_word_list) {
        std::cout << word << " ";
    }
    std::cout << "\nThere are " << current_word_list.size() << " words still possible.\n";
}

bool Hangman::game_over() {
    if (guesses_remaining >= 0 && correct_guesses == word.size()) {
        std::cout << "YOU WIN! The word was \'" << word << "\'.\n";
        return true;
    }
    else {
        list_possible_words();
        return false;
    }
}




