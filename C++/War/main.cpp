#include <iostream>
#include "War.h"

/*
War
Lexxi Reddington
Purpose: A program to simulate the game of war and count the number of hands it takes to play a game.
Then run this simulation many times to approximate how long a game lasts.
*/

int main() {
    War w{};

    // Call the test function
    w.card_test();

    // Simulate many games of war to determine the mean number of hands to end the game
    int sum_hands_required = 0;
    int num_trials = 1000000;

    for (int i = 0; i < num_trials; ++i) {
        sum_hands_required += w.hands_required();
    }

    // Output
    int mean_hands_required = sum_hands_required / num_trials;
    std::cout << "Mean Number of Hands Required for a Game of War: " << mean_hands_required << "\n";

    return 0;
}
