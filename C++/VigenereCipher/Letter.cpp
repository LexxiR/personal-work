//
// Created by Lexxi Reddington on 2/10/20.
//

#include "Letter.h"

#include <iostream>

// Ctor
Letter::Letter(char c_) : c(c_){}

// Function to return the value (char) of a Letter object
char Letter::get() const {
    return c;
}

// Function to set the value (char) of a Letter object
void Letter::set(char val) {
    c = val;
}

// Overloaded + operator to encrypt letters
// PURPOSE: ciphertext_letter = plaintext_letter + key_letter
Letter operator+(const Letter &lhs, const Letter &rhs) {
    char c;
    if (std::isalpha(lhs.get())) {
        int rhs_num = (int) rhs.get() - 65; // The key was forced to be capitalized
        if (std::isupper(lhs.get())) {
            int lhs_num = (int) lhs.get() - 65; // A in ASCII is 65 but we want 0 here
            int ret = (lhs_num + rhs_num) % 26;
            c = char(ret + 65);
        } else {
            int lhs_num = (int) lhs.get() - 97; // a in ASCII is 97 but we want 0 here
            int ret = (lhs_num + rhs_num) % 26;
            c = char(ret + 97);
        }
    } else c = lhs.get();

    return Letter{c};
}

// Overloaded - operator to decrypt letters
// PURPOSE: plaintext_letter = ciphertext_letter - key_letter
Letter operator-(const Letter &lhs, const Letter &rhs) {
    char c;
    if (std::isalpha(lhs.get())) {
        int rhs_num = (int) rhs.get() - 65; // The key was forced to be capitalized
        if (std::isupper(lhs.get())) {
            int lhs_num = (int) lhs.get() - 65; // A in ASCII is 65 but we want 0 here
            int ret = (lhs_num - rhs_num) % 26;
            if (ret < 0) c = char(ret + 65 + 26); // Correct for mod in encryption process
            else c = char(ret + 65);
        } else {
            int lhs_num = (int) lhs.get() - 97; // a in ASCII is 97 but we want 0 here
            int ret = (lhs_num - rhs_num) % 26;
            if (ret < 0) c = char(ret + 97 + 26); // Correct for mod in encryption process
            else c = char(ret + 97);
        }
    } else c = lhs.get();
    return Letter{c};
}

// Overloaded print operator
std::ostream &operator<<(std::ostream &os, const Letter &let) {
    os << let.c;
    return os;
}

// Overloaded not equals operator
bool operator!=(const Letter &lhs, const Letter &rhs) {
    return lhs.c != rhs.c;
}

// Overloaded equals operator
bool operator==(const Letter &lhs, const Letter &rhs) {
    return lhs.c == rhs.c;
}

// Function Testing for + Operator!
void testLetterAdd() {
    Letter plain{'H'};
    Letter key{'K'};
    Letter cipher{'R'};
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set('o');
    key.set('E');
    cipher.set('s');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set('w');
    key.set('Y');
    cipher.set('u');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set(' ');
    key.set(' ');
    cipher.set(' ');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set('v');
    key.set('K');
    cipher.set('f');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set('e');
    key.set('E');
    cipher.set('i');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    plain.set('x');
    key.set('Y');
    cipher.set('v');
    if (cipher != plain + key) {
        std::cout << "Error: " << plain << " + " << key << " = " << plain + key << ", expected " << cipher << "\n";
    }

    std::cout << "testLetterAdd() Completed Successfully\n";
}

// Function Testing for - Operator!
void testLetterSubtract() {
    Letter cipher{'R'};
    Letter key{'K'};
    Letter plain{'H'};
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set('s');
    key.set('E');
    plain.set('o');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set('u');
    key.set('Y');
    plain.set('w');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set(' ');
    key.set(' ');
    plain.set(' ');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set('f');
    key.set('K');
    plain.set('v');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set('i');
    key.set('E');
    plain.set('e');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    cipher.set('v');
    key.set('Y');
    plain.set('x');
    if (plain != cipher - key) {
        std::cout << "Error: " << cipher << " - " << key << " = " << cipher - key << ", expected " << plain << "\n";
    }

    std::cout << "testLetterSubtract() Completed Successfully\n";
}
