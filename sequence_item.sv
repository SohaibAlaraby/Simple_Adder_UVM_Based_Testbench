class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item)
    parameter bits = 4;
    rand logic [bits-1 : 0] A;
    rand logic [bits-1 : 0] B;
    logic [bits-1 : 0] sum;
    logic cout;
    constraint greater_than {A >= B;}
    function new(string name = "sequence_item");
        super.new(name);
        `uvm_info(get_type_name(),"in Sequence_Item constructor",UVM_HIGH)
    endfunction //new()
    

endclass:sequence_item //sequence_item extends superClass
