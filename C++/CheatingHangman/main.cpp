#include <iostream>

#include "Hangman.h"

// Just a regular old game of Hangman ;)
// Lexxi Reddington

int main() {
    Hangman game{};

    while (!game.game_over()) {
        game.get_hint();
        game.guess_prompt();
        game.partition();
    }


    // Call Tests
    game.mask_word_test();
    return 0;
}
