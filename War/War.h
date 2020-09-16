//
// Created by Lexxi Reddington on 1/19/20.
//

#ifndef ASSIGNMENT2WAR_WAR_H
#define ASSIGNMENT2WAR_WAR_H

#include <vector>
#include <list>
#include "Card.h"

class War {
public:
    War();
    int hands_required();
    void print();
    void card_test();
private:
    std::vector<Card> deck;
    std::list<Card> p1;
    std::list<Card> p2;
    std::vector<Card> pool;
    int hands;
};

#endif //ASSIGNMENT2WAR_WAR_H
