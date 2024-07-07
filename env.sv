class env extends uvm_env;
    `uvm_component_utils(env)
    agent simple_agent;
    scoreboard simple_scoreboard;
    coverage_collector simple_coverage_collector;
    function new(string name = "env", uvm_component parent);
        super.new(name,parent);
        `uvm_info(get_type_name(),"in env new",UVM_LOW)
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        simple_agent = agent::type_id::create("simple_agent", this);
        simple_scoreboard = scoreboard::type_id::create("simple_scoreboard", this);
        simple_coverage_collector = coverage_collector::type_id::create("simple_coverage_collector", this);
        `uvm_info(get_type_name(),"in env build_phase",UVM_LOW)
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
        //connect here subscriber with monitors via analysis port
        simple_agent.simple_monitor.simple_monitor_port.connect(simple_scoreboard.simple_scoreboard_imp);
        simple_agent.simple_monitor.simple_monitor_port.connect(simple_coverage_collector.simple_coverage_collector_imp);
        `uvm_info(get_type_name(),"in env new",UVM_LOW)
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in env run_phase",UVM_LOW)
    endtask
endclass:env
