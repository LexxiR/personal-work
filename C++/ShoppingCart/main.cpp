#include <iostream>

#include "ShoppingCart.h"
#include "Peach.h"
#include "Pear.h"
#include "Pineapple.h"
#include "Peppers.h"
#include "Peas.h"

// Shopping Cart
// Lexxi Reddington 

int main() {
    ShoppingCart cart;

    // Initial print statements
    std::cout << "~ PRESENTING THE PREMIUM PRODUCE PATCH ~" << std::endl;
    std::cout << "~~ Peter Piper picked peaches, pears, pineapples, peppers, and peas here ~~" << std::endl;
    std::cout << "\nNote: At any time, entering:" << std::endl;
    std::cout << "     - 'list' will print out a list of all the products" << std::endl;
    std::cout << "     - 'contents' will list the current contents of the cart" << std::endl;
    std::cout << "     - 'checkout' will list the contents of the cart, print out the total and tax, then terminate the program" << std::endl;

    // Grab the first command
    std::string command;
    std::cout << "\nPlease enter a produce preference: ";
    std::cin >> command;

    // Case insensitivity
    transform(command.begin(), command.end(), command.begin(), ::tolower);
    while (command != "quit") {
        if (command == "list") {
            std::cout << "PRODUCE OPTIONS: 'peach', 'pear', 'pineapple', 'peppers', 'peas'" << std::endl;
            std::cout << "Note: At any time, entering:" << std::endl;
            std::cout << "     - 'list' will print out a list of all the products" << std::endl;
            std::cout << "     - 'contents' will list the current contents of the cart" << std::endl;
            std::cout << "     - 'checkout' will list the contents of the cart, print out the total and tax, then terminate the program" << std::endl;
        } else if (command == "contents") {
            cart.contents();
        } else if (command == "checkout") {
            cart.checkout();
            break;
        } else if (command == "peach") {
            cart.add_item(std::make_unique<Peach>());
        } else if (command == "pear") {
            cart.add_item(std::make_unique<Pear>());
        } else if (command == "pineapple") {
            cart.add_item(std::make_unique<Pineapple>());
        } else if (command == "peppers") {
            std::cout << "Please enter desired amount (in pounds): ";
            double w;
            std::cin >> w;
            cart.add_item(std::make_unique<Peppers>(w));
        } else if (command == "peas") {
            std::cout << "Please enter desired amount (in pounds): ";
            double w;
            std::cin >> w;
            cart.add_item(std::make_unique<Peas>(w));
        } else {
            std::cout << "Invalid Entry!\n";
        }
        // Re-prompt
        std::cout << "\nPlease enter a produce preference: ";
        std::cin >> command;
        transform(command.begin(), command.end(), command.begin(), ::tolower);
    }
    return 0;
}