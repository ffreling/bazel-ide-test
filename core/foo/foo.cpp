#include "foo.hpp"

#include <unistd.h>
#include <cstdlib>
#include <iostream>
#include <ctime>
#include <chrono>
#include <thread>

Foo::Foo() {
    std::srand(std::time(0));
}

int Foo::r() const {
    std::this_thread::sleep_for(std::chrono::milliseconds(10));
    return std::rand() % 256;
}

int Foo::g() const {
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    return std::rand() % 256;
}

int Foo::b() const {
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    return std::rand() % 256;
}
