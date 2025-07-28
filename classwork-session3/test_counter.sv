module class_counter;
    MyCounter c1,c2;
    initial begin
        c1 = new("Counter1");
        c2 = new("Counter2");

        c1.increment();
        c1.increment();
        c2.increment();

        c1.display_count();
        c2.display_count();

        MyCounter::display_total_count();
        $finish;
    end
endmodule