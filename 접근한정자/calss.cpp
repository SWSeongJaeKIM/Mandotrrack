#include <iostream>
using namespace std;

class Character
{
private:
    int hp;

public:
    void setHp(int _hp);
    int getHp();
};
void Character::setHp(int _hp)
{
    hp = _hp;
}
int Character::getHp()
{
    return hp;
}
int main()
{
    Character mario;
    mario.setHp(400);
    cout << mario.getHp() << endl;
    return 0;
}
