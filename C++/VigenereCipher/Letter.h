//
// Created by Lexxi Reddington on 2/10/20.
//

#ifndef ASSIGNMENT3VIGENERECIPHER__LETTER_H
#define ASSIGNMENT3VIGENERECIPHER__LETTER_H

#include <ostream>

class Letter {
public:
    Letter(char c_);
    char get() const;
    void set(char val);
    friend Letter operator+(const Letter &lhs, const Letter &rhs);
    friend Letter operator-(const Letter &lhs, const Letter &rhs);
    friend std::ostream &operator<<(std::ostream &os, const Letter &let);
    friend bool operator!=(const Letter &lhs, const Letter &rhs);
    friend bool operator==(const Letter &lhs, const Letter &rhs);
    friend void testLetterAdd();
    friend void testLetterSubtract();
private:
    char c;
};

Letter operator+(const Letter &lhs, const Letter &rhs);
Letter operator-(const Letter &lhs, const Letter &rhs);
std::ostream &operator<<(std::ostream &os, const Letter &let);
bool operator!=(const Letter &lhs, const Letter &rhs);
bool operator==(const Letter &lhs, const Letter &rhs);
void testLetterAdd();
void testLetterSubtract();

#endif //ASSIGNMENT3VIGENERECIPHER__LETTER_H
