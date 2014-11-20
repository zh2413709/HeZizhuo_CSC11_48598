#include <iostream>
using namespace std;

int main()
{
	int Temp_F = 90;
	int Temp_C;
	cout << "This program convert temperature from fahrenheit to celesius";
	Temp_C = (Temp_F-32)*5/9;
	cout << "You entered 90°F, that eauqls to " << Temp_C << "°C";
	return 0;
}