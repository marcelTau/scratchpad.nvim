// g++ cpp.cpp -std=c++2a && ./a.out
// change this line ^

#include <bits/stdc++.h>
#include <ranges>

int main() {
    std::vector<int> vals { 1, 2, 3, 4, 5 };

    const auto is_even = [](int n) -> bool { return n % 2 == 0; };

    for (int i : vals | std::views::filter(is_even)) {
        std::cout << i << ' ';
    }

    for (int i : vals) {
        std::cout << i << ' ';
    }
}
