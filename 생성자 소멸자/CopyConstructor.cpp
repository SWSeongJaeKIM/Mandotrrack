#include <iostream>
using namespace std;
class MyClass
{
private:
	int num1;
	int num2;
public:
	MyClass(int a, int b)
	{
	num1 = a;
	num2 = b;
	}
	void ShowData()
	{
	cout << "num1: " << num1 << " num2: " << num2 << endl;
	}
};

int main()
{
	MyClass mc1(80, 50);
	MyClass mc2 = mc1;

	mc2.ShowData();
	return 0;
}