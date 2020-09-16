//
// Created by Lexxi Reddington on 3/3/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PEACH_H
#define ASSIGNMENT4SHOPPINGCART_PEACH_H

#include "Produce.h"

class Peach : public Produce {
public:
    virtual std::string name() const override;
    virtual double price() const override;
};


#endif //ASSIGNMENT4SHOPPINGCART_PEACH_H
