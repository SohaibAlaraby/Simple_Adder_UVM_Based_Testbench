class driver extends uvm_driver#(sequence_item);
    `uvm_component_utils(driver)
    //seq_item_port
    virtual aintf intf;
    sequence_item item;
    function new(string name="driver",uvm_component parent);
        super.new(name,parent);   
    endfunction //new()
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        if(!(uvm_config_db #(virtual aintf)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found")
        end 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
        
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
       `uvm_info(get_type_name(),"in driver run_phase", UVM_LOW)

        forever begin
             item = sequence_item::type_id::create("item");
             seq_item_port.get_next_item(item);
             drive(item);
             seq_item_port.item_done();
        end 
    endtask
    task drive(sequence_item item);
      @(posedge intf.clk)
        intf.A <= item.A;
        intf.B <= item.B;
    endtask
endclass:driver //driver extends superClass
