module datatype;
	//-------------My Inputs of Datatype---------------------------------
	bit signed  [3:0] a;
	bit signed [7:0] b;
	shortint signed  c;
	bit[3:0] d;
	real r;
	string mystring="SV Assigment1";
	//---------------------Done inputs of DataType------------------



	//-------------My struct------------------------------
		typedef struct 
	 	{
	 	  string name;
	 	  int id;
	 	  byte grade;
	 	}student_t;
	 //----------------End Of my struct----------------------
	 
	 //------------------MY UNION ----------------------------
	 typedef union{
	 	int i;
	 	byte b;
	 }data_u;
	 //---------------End of my UNION-------------------------

	//----------------Decleration---------------------------------
	bit unpacked [4:0]='{1,2,3,4,5};

	bit [1:0] packed_array [3:0]='{default:2'b10};

	byte unpacked2 [3:0]='{10,20,30,40};

	student_t students[2:0];

	data_u data;
	 //----------------------------INTIAL -BEGIN STATMENT-------------------------------------------
	 initial begin
	 	 a=-3;
	 	 b=250;
	 	 c=-12345;
	 	 d= 4'b 1101;
	 	 r=3.14159;
	 	$display(" value to a as decimal: %d",a);
	 	$display(" value of b :%0d",b);
	 	$display("Value of c :%0d",c);
	 	#5
	 	$diplay("Assigned value of d:%b",d);
	 	#15
	 	$display("Value of c :%f",r);
	 	$display("My string,%s",mystring);
	 	$display("---------------------------Arrays---------------------");
	 	
	 	$display("my unpacked array is:%p",unpacked);

	 	$display("my packed array is:%p",packed_array);
	 	
	 	$display("my second unpacked array is:%p",unpacked2);
	 

	 	
	 	students[0] = {"Ali", 1, 85};
		students[1] = {"Sara", 2, 90};
		students[2] = {"Omar", 3, 78};
		$display("------------------------ Students ----------------------");
        for (int i = 0; i < 3; i++) begin
            $display("Name: %s, ID: %0d, Grade: %0d", students[i].name, students[i].id, students[i].grade);
        end
        $display("------------------------ UNION  ----------------------");
        
        data.i=32'h12345678;
        $display("First attempt of data i is:%h,First attempt of data b is:%h",data.i,data.b);
         data.i=8'h12;
        $display("Second attempt of data i is:%h,Second attempt of data b is:%h",data.i,data.b);

        $display("DONNNNNNE SIMULATION YAYYYYYYYY");
	 end
endmodule : datatype

