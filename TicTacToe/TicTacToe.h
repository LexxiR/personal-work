//
// Created by Lexxi Reddington on 1/17/20.
//

#ifndef ASSIGNMENT1TICTACTOE_TICTACTOE_H
#define ASSIGNMENT1TICTACTOE_TICTACTOE_H

#include "Move.h"
#include "Board.h"

class TicTacToe {
public:
    TicTacToe();
    void resetBoard();
    bool isValid(Move m) const;
    void applyMove(Move m);
    GameState status() const;
    CurrentPlayer getCurrentPlayer() const;
    Move readMove();
    void switchCurrentPlayer();
    bool endGame();
private:
    Board gb;
    CurrentPlayer player;
    GameState state;
    Move move;
    int numMoves;
};

#endif //ASSIGNMENT1TICTACTOE_TICTACTOE_H
