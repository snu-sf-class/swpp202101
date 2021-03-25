#include<vector>
#include<iostream>
using namespace std;

int main() {
	vector<int> v;
  v.push_back(0);
  v.push_back(1);
  v.push_back(2);
  v.pop_back();

  cout << v[2] << '\n';
  return 0;
}
