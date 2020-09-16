//
// Created by Lexxi Reddington on 3/3/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PEPPERS_H
#define ASSIGNMENT4SHOPPINGCART_PEPPERS_H

#include "Weighted.h"

class Peppers : public Weighted {
public:
    Peppers(double weight);
    virtual std::string name() const override;
    virtual double price() const override;
private:
    double weight;
};


#endif //ASSIGNMENT4SHOPPINGCART_PEPPERS_H
