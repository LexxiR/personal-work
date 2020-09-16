#include <iostream>
#include <string>
#include <fstream>

/*
Simple Steganography
Lexxi Reddington
Purpose: Hide a payload into a larger message by altering the capitalization of the larger message
*/

// Function Prototypes
std::string encode_char(std::string block, char payload);
char decode_char(std::string block);
int find_boundary(std::string message, int start);
std::string encode_string(std::string message, std::string payload);
std::string decode_string(std::string message);
std::string read_file(std::string filename);
void write_file(std::string filename, std::string message);

// Test Function Prototypes
void test_encode_char();
void test_decode_char();
void test_find_boundary();
void test_encode_string();
void test_decode_string();

int main() {
    // Call the test functions
    test_encode_char();
    test_decode_char();
    test_find_boundary();
    test_encode_string();
    test_decode_string();
    try {
        // Read in a file for the message
        std::string message = read_file("manalone.txt");
        // Read in a file for the payload
        std::string payload = read_file("payload.txt");
        // Encode the payload into the message
        std::string encoded_message = encode_string(message, payload);
        // Write out the encoded message into a new file
        write_file("steganography.txt", encoded_message);
        // Read in the newly written file
        std::string hidden_message = read_file("steganography.txt");
        // Extract the hidden message
        std::string extracted_hidden_message = decode_string(hidden_message);
        // Print out the extracted hidden message
        std::cout << extracted_hidden_message << "\n";
    }
    catch (std::runtime_error e) {
        std::cout << "Error: " << e.what() << "\n";
    }
    catch (std::logic_error e) {
        std::cout << "Caught logic error\n";
    }
    catch (...) {
        std::cout << "Caught exception of unknown type\n";
    }
    return 0;
}

// FUNCTION DEFINITIONS
// Function Definition ~ Encode Char
std::string encode_char(std::string block, char payload) {
    int current = 0;
    int length = block.length();

    for (int offset = 7; offset >= 0; --offset) {
        //Find the next alphabetic character
        while (!std::isalpha(block[current]) && current < length) {
            ++current;
        }
        // Ensure we haven't walked past the end of the block
        if (current >= length) {
            throw std::runtime_error("Oh no! Current is not at least the length!");
        }
        // Fix the output case
        if ((payload >> offset) & 1) {
            block[current] = std::toupper(block[current]);
        } else {
            block[current] = std::tolower(block[current]);
        }
        ++current;
    }
    return block;
}

// Function Definition ~ Decode Char
char decode_char(std::string block) {
    int ret = 0;
    int remaining = 8; // number of letters we are still looking for

    // Go through every character in the message
    for (char& c : block) {
        // Verify it is a letter, otherwise ignore it
        if (std::isalpha(c)) {
            --remaining;

            // If it is upper case, that indicates a 1
            // Otherwise we can ignore it
            if (std::isupper(c)) {
                ret |= 1 << remaining; // set the remaining bit of ret to 1
            }

            // If we found all the bits we are looking for, stop
            if (remaining == 0) {
                break;
            }
        }
    }
    if (remaining != 0) {
        throw std::runtime_error("Oh no! We didn't find all the characters we needed!");
    }
    return ret;
}

// Function Definition ~ Find Boundary
int find_boundary(std::string message, int start) {
    // Count how many characters after start you need to travel to find 8 alphabetic characters
    // If not enough are found, return -1
    int offset = 0;
    int remaining = 8;
    while(remaining > 0) {
        if (start + offset >= message.length()) {
            return -1;
        }
        if (std::isalpha(message[start + offset])) {
            --remaining;
        }
        ++offset;
    }
    return offset;
}

// Function Definition ~ Encode String
std::string encode_string(std::string message, std::string payload) {
    std::string ret = "";
    int start = 0;

    // Encode the payload
    for (char& c : payload) {
        int block_length = find_boundary(message, start);
        if (block_length == -1) {
            throw std::runtime_error("Oh no! Block length is too short!");
        }
        std::string block = message.substr(start, block_length);
        ret.append(encode_char(block, c));
        start += block_length;
    }
    // Encode a null terminator
    int block_length = find_boundary(message, start);
    if (block_length == -1) {
        throw std::runtime_error("Oh no! Block length is too short!");
    }
    std::string block = message.substr(start, block_length);
    ret.append(encode_char(block, '\0'));
    start += block_length;

    // Add remainder of message
    std::string remainder = message.substr(start); // SHOULD BE substring of message starting at start, going to the end of the string
    ret.append(remainder);

    return ret;
}

// Function Definition ~ Decode String
std::string decode_string(std::string message) {
    std::string ret = "";
    int start = 0;

    while(true) {
        int block_length = find_boundary(message, start);

        // Ensure we have enough to make a block
        if (block_length == -1) {
            throw std::runtime_error("Oh no! Not enough to make a block!");
        }
        std::string block = message.substr(start, block_length);
        char c = decode_char(block);

        // Check for null terminator
        if (c == '\0') {
            break;
        }
        ret.append(1, c);
        start += block_length;
    }
    return ret;
}

// Function Definition ~ Read File (From Class)
std::string read_file(std::string filename) {
    std::ifstream in(filename);
    if (!in.is_open()) {
        throw std::runtime_error("Couldn't open file");
    }
    std::string ret;
    // Reads the file character by character
    // This is inefficient, but faster ways are more confusing (relatively)
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

// Function Definition ~ Write File (From Class)
void write_file(std::string filename, std::string message) {
    std::ofstream out(filename);
    if (!out.is_open()) {
        throw std::runtime_error("Could not open file to write to");
    }
    out << message;
    out.close();
}

// TEST FUNCTION DEFINITIONS
// Test Function Definition ~ Encode Char
void test_encode_char() {
    // Simple cases
    if (encode_char("abcdefgh", 'A') != "aBcdefgH") {
        std::cout << "Error: In encode char, input 'abcdefgh', 'A' returned '" << encode_char("abcdefgh", 'A') << "'\n";
    }
    if (encode_char("abcdefgh", 'a') != "aBCdefgH") {
        std::cout << "Error: In encode char, input 'abcdefgh', 'a' returned '" << encode_char("abcdefgh", 'a') << "'\n";
    }

    // Expect failure if not enough characters provided
    try {
        std::string foo = encode_char("abcdefg", 'A');
        std::cout << "Error: In encode char, did not throw error when attempted to encode a char into"
                     " a string that was not long enough\n";
    } catch (...) {}

    // Cases with special characters in strings (whitespace etc)
    if (encode_char("a b c d e f g h", 'A') != "a B c d e f g H") {
        std::cout << "Error: In encode char, input 'a b c d e f g h', 'A' returned '"
                  << encode_char("a b c d e f g h", 'A') << "'\n";
    }
    if (encode_char("a\tbcdefgh", 'A') != "a\tBcdefgH") {
        std::cout << "Error: In encode char, input 'a\tbcdefgh', 'A' returned '"
                  << encode_char("a\tbcdefgh", 'A') << "'\n";
    }
    if (encode_char("a\nbcdefgh", 'A') != "a\nBcdefgH") {
        std::cout << "Error: In encode char, input 'a\nbcdefgh', 'A' returned '"
                  << encode_char("a\nbcdefgh", 'A') << "'\n";
    }
}

// Test Function Definition ~ Decode Char
void test_decode_char() {
    if (decode_char("aBcdefgH") != 'A') {
        std::cout << "Error: In decode char, input 'aBcdefgH' returned '" << decode_char("aBcdefgH") << "'\n";
    }
    if (decode_char("aBCdefgH") != 'a') {
        std::cout << "Error: In decode char, input 'aBCdefgH' returned '" << decode_char("aBCdefgH") << "'\n";
    }

    try {
        char foo = decode_char("abcdefg");
        std::cout << "Error: In decode char, did not throw error when attempted to decode too short of a block\n";
    } catch (...) {}

    if (decode_char("a B c d e f g H") != 'A') {
        std::cout << "Error: In decode char, input 'a B c d e f g H' returned '" << decode_char("a B c d e f g H") << "'\n";
    }
    if (decode_char("a\tBcdefgH") != 'A') {
        std::cout << "Error: In decode char, input 'a\tBcdefgH' returned '" << decode_char("a\tBcdefgH") << "'\n";
    }
    if (decode_char("a\nBcdefgH") != 'A') {
        std::cout << "Error: In decode char, input 'a\nBcdefgH' returned '" << decode_char("a\nBcdefgH") << "'\n";
    }
}

// Test Function Definition ~ Find Boundary
void test_find_boundary() {
    if (find_boundary("abcdefgh",0) != 8) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("abc   defgh",0) != 11) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("xxxabcdefgh",3) != 8) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("Few quips galvanized the mock jury box.",0) != 9) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("Few quips galvanized the mock jury box.",9) != 9) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("Few quips galvanized the mock jury box.",18) != 10) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("Few quips galvanized the mock jury box.",28) != 10) {
        std::cout <<  "Error" << "'\n";
    }
    if (find_boundary("small",0) != -1) {
        std::cout <<  "Error" << "\n";
    }
}

// Test Function Definition ~ Encode String
void test_encode_string() {
    if (encode_string("abcdefgh", "") != "abcdefgh") {
        std::cout << "Error 1" << "\n";
    }
    if (encode_string("abcdefghstuvwxyz", "A") != "aBcdefgHstuvwxyz") {
        std::cout << "Error 2: " << encode_string("abcdefghstuvwxyz", "A") << "\n";
    }
    if (encode_string("abcdefghstuvwxyz", "a") != "aBCdefgHstuvwxyz") {
        std::cout << "Error 3" << encode_string("abcdefghstuvwxyz", "a") << "\n";
    }
    if (encode_string("Few quips galvanized the mock jury box.", "Hi!") != "fEw qUips gALvAniZed The moCk jury box.") {
        std::cout << "Error 4" << encode_string("Few quips galvanized the mock jury box.", "Hi!") << "\n";
    }
    if (encode_string("ABCDEFGHIJKLMNOPQRSTUVWXYZ", "A") != "aBcdefgHijklmnopQRSTUVWXYZ") {
        std::cout << "Error 5" << "\n";
    }
    try {
        encode_string("small", "way too long of a payload here");
        std::cout << "Error: Expected exception for call\n";
    } catch (...) {}
}

// Test Function Definition ~ Decode String
void test_decode_string() {
    if (decode_string("abcdefgh") != "") {
        std::cout << "Error" << "\n";
    }
    if (decode_string("aBcdefgHstuvwxyz") != "A") {
        std::cout << "Error" << "\n";
    }
    if (decode_string("aBCdefgHstuvwxyz") != "a") {
        std::cout << "Error" << "\n";
    }
    if (decode_string("fEw qUips gALvAniZed The moCk jury box.") != "Hi!") {
        std::cout << "Error" << "\n";
    }
    if (decode_string("aBcdefgHijklmnopQRSTUVWXYZ") != "A") {
        std::cout << "Error" << "\n";
    }
    try {
        decode_string("small");
        std::cout << "Error: Expected exception for call\n";
    } catch (...) {}
}
