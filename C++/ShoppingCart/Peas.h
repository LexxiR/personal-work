//
// Created by Lexxi Reddington on 3/3/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_PEAS_H
#define ASSIGNMENT4SHOPPINGCART_PEAS_H


#include "Weighted.h"

class Peas : public Weighted {
public:
    Peas(double weight);
    virtual std::string name() const override;
    virtual double price() const override;
private:
    double weight;
};


#endif //ASSIGNMENT4SHOPPINGCART_PEAS_H
