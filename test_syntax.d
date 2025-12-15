struct Test { int x; int y; } void test() { auto t1 = Test(x: 1, y: 2); auto t2 = Test{x: 1, y: 2}; }
