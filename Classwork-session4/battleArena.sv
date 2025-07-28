package battleArena;
class battle;
string name;
int power;
int health;
function new(string name,int power,int health);
 this.name=name;
 power=$urandom(10,100);
 health=$urandom(100,200);
endfunction
function void attack (ref battle fighter);
    thies.health=health-fighter.power;
endfunction
function void display_status();
    $display("Name: %s, Power: %d, Health: %d", name, power, health);
endfunction
endclass
endpackage