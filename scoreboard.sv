class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
    uvm_analysis_imp #(sequence_item,scoreboard) simple_scoreboard_imp;
    sequence_item fifo[$];
    
    function new(string name="scoreboard",uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"in scoreboard new",UVM_LOW)
    
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        simple_scoreboard_imp = new("simple_scoreboard_imp",this);
        `uvm_info(get_type_name(),"in scoreboard build_phase",UVM_LOW)
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(),"in scoreboard connect_phase",UVM_LOW) 
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in scoreboard run_phase",UVM_LOW)
        forever begin
            sequence_item item;
            wait(fifo.size());
            item=fifo.pop_front();
            compare(item);
        end
    endtask
    function void write(sequence_item item);
        //`uvm_info(get_type_name(),$sformatf("A=%d   B=%d   sum=%d   cout=%d   ",t.A,t.B,t.sum,t.cout),UVM_LOW)
        fifo.push_back(item);
    endfunction

    function void compare(sequence_item item);

    logic [15:0] result = 16'b0;
    result= item.A + item.B;
    if (result == {item.cout,item.sum}) begin
        `uvm_info(get_type_name(),"pass successfully",UVM_LOW)
    end else begin
        `uvm_error(get_type_name(),$sformatf("error, A= %d, B=%d,  Result %d expected %d ",item.A,item.B,{item.cout,item.sum},result))
    end
    endfunction
endclass:scoreboard
