module battle_test;
import battleArena::*;
battle b1,b2;
    b1("BatMan");
    b2("SuperMan");
initial begin
    b1.display_status();
    b2.display_status();
    int random=$urandom_range(0,1);
    if(random==0)
    begin
    b1.attack(b2);
    b2.display_status();
    b1.display_status();
    if(b2.health<=0)
    begin 
        $display("----Superman win----");
    end 
    end else begin 
    b2.attack(b1);
    b2.display_status();
    b1.display_status();
    if(b1.health<=0)
    begin 
        $display(" ----Batman win----");
    end 
    end
end
endmodule