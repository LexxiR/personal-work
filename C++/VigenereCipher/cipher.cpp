//
// Created by Lexxi Reddington on 2/9/20.
//

#include "cipher.h"
#include "Letter.h"

#include <iostream>
#include <fstream>

// Ctor
cipher::cipher() {
    // Call the test functions for the Letter class
    testLetterAdd();
    testLetterSubtract();
}

// Function to read the contents of a file into a string
std::string cipher::read_file(std::string filename) {
    std::ifstream in(filename);
    if (!in.is_open()) {
        throw std::runtime_error("Couldn't open file");
    }
    std::string ret;
    while (!in.eof()) {
        // Read a single character
        char c = in.get();
        if (in.gcount() != 1) {
            // Hit EOF
            break;
        }
        ret += c;
    }
    in.close();
    return ret;
}

// Function to prompt the user for a key (string)
std::string cipher::key_prompt() {
    std::string k;
    std::cout << "Enter a key: ";
    std::cin >> k;

    // Determine if the key is valid
    // The key itself should be short and only contain alphabetic characters (be a word)
    int ct = 0;
    for (char c : k) {
        if (std::isalpha(c)) ++ct;
    }

    // Re-prompt until the user enters a valid key
    while (ct != k.size()) {
        std::cout << "Invalid key. Please re-enter: ";
        std::cin >> k;
        ct = 0;
        for (char c : k) {
            if (std::isalpha(c)) ++ct;
        }
    }

    // Force the key to be capitalized no matter user input
    std::string k_capitalized = "";
    for (char c : k) k_capitalized += std::toupper(c);
    return k_capitalized;
}

// Function to encrypt plaintext
std::string cipher::encrypt(std::string plaintext, std::string key) {
    // Extend the key to the length of the plaintext
    std::string k_resized = "";
    int i = 0;
    for (char c : plaintext) {
        if (std::isalpha(c)) {
            k_resized += key[i];
            if (i < key.size() - 1) ++i;
            else i = 0;
        } else {
            k_resized += " ";
        }
    }

    // Encryption process
    std::string d = "";
    for (int i = 0; i < plaintext.size(); ++i) {
        Letter plaintext_letter = Letter{plaintext[i]};
        Letter key_letter = Letter{k_resized[i]};
        // Magic line :)
        Letter ciphertext_letter = plaintext_letter + key_letter;
        d += ciphertext_letter.get();
    }
    return d;
}

// Function to write a string to a file
void cipher::write_file(std::string filename, std::string message) {
    std::ofstream out(filename);
    if (!out.is_open()) {
        throw std::runtime_error("Could not open file to write to");
    }
    out << message;
    out.close();
}

// Function to decrypt ciphertext
std::string cipher::decrypt(std::string ciphertext, std::string key) {
    // Extend the key to the length of the ciphertext
    std::string k_resized = "";
    int i = 0;
    for (char c : ciphertext) {
        if (std::isalpha(c)) {
            k_resized += key[i];
            if (i < key.size() - 1) ++i;
            else i = 0;
        } else {
            k_resized += " ";
        }
    }

    // Decryption process
    std::string decrypted_ciphertext = "";
    for (int i = 0; i < ciphertext.size(); ++i) {
        Letter ciphertext_letter = Letter{ciphertext[i]};
        Letter key_letter = Letter{k_resized[i]};
        // Magic line :)
        Letter plaintext_letter = ciphertext_letter - key_letter;
        decrypted_ciphertext += plaintext_letter.get();
    }
    return decrypted_ciphertext;
}

// Function to determine if the plaintext matches the decrypted ciphertext
std::string cipher::verify_match(std::string plaintext, std::string decrypted_ciphertext) {
    std::cout << "Plaintext: " << plaintext;
    std::cout << "Ciphertext: " << decrypted_ciphertext;
    if (plaintext.compare(decrypted_ciphertext) == 0) return "Success: The plaintext matches the decrypted ciphertext!\n";
    else return "Failure: The plaintext does NOT match the decrypted ciphertext!\n";
}
