class sequence1 extends uvm_sequence #(sequence_item) ;
    `uvm_object_utils(sequence1)
    sequence_item item;
    function new(string name ="sequence1");
        super.new(name);
        `uvm_info(get_type_name() ," in constructor of sequence ",UVM_HIGH)
    endfunction:new

    task body();
        
        item = sequence_item::type_id:: create("item");
        start_item(item);
        if(!(item.randomize()))begin
        `uvm_error(get_type_name(),"fail to randomize")
        end
        finish_item(item);
    endtask:body
endclass:sequence1
