//
// Created by Lexxi Reddington on 2/9/20.
//

#ifndef ASSIGNMENT3VIGENERECIPHER__CIPHER_H
#define ASSIGNMENT3VIGENERECIPHER__CIPHER_H

#include <string>

class cipher {
public:
    cipher();
    std::string read_file(std::string filename);
    std::string key_prompt();
    std::string encrypt(std::string plaintext, std::string key);
    void write_file(std::string filename, std::string message);
    std::string decrypt(std::string ciphertext, std::string key);
    std::string verify_match(std::string plaintext, std::string decrypted_ciphertext);
};

#endif //ASSIGNMENT3VIGENERECIPHER__CIPHER_H
