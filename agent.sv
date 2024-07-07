class agent extends uvm_agent;
`uvm_component_utils(agent)
sequencer simple_sequencer;
driver simple_driver;
monitor simple_monitor;
    function new(string name="agent",uvm_component parent);
        super.new(name,parent);
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        simple_sequencer = sequencer::type_id::create("simple_sequencer", this);
        simple_driver = driver::type_id::create("simple_driver", this);
        simple_monitor = monitor::type_id::create("simple_monitor", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
        simple_driver.seq_item_port.connect(simple_sequencer.seq_item_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
    
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in agent run_phase", UVM_LOW)

    endtask
endclass:agent //agent extends superClass
