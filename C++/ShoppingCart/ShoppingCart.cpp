//
// Created by Lexxi Reddington on 3/2/20.
//

#include "ShoppingCart.h"

#include <iostream>
#include <memory>
#include <iomanip>

// Add items to the cart
void ShoppingCart::add_item(std::unique_ptr<Produce> i) {
    std::cout << "~~ " << i->name() << " Picked! ~~\n";
    cart.push_back(std::move(i));
}

// List the current contents of the cart
void ShoppingCart::contents() {
    std::cout << "~~~~~~~~~~CONTENTS~~~~~~~~~~\n";
    std::cout << "Shopping Cart Contents:\n";
    double total = 0;

    for (const auto & i : cart) {
        std::cout << "     " << i->name() << " at $" << i->price() << "\n";
        total += i->price();
    }

    std::cout << "\nTotal Items in Cart: " << cart.size() << "\n";
    std::cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}

// List the contents of the cart and print out the total and tax
void ShoppingCart::checkout() {
    std::cout << "~~~~~~~~~~CHECKOUT~~~~~~~~~~\n";
    std::cout << "Items Purchased:\n";
    double total = 0;

    for (const auto & i : cart) {
        std::cout << "     " << i->name() << " at $" << i->price() << "\n";
        total += i->price();
    }

    std::cout << "Subtotal: $" << total << "\n";
    double tax = total * 0.07;
    std::cout << "Tax (7% Rate): $" << tax << "\n";
    total += tax;
    std::cout << "\nTOTAL: $" << total << "\n";
    std::cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}
