class test extends uvm_test;
    `uvm_component_utils(test)

    env simple_env;
    sequence1 simple_sequence;
    function new(string name ="test" , uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"in Test new",UVM_LOW)

    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        simple_env = env::type_id::create("simple_env", this);
        `uvm_info(get_type_name(),"in test build phase",UVM_LOW)

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
        `uvm_info(get_type_name(),"in test connect_phase",UVM_LOW)

    endfunction
    function void end_of_elaboration_phase(uvm_phase phase); 
    super.end_of_elaboration_phase(phase); 
    this.print(); 
    factory.print(); 
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in test run_phase",UVM_LOW)
        phase.raise_objection(.obj(this));
        repeat(1000)begin
            simple_sequence = sequence1::type_id::create("simple_sequence");
            simple_sequence.start(simple_env.simple_agent.simple_sequencer);//inst names
        end
        phase.drop_objection(this);
    endtask
endclass:test

