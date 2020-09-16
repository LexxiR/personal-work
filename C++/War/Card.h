//
// Created by Lexxi Reddington on 1/19/20.
//

#ifndef ASSIGNMENT2WAR_CARD_H
#define ASSIGNMENT2WAR_CARD_H

#include <iostream>

class Card {
public:
    enum class Face {
        Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, J, Q, K, A
    };
    enum class Suit {
        Clubs, Diamonds, Hearts, Spades
    };
    Card(Face f, Suit s);
    friend std::ostream &operator<<(std::ostream &os, const Card &c);
    friend bool operator<(const Card &lhs, const Card &rhs);
    friend bool operator==(const Card &lhs, const Card &rhs);
private:
    Face face;
    Suit suit;
};

std::ostream &operator<<(std::ostream &os, const Card &c);

bool operator<(const Card &lhs, const Card &rhs);

bool operator==(const Card &lhs, const Card &rhs);

#endif //ASSIGNMENT2WAR_CARD_H
