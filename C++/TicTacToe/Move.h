//
// Created by Lexxi Reddington on 1/17/20.
//

#ifndef ASSIGNMENT1TICTACTOE_MOVE_H
#define ASSIGNMENT1TICTACTOE_MOVE_H

enum class CurrentPlayer {
    x, o
};

class Move {
public:
    int row;
    int col;
    CurrentPlayer player;
};

#endif //ASSIGNMENT1TICTACTOE_MOVE_H
