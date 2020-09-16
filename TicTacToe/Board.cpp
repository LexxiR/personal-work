//
// Created by Lexxi Reddington on 1/18/20.
//

#include "Board.h"

#include <vector>
#include <iostream>

// Constructor (Function to create the game board)
// This is a 3x3 board
Board::Board() {
    for (int i = 0; i < 3; ++i) {
        std::vector<CellState> row;
        for (int j = 0; j < 3; ++j) {
            row.push_back(CellState::empty);
        }
        board.push_back(row);
    }
}

// Function to print the game board to the console
void Board::print_board() {
    for (auto i : board) {
        for (auto j : i) {
            if (j == CellState::X) std::cout << "x";
            else if (j == CellState::O) std::cout << "o";
            else std::cout << "-";
        }
        std::cout << "\n";
    }
}

// Function to determine if a game move is valid for the game board
bool Board::is_valid_move(int row, int col) const {
    if ((size(board) < row) || (row < 0)) {
        return false;
    }
    if ((size(board[0]) < col) || (col < 0)) {
        return false;
    }
    if (board[row][col] == CellState::empty) {
        return true;
    }
    return false;
}

// Function to apply a move to the game board
// True = player x, False = player o
void Board::apply_move(int row, int col, bool b) {
    if (b) board[row][col] = CellState::X;
    else board[row][col] = CellState::O;
}

// Function to determine if the game is over (TicTacToe Rules)
bool Board::game_over() {
    for (int i = 0; i < size(board); ++i) {
        for (int j = 0; j < size(board); ++j) {
            if ((board[i][0] == CellState::X) && (board[i][1] == CellState::X) && (board[i][2] == CellState::X)) {
                return true; // Three x's across
            }
            if ((board[0][j] == CellState::X) && (board[1][j] == CellState::X) && (board[2][j] == CellState::X)) {
                return true; // Three x's vertically
            }
            if ((board[0][0] == CellState::X) && (board[1][1] == CellState::X) && (board[2][2] == CellState::X)) {
                return true; // Three x's diagonally from left
            }
            if ((board[0][2] == CellState::X) && (board[1][1] == CellState::X) && (board[2][0] == CellState::X)) {
                return true; // Three x's diagonally from right
            }
            if ((board[i][0] == CellState::O) && (board[i][1] == CellState::O) && (board[i][2] == CellState::O)) {
                return true; // Three o's across
            }
            if ((board[0][j] == CellState::O) && (board[1][j] == CellState::O) && (board[2][j] == CellState::O)) {
                return true; // Three o's vertically
            }
            if ((board[0][0] == CellState::O) && (board[1][1] == CellState::O) && (board[2][2] == CellState::O)) {
                return true; // Three o's diagonally from left
            }
            if ((board[0][2] == CellState::O) && (board[1][1] == CellState::O) && (board[2][0] == CellState::O)) {
                return true; // Three x's diagonally from right
            }
        }
    }
    return false;
}
