#include <iostream>
#include <iomanip>

/*
 * Ordering a Pizza
 * Lexxi Reddington
 */
 
int main() {
   double totalCost = 0;
   double localCost = 0;
   std::string localResponse = "";
   std::string size = "";

   //Prompt
   std::cout << "How many pizzas would you like?" << std::endl;
   int numPizzas;
   std::cin >> numPizzas;

   for (int i = 1; i <= numPizzas; i++) {
      localCost = 0;
      localResponse = "";
   
      std::cout << "For pizza " << i << ": " << std::endl;
   
      std::cout << "What size pizza would you like? (Small, Medium, Large):" << std::endl;
      std::cin >> size;

      //Determine base cost of pizza
      if (size == "Small" || size == "small" || size == "S" || size == "s") {
         localCost += 7.00;
         localResponse += "A Small pizza ";
      } 
      else if (size == "Medium" || size == "medium" || size == "M" || size == "m") {
         localCost += 10.75;
         localResponse += "A Medium pizza ";
      } 
      else {
         localCost += 14.75;
         localResponse += "A Large pizza ";
      }

      //Determine toppings cost
      std::cout << "How many toppings would you like?" << std::endl;
      int numToppings;
      std::cin >> numToppings;
   
      double toppingCost;
   
      if (numToppings > 0) {
         if (size == "Small" || size == "small" || size == "S" || size == "s") {
            toppingCost = (0.50 * numToppings);
            localCost += toppingCost;
         } 
         else if (size == "Medium" || size == "medium" || size == "M" || size == "m") {
            toppingCost = (1.00 * numToppings);
            localCost += toppingCost;
         } 
         else {
            toppingCost = (1.50 * numToppings);
            localCost += toppingCost;
         }
         localResponse += "with " + std::to_string(numToppings) + " toppings";
      }

      //Determine extra sauce cost
      std::cout << "Would you like extra sauce for $0.50? (Y/N)" << std::endl;
      std::string sauce;
      std::cin >> sauce;
   
      if (sauce == "Y" || sauce == "y" || sauce == "Yes" || sauce == "yes") {
         localCost += 0.50;
         localResponse += " and extra sauce";
      }

      //Get cost per pizza
      localResponse += " is $";
      std::cout << std::setprecision(4) << localResponse << localCost << std::endl;
      totalCost += localCost;
   }

   //Subtotal
   std::cout << std::setprecision(4) << "Subtotal: $" << totalCost << std::endl;

   //Apply the sales tax
   double tax = totalCost * 0.04;
   totalCost += tax;
   std::cout << std::setprecision(4) << "Tax (4%): $" << tax << std::endl;

   //Print total, final cost
   std::cout << std::setprecision(4) << "Total: $" << totalCost << std::endl;
}