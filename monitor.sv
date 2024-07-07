class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    virtual aintf intf;
    uvm_analysis_port#(sequence_item) simple_monitor_port;
    sequence_item item;
    function new(string name = "monitor",uvm_component parent);
        super.new(name,parent);
    endfunction //new()
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        simple_monitor_port=new("simple_monitor_port",this);
        //assert(uvm_config_db#(virtual aintf)::get(this, "*", "intf", intf));
        if(!(uvm_config_db #(virtual aintf)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found") 
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in monitor run_phase", UVM_LOW)
        wait(intf.A);
        forever begin
            item = sequence_item::type_id::create("item");
            @(posedge intf.clk)
            item.A = intf.A;
            item.B = intf.B;
            @(negedge intf.clk)
            item.sum = intf.sum;
            item.cout = intf.cout;
            
            simple_monitor_port.write(item);
            
        end
    endtask
endclass:monitor //monitor extends superClass
