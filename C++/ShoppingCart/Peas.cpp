//
// Created by Lexxi Reddington on 3/3/20.
//

#include "Peas.h"

#include <sstream>
#include <iomanip>

Peas::Peas(double weight_) : weight(weight_) {
}

std::string Peas::name() const {
    std::stringstream ss;
    ss << "Peas (";
    ss << std::setprecision(2) << weight;
    ss << " lbs.)";
    return ss.str();
}

double Peas::price() const {
    return weight * 0.25;;
}