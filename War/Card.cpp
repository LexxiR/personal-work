//
// Created by Lexxi Reddington on 1/19/20.
//

#include <string>
#include "Card.h"

// Ctor
Card::Card(Face f, Suit s) : face(f), suit(s) {}

// Overloaded << operator (for printing)
std::ostream &operator<<(std::ostream &os, const Card &c) {
    std::string f, s;
    switch(c.face) {
        case Card::Face::Two : f = "2";
            break;
        case Card::Face::Three : f = "3";
            break;
        case Card::Face::Four : f = "4";
            break;
        case Card::Face::Five : f = "5";
            break;
        case Card::Face::Six : f = "6";
            break;
        case Card::Face::Seven : f = "7";
            break;
        case Card::Face::Eight : f = "8";
            break;
        case Card::Face::Nine : f = "9";
            break;
        case Card::Face::Ten : f = "10";
            break;
        case Card::Face::J : f = "J";
            break;
        case Card::Face::Q : f = "Q";
            break;
        case Card::Face::K : f = "K";
            break;
        case Card::Face::A : f = "A";
            break;
        default: f = "ERROR";
    }
    switch(c.suit) {
        case Card::Suit::Clubs : s = "Clubs";
            break;
        case Card::Suit::Diamonds : s = "Diamonds";
            break;
        case Card::Suit::Hearts : s = "Hearts";
            break;
        case Card::Suit::Spades : s = "Spades";
            break;
        default: s = "ERROR";
    }
    os << f << " of " << s;
    return os;
}

// Overloaded < operator for Card objects
bool operator<(const Card &lhs, const Card &rhs) {
    if (lhs.face < rhs.face) return true;
    else return false;
}

// Overloaded == operator for Card objects
bool operator==(const Card &lhs, const Card &rhs) {
    if (lhs.face == rhs.face) return true;
    else return false;
}
