//
// Created by Lexxi Reddington on 1/17/20.
//

#include "TicTacToe.h"
#include "Board.h"
#include "Move.h"

#include <iostream>

// Constructor
TicTacToe::TicTacToe() {
    std::cout << "Welcome to the Game of TicTacToe\n(Valid row and column entries are from 1 to 3)\n";
    gb = Board(); // Create the game board
    player = CurrentPlayer::o; // Game begins with letting player o start
    move = Move(); // Default constructor
    numMoves = 0; // Keep track of the number of moves played (for noticing a tie)
    state = GameState::not_over;
    gb.print_board();
}

// Function to reset the board (not used)
void TicTacToe::resetBoard() {
    gb = Board();
}

// Function to determine if a game move is valid
bool TicTacToe::isValid(Move m) const {
    return gb.is_valid_move(m.row, m.col);
}

// Function to apply a move to the game board
void TicTacToe::applyMove(Move m) {
    bool b = true; // True = player x, False = player o
    if (m.player == CurrentPlayer::o) b = false;
    gb.apply_move(m.row, m.col, b);
    gb.print_board();
    ++numMoves;
}

// Function to check the status of the game (not used)
GameState TicTacToe::status() const {
    return state;
}

// Function to check who is the current player (not used)
CurrentPlayer TicTacToe::getCurrentPlayer() const {
    return player;
}

// ADDED - Function to toggle between the two players (set the current player)
void TicTacToe::switchCurrentPlayer() {
    if (player == CurrentPlayer::o) {
        player = CurrentPlayer::x;
    } else  player = CurrentPlayer::o;
}

// ADDED - Function to read in a game move (re-prompts until a valid move is entered)
Move TicTacToe::readMove() {
    move.player = player;
    if (move.player == CurrentPlayer::o) std::cout << "Player o's turn. ";
    else std::cout << "Player x's turn. ";

    int r;
    int c;
    std::cout << "Enter a row and column: ";
    std::cin >> r >> c;

    while (true) {
        if ((r >= 1) && (r <= 3) && (c >= 1) && (c <= 3)) {
            move.row = r - 1;
            move.col = c - 1;
            if (isValid(move)) return move; // Ensures the returned move is valid too
        }

        // Re-prompt
        std::cout << "Invalid Entry!\n";
        if (move.player == CurrentPlayer::o) std::cout << "Player o's turn. ";
        else std::cout << "Player x's turn. ";
        std::cout << "Enter a row and column: ";
        std::cin >> r >> c;
    }
}

// ADDED - Function to determine if the game has ended and to print the appropriate statements
bool TicTacToe::endGame() {
    if (gb.game_over()) {
        if (player == CurrentPlayer::x) {
            state = GameState::Xwins; // This is flipped because the end of the while loop calls switchCurrentPlayer()
            std::cout << "Game Over ~ The o's Win!\n";
        } else {
            state = GameState::Owins;
            std::cout << "Game Over ~ The x's Win!\n";
        }
        return true;
    }
    if (numMoves == 9) {
        std::cout << "Game Over ~ TIE!\n";
        return true;
    }
    return false;
}
