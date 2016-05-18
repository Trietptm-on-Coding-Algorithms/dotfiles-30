#include <iostream>
#include <string>
#include <curl/curl.h>

using namespace std;

void username(char uname[5])
{
    cout << uname << endl;
}

int main(void)
{
    char x[5];
    cout << "Username: " << endl;
    cin >> x;
    username (x);
}
