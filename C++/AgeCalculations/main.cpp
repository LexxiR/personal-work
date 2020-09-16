#include <iostream>
/*
 * Age Calculations
 * Lexxi Reddington
 */
int main() {
    //Prompt
    std::cout << "How old are you in years?" << std::endl;

    //Read age from user
    double age;
    std::cin >> age;

    //Print response
    std::cout << "You have been alive for:\n";

    //Months alive
    std::cout << age*12 << " months\n";

    //Days alive
    int days = age*365 + age/4;
    std::cout << days << " days\n";

    //Minutes alive
    std::cout << days*24*60 << " minutes\n";

    //Seconds alive
    std::cout << static_cast<long int>(days)*24*60*60 << " seconds\n";

    //Milliseconds alive
    double ms = static_cast<double>(days)*24*60*60*1000;
    std::cout << ms << " milliseconds\n";

    //Dog years alive
    std::cout << age*7 << " dog years" << std::endl;
}