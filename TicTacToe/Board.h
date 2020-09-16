//
// Created by Lexxi Reddington on 1/18/20.
//

#ifndef ASSIGNMENT1TICTACTOE_BOARD_H
#define ASSIGNMENT1TICTACTOE_BOARD_H

#include <vector>

enum class GameState {
    not_over, Xwins, Owins, tie
};

enum class CellState {
    X, O, empty
};

class Board {
public:
    Board();
    void print_board();
    bool is_valid_move(int row, int col) const;
    void apply_move(int row, int col, bool b);
    bool game_over();
private:
    std::vector<std::vector<CellState>> board;
};

#endif //ASSIGNMENT1TICTACTOE_BOARD_H
