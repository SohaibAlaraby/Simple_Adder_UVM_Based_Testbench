class coverage_collector extends uvm_subscriber#(sequence_item);
`uvm_component_utils(coverage_collector)
    sequence_item item;
    uvm_analysis_imp #(sequence_item,coverage_collector) simple_coverage_collector_imp;
    covergroup cg;
        option.per_instance=1;
        A:coverpoint item.A{
        bins All_Ones={4'hF};
        bins All_Zeros={4'h0};
        bins random_stimulus = default;
        }
        B:coverpoint item.B{
        bins All_Ones={4'hF};
        bins All_Zeros={4'h0};
        bins random_stimulus = default;
        }
    endgroup:cg
    function new(string name="coverage_collector",uvm_component parent);
        super.new(name,parent);
        cg=new();
        simple_coverage_collector_imp = new("simple_coverage_collector_imp",this);
    endfunction //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase); 
        
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase); 
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),"in Coverage_Collector run_phase", UVM_LOW)

    endtask
    function void write(sequence_item t);
        item = sequence_item::type_id::create("item");
        $cast(item,t);
        cg.sample();
    endfunction
endclass:coverage_collector //coverage_collector extends superClass
