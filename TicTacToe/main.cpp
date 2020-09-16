#include "TicTacToe.h"

/*
TicTacToe
Lexxi Reddington
Purpose: A program to play TicTacToe
*/

int main() {
    TicTacToe t{};
    while (!t.endGame()) {
        Move m = t.readMove();
        t.isValid(m);
        t.applyMove(m);
        t.switchCurrentPlayer();
    }
    return 0;
}
