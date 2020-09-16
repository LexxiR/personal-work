#include <iostream>

/*
 * Drawing Pictures
 * Lexxi Reddington
 */

// FUNCTION DECLARATIONS
bool string_compare(std::string a, std::string b);

int prompt_range(int min, int max);

void square(int s);

void box(int s);

void diagonaldown(int s);

void diagonalup(int s);

void checkerboard(int s);

// MAIN
// Ask for user input and respond accordingly (draw pretty pictures)
int main() {
    std::string response;

    for (;;) {
        std::cout << "Please enter a command: " << "\n";
        std::cin >> response;

        if (string_compare(response, "help")) {
            std::cout << "Acceptable commands: help, quit, square, box, diagonaldown, diaonalup, checkerboard\n";
        } else if (string_compare(response, "quit")) {
            return 0;
        } else if (string_compare(response, "square")) {
            int size = prompt_range(1,15);
            square(size);
        } else if (string_compare(response, "box")) {
            int size = prompt_range(3,15);
            box(size);
        } else if (string_compare(response, "diagonaldown")) {
            int size = prompt_range(3,15);
            diagonaldown(size);
        } else if (string_compare(response, "diagonalup")) {
            int size = prompt_range(3,15);
            diagonalup(size);
        } else if (string_compare(response, "checkerboard")) {
            int size = prompt_range(5,15);
            checkerboard(size);
        } else {
            std::cout << "Invalid command\n";
        }
    }
}

// FUNCTION DEFINITIONS
// Function to compare two strings (not case sensitive)
bool string_compare(std::string a, std::string b) {
    if (a.size() != b.size()) {
        return false;
    }
    for (int i = 0; i < a.size(); ++i) {
        if (std::tolower(a[i]) != std::tolower(b[i])) {
            return false;
        }
    }
    return true;
}

// Function to prompt the user for a size and re-prompt if the user input is not within the required size range
int prompt_range(int min, int max) {
    for (;;) {
        std::cout << "Please enter a size between " << min << " and " << max << ": ";
        int input;
        std::cin >> input;

        if (min <= input && input <= max) {
            return input;
        }
        std::cout << "The value " << input << " is not in a valid range." << std::endl;
    }
}

// Function to draw a square
void square(int s) {
    std::cout << "\n";
    for (int row = 0; row < s; ++row) {
        for (int col = 0; col < s; ++col) {
            std::cout << "*";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

// Function to draw a box
void box(int s) {
    std::cout << "\n";
    for (int row = 0; row < s; ++row) {
        for (int col = 0; col < s; ++col) {
            if (col == 0 || col == s - 1 || row == 0 || row == s - 1) {
                std::cout << "*";
            } else {
                std::cout << " ";
            }
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

// Function to draw a diagonal line starting from the top left and going to the bottom right
void diagonaldown(int s) {
    std::cout << "\n";
    for (int row = 0; row < s; ++row) {
        for (int col = 0; col < s; ++col) {
            if (row == col) {
                std::cout << "*";
            } else {
                std::cout << " ";
            }
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

// Function to draw a diagonal line starting from the bottom left and going to the upper right
void diagonalup(int s) {
    for (int row = 0; row < s; ++row) {
        for (int col = 0; col < s; ++col) {
            if ((row + col) == s) {
                std::cout << "*";
            } else {
                std::cout << " ";
            }
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}

// Function to draw a checkerboard
void checkerboard(int s) {
    std::cout << "\n";
    for (int row = 0; row < s; ++row) {
        for (int col = 0; col < s; ++col) {
            if ((row + col) % 2 == 0) {
                std::cout << "*";
            } else {
                std::cout << " ";
            }
        }
        std::cout << "\n";
    }
    std::cout << "\n";
}