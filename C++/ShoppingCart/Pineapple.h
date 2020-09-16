//
// Created by Lexxi Reddington on 3/3/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PINEAPPLE_H
#define ASSIGNMENT4SHOPPINGCART_PINEAPPLE_H


#include "Produce.h"

class Pineapple : public Produce {
public:
    virtual std::string name() const override;
    virtual double price() const override;
};


#endif //ASSIGNMENT4SHOPPINGCART_PINEAPPLE_H
