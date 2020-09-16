//
// Created by Victoria Reddington on 11/6/19.
//

#include <iostream>
#include <vector>

// Function to read in a game move (re-prompts until a valid move is entered)
void read_move(int &row, int &col) {
    int r;
    int c;

    std::cout << "Enter a row and column: ";
    std::cin >> r >> c;

    while (true) {
        if ((r >= 1) && (r <= 4) && (c >= 1) && (c <= 4)) {
           row = r - 1;
           col = c - 1;
           break;
        }
        std::cout << "Error: Row out of range\n";
        std::cout << "Enter a row and column: ";
        std::cin >> r >> c;
    }
}

// Function to create the game board
std::vector<std::vector<bool>> create_board(int row, int col) {
    std::vector<std::vector<bool>> board;
    for (int i = 0; i < row; ++i) {
        std::vector<bool> row;
        for (int j = 0; j < col; ++j) {
            row.push_back(false);
        }
        board.push_back(row);
    }
    return board;
}

// Function to print the game board to the console
void print_board(std::vector<std::vector<bool>> board) {
    for (auto i : board) {
        for (auto j : i) {
            if (j) std::cout << "X";
            else std::cout << ".";
        }
        std::cout << "\n";
    }
}

// Function to determine if the game has ended (based on the NoTakTo rules)
bool game_over(std::vector<std::vector<bool>> board) {
    for (int i = 0; i < size(board); ++i) {
        for (int j = 0; j < size(board); ++j) {
            if (board[i][0] && board[i][1] && board[i][2] && board[i][3]) {
                return true;
            }
            if (board[0][j] && board[1][j] && board[2][j] && board[3][j]) {
                return true;
            }
            if (board[0][0] && board[1][1] && board[2][2] && board[3][3]) {
                return true;
            }
            return false;
        }
    }
}

// Function to apply a move to the game board (put an X where a . is)
std::vector<std::vector<bool>> apply_move(std::vector<std::vector<bool>> board, int row, int col) {
    board[row][col] = true;
    return board;
}

// Function to determine if a move is valid for the given game board
bool is_valid_move(std::vector<std::vector<bool>> board, int row, int col) {
    if ((size(board) < row) || (row < 0)) {
        return false;
    }
    if ((size(board[0]) < col) || (col < 0)) {
        return false;
    }
    if (!board[row][col]) {
        return true;
    }
    return false;
}