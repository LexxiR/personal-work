//
// Created by Lexxi Reddington on 1/19/20.
//

#include <random>
#include "War.h"

// Ctor ~ Create the deck and deal to each player
War::War() {
    // Set the number of hands required for this game to 0
    hands = 0;

    // Create the deck of 52 cards
    for (int suit = 0; suit < 4; ++suit) {
        for (int face = 2; face < 15; ++face) {
            deck.push_back(Card{Card::Face(face), Card::Suit(suit)});
        }
    }

    // Shuffle the deck
    std::random_device rd;
    std::mt19937 g(rd());
    std::shuffle(deck.begin(), deck.end(), g);

    // Deal to the two players
    for (int i = 0; i < (deck.size()/2); ++i) {
        p1.push_back(deck[i]);
    }
    for (int i = (deck.size()/2); i < deck.size(); ++i) {
        p2.push_back(deck[i]);
    }
}

// Function to print out the full deck of cards (used for debugging)
void War::print() {
    for (int i = 0; i < deck.size(); ++i) {
        std::cout << deck[i] << "\n";
    }
}

// Function to return an integer which represents the number of hands required to play out the constructed game
int War::hands_required() {
    // START OF WAR
    // Continue so long as both players have cards
    while ((p1.size() > 0) && (p2.size() > 0)) {

        ++hands;

        // Get each player's top card
        Card top_p1 = p1.front();
        Card top_p2 = p2.front();

        // Put the top card from each player's deck in the common pool
        pool.push_back(top_p1);
        pool.push_back(top_p2);

        // Doing the above means those top cards are no longer in the players' decks
        p1.pop_front();
        p2.pop_front();

        // Prepare shuffle
        std::random_device rd;
        std::mt19937 g(rd());

        // Now compare the two cards (Note: pool[0] is player 1's top card)
        // The player with the higher card takes all of the cards in the common pool and places them on the bottom of their personal deck
        if (top_p1 < top_p2) {
            // Shuffle before adding the cards to the bottom of the player's deck
            std::shuffle(pool.begin(), pool.end(), g);
            for (int i = 0; i < pool.size(); ++i) {
                p2.push_back(pool[i]);
            }
            // The pool is now empty
            pool = {};
        }
        if (top_p2 < top_p1) {
            std::shuffle(pool.begin(), pool.end(), g);
            for (int i = 0; i < pool.size(); ++i) {
                p1.push_back(pool[i]);
            }
            pool = {};
        }
        // If pool[0] = pool[1] then reveal another card for comparison
    }

    // Determine the winner (NOTE: Output commented out for the simulation)
    /*
    if (p1.size() > p2.size()) {
        std::cout << "Congratulations Player 1 ~ You Won!\n";
    } else if (p1.size() < p2.size()) {
        std::cout << "Congratulations Player 2 ~ You Won!\n";
    } else {
        std::cout << "The Game is a Draw!\n";
    }
    */

    // Return the number of hands for this game
    return hands;
}

// Test Function
void War::card_test() {
    Card A{Card::Face::A, Card::Suit::Hearts};
    Card B{Card::Face::K, Card::Suit::Hearts};
    Card C{Card::Face::Three, Card::Suit::Diamonds};
    Card D{Card::Face::Five, Card::Suit::Spades};
    Card E{Card::Face::Eight, Card::Suit::Clubs};

    // TESTS
    if (!(B < A)) {
        std::cout << "Error: Expected KH < AH\n";
    }
    if (!(C < B)) {
        std::cout << "Error: Expected 3D < KH\n";
    }
    if (!(C < A)) {
        std::cout << "Error: Expected 3D < AH\n";
    }
    if (!(D < E)) {
        std::cout << "Error: Expected 5S < 8C\n";
    }
    if (!(E < B)) {
        std::cout << "Error: Expected 8C < KH\n";
    }
    if (!(A==A)) {
        std::cout << "Error: Expected AH == AH\n";
    }
    if (!(B==B)) {
        std::cout << "Error: Expected KH == KH\n";
    }
    if (!(C==C)) {
        std::cout << "Error: Expected 3D == 3D\n";
    }
    if (!(D==D)) {
        std::cout << "Error: Expected 5S == 5S\n";
    }
    if (!(E==E)) {
        std::cout << "Error: Expected 8C == 8C\n";
    }
}
