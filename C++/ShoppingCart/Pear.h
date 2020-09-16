//
// Created by Lexxi Reddington on 3/3/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PEAR_H
#define ASSIGNMENT4SHOPPINGCART_PEAR_H


#include "Produce.h"

class Pear : public Produce {
public:
    virtual std::string name() const override;
    virtual double price() const override;
};


#endif //ASSIGNMENT4SHOPPINGCART_PEAR_H
