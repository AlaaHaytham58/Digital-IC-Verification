module arrays_practise;
bit  [7:0] arr1[5];
bit [2:0][7:0]arr2;
bit [7:0]arr3[3];
bit [7:0]arr4 [] ;
initial begin
//ask why array size always print zero???
foreach (arr1[i]) 
    arr1[i] = 2*i;
arr2=24'h FFFFFF;
arr3='{8'h AA,8'h BB,8'h CC};
arr4  =new[5];
foreach (arr4[i]) begin
        arr4[i] = arr2[i];  
    end
foreach(arr4[i]) 
    $display("arr4  [%0d] = %h", i, arr4[i]);
arr4=new[7](arr4);
foreach(arr4[i]) 
    $display("arr4  [%0d] = %h", i, arr4[i]);
arr4.delete(6);
$display("After deleting last element new length of arr4 = %0d", arr4.size());
arr4.delete();
$display("After deleting all elements new length of arr4 = %0d", $size(arr4));
end
endmodule;