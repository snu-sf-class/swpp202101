#include <cstdint>
#include <vector>
#include <iostream>
#include <fstream>
using namespace std;

uint64_t area(vector<pair<int, int>> &points);

int main(int argc, char **argv) {
  ifstream fin(argv[1]);
  int N, x, y;
  vector<pair<int, int>> points;

  fin >> N;
  for (int i = 0; i < N; ++i) {
    fin >> x >> y;
    points.emplace_back(x, y);
  }
  auto result = area(points);
  cout << result << endl;
  return 0;
}
