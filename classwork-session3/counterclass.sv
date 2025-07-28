class MyCounter;
 int count;
 string name;
 static int total_count=0;
 static function increment(); 
    count++;
    total_count++;
 endfunction

 function new (string name);
    count = 0;
    this.name=name;
 endfunction 

    function void display_count();
        $display("Instance %s has count: %d", name, count);

    endfunction
    static function void display_total_count();
        $display("Total count across all instances: %d", total_count);
    endfunction

 endclass