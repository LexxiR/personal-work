//
// Created by Lexxi Reddington on 3/3/20.
//

#include "Peppers.h"

#include <sstream>
#include <iomanip>

Peppers::Peppers(double weight_) : weight(weight_) {
}

std::string Peppers::name() const {
    std::stringstream ss;
    ss << "Peppers (";
    ss << std::setprecision(2) << weight;
    ss << " lbs.)";
    return ss.str();
}

double Peppers::price() const {
    return weight * 0.75;;
}
