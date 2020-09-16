#include "cipher.h"

#include <iostream>

/*
 * Vigenère Cipher
 * Lexxi Reddington
 */

int main() {
    // Let's create a cipher!
    cipher c{};

    // 1. Open a file and read it in as a string.
    std::string plaintext = c.read_file("plaintext.txt");

    // 2. Prompt the user for a key.
    std::string key = c.key_prompt();

    // 3. Encrypt the file with the key and write it out to a temporary file.
    c.write_file("temp.txt", c.encrypt(plaintext, key));

    // 4. Open the temporary file and read it in as a string.
    std::string ciphertext = c.read_file("temp.txt");

    // 5. Decrypt the file.
    std::string decrypted_ciphertext = c.decrypt(ciphertext, key);

    // 6. Verify that the plaintext and decrypted ciphertext match.
    std::cout << c.verify_match(plaintext, decrypted_ciphertext);

    return 0;
}
