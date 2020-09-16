//
// Created by Lexxi Reddington on 3/2/20.
//

#ifndef ASSIGNMENT4SHOPPINGCART_SHOPPINGCART_H
#define ASSIGNMENT4SHOPPINGCART_SHOPPINGCART_H


#include "Produce.h"

#include <memory>
#include <vector>

class ShoppingCart {
public:
    void add_item(std::unique_ptr<Produce> i);
    void contents();
    void checkout();
private:
    std::vector<std::unique_ptr<Produce>> cart;
};


#endif //ASSIGNMENT4SHOPPINGCART_SHOPPINGCART_H
