#include <iostream>
#include <iomanip>
#include <iostream>
#include <locale>

int main() {
    // Ensure Unicode output works
    std::setlocale(LC_ALL, "");







    std::wcout << L"A♠  K♦  Q♥  J♣" << std::endl;
    




std::wcout << L"\033[31mA♥\033[0m  "  // red
           << L"\033[34mK♦\033[0m  "  // blue-ish
           << L"\033[91mQ♥\033[0m  "  // bright red
           << L"\033[32mJ♣\033[0m\n"; // green


    return 0;
}

