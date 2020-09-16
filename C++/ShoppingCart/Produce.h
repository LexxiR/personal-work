//
// Created by Lexxi Reddington on 3/2/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PRODUCE_H
#define ASSIGNMENT4SHOPPINGCART_PRODUCE_H

#include <string>

class Produce {
public:
    virtual std::string name() const = 0;
    virtual double price() const = 0;
};


#endif //ASSIGNMENT4SHOPPINGCART_PRODUCE_H
