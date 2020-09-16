//
// Created by Victoria Reddington on 11/6/19.
//

#ifndef ASSIGNMENT6NOTAKTO_GAME_H
#define ASSIGNMENT6NOTAKTO_GAME_H

void read_move(int &row, int &col);
std::vector<std::vector<bool>> create_board(int row = 4, int col = 4);
void print_board(std::vector<std::vector<bool>> board);
bool game_over(std::vector<std::vector<bool>> board);
std::vector<std::vector<bool>> apply_move(std::vector<std::vector<bool>> board, int row, int col);
bool is_valid_move(std::vector<std::vector<bool>> board, int row, int col);

#endif //ASSIGNMENT6NOTAKTO_GAME_H
