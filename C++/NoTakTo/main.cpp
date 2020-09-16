#include <iostream>
#include <vector>
#include "game.h"

/*
NoTakTo
Lexxi Reddington
Purpose: A program to play a 4x4 NoTakTo with just one board
*/

int main() {
    // Create a 4x4 game board
    std::vector<std::vector<bool>> board = create_board();

    // Set up
    bool player = false; // Keep track of which player's turn it is
    int row = -1; // Sentinel value to start
    int col = -1; // Sentinel value to start

    // Let's play!
    while (!game_over(board)) {
        print_board(board); // Show the board
        player = !player; // Change players
        if (player) {
            std::cout << "Player 1's turn" << std::endl;
        } else {
            std::cout << "Player 2's turn" << std::endl;
        }
        read_move(row, col); // Read in the player's move
        if (is_valid_move(board, row, col)) { // Check if that move is valid, apply it if it is
            board = apply_move(board, row, col);
        }
        // Repeat until the game is over
    }
    // The game is over at this point, so re-print the final board
    print_board(board);
    // Declare the winner!
    if (player) {
        std::cout << "Player 2 Wins!" << std::endl;
    } else {
        std::cout << "Player 1 Wins!" << std::endl;
    }
    return 0;
}