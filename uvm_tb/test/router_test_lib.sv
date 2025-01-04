class router_test extends uvm_test;
    
     `uvm_component_utils(router_test)
     
    int no_of_magent =1;
    int no_of_sagent =3;
    
    bit has_master_agent_top =1;
    bit has_slave_agent_top =1;
    
    bit has_score_board =1;
    bit has_virtual_sequencer =1;
    
    master_agent_config mconfig;
    slave_agent_config sconfig[];
    env_config econfig;
    
    router_env env_h;
    
    extern function new(string name = "router_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);
    
endclass 


   function router_test::new(string name = "router_test", uvm_component parent);
     
       super.new(name,parent);
   endfunction
   
   
//------------------------------------build_phase----------------------------------------------------------------

function void router_test::build_phase(uvm_phase phase);


      econfig = env_config::type_id::create("econfig");

      mconfig= master_agent_config::type_id::create("mconfig");
      
            if(!uvm_config_db #(virtual master_inf)::get(this,"","vif",mconfig.vif))
                 `uvm_fatal("TEST","cannot get mconfig data");
           
              mconfig.is_active = UVM_ACTIVE;
              
              econfig.m_config = mconfig;          //no of master config
         
         
         
      
       sconfig = new[no_of_sagent];  
       econfig.s_config=new[no_of_sagent];
       
  foreach(sconfig[i]) begin
      
      sconfig[i] = slave_agent_config::type_id::create($sformatf("sconfig[%d]",i));
      
        sconfig[i].is_active = UVM_ACTIVE;
      
          if(!uvm_config_db #(virtual slave_inf)::get(this,"",$sformatf("vif%0d",i),sconfig[i].vif))
          
              `uvm_fatal("TEST","cannot get sconfig data");
  
          econfig.s_config[i] = sconfig[i];          //no of slave config
          
      end
   
     
     econfig.no_of_magent = no_of_magent;       //no of sub master agents
     econfig.no_of_sagent = no_of_sagent;      //no of sub slave agents
     
     
     econfig.has_master_agent_top =has_master_agent_top;   //no of master env
     econfig.has_slave_agent_top  =has_slave_agent_top;    //no of slave env
     
     econfig.has_score_board      =has_score_board;
     econfig.has_virtual_sequencer=has_virtual_sequencer;
     
     uvm_config_db #(env_config)::set(this,"*","env_config",econfig);
                                     
     env_h = router_env::type_id::create("env_h",this);
     
     super.build_phase(phase);
     
endfunction

//---------------------------------------------end_of_elaboration_phase-------------------------------------------

function void router_test::end_of_elaboration_phase(uvm_phase phase);

   super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
   
endfunction



  
//==================================================================================================================
 
//--------------------------------small_test------------------------------------------------------------------------

//==================================================================================================================


class small_test extends router_test;
 
`uvm_component_utils(small_test)
 

  small_seq s_seq;
  
   delay_seq seq;
  
  bit[1:0] address;

 extern function new(string name = "small_test", uvm_component parent);
 extern function void build_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 
 
endclass

function small_test::new(string name = "small_test", uvm_component parent);
     
       super.new(name,parent);
   endfunction
   
//----------------------------------------------build_phase--------------------------------------------------------

function void small_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


//----------------------------------------------run_phase-----------------------------------------------------------


task small_test::run_phase(uvm_phase phase);

address = $random % 3;

uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);

s_seq = small_seq::type_id::create("s_seq");

seq  = delay_seq::type_id::create("seq");

phase.raise_objection(this);
fork
    s_seq.start(env_h.m_agent.magent[0].seqr);
    
    seq.start(env_h.s_agent.sagent[address].seqr);
join_none
 
phase.drop_objection(this);

endtask


       
//==================================================================================================================
 
//-----------------------------------------------medium_test---------------------------------------------------------

//==================================================================================================================



class medium_test extends router_test;
 
`uvm_component_utils(medium_test)
 

  medium_seq m_seq;
  
  delay_seq seq1;
  
  bit[1:0] address;

 extern function new(string name = "medium_test", uvm_component parent);
 extern function void build_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 
 
endclass

function medium_test::new(string name = "medium_test", uvm_component parent);
     
       super.new(name,parent);
   endfunction
   
//----------------------------------------------build_phase--------------------------------------------------------

function void medium_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


//----------------------------------------------run_phase-----------------------------------------------------------



task medium_test::run_phase(uvm_phase phase);

address = $random % 3;

uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);
fork

m_seq = medium_seq::type_id::create("m_seq");

seq1  = delay_seq::type_id::create("seq1");

join_none

phase.raise_objection(this);

    m_seq.start(env_h.m_agent.magent[0].seqr);
    
    seq1.start(env_h.s_agent.sagent[address].seqr);
    
phase.drop_objection(this);

endtask






       
//==================================================================================================================
 
//-----------------------------------------------large_test---------------------------------------------------------

//==================================================================================================================



class large_test extends router_test;
 
`uvm_component_utils(large_test)
 

  large_seq l_seq;
  
  delay_seq seq2;
  
  bit[1:0] address;

 extern function new(string name = "large_test", uvm_component parent);
 extern function void build_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 
 
endclass

function large_test::new(string name = "large_test", uvm_component parent);
     
       super.new(name,parent);
   endfunction
   
//----------------------------------------------build_phase--------------------------------------------------------

function void large_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


//----------------------------------------------run_phase-----------------------------------------------------------


task large_test::run_phase(uvm_phase phase);

address = $random % 3;

uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",address);

fork
l_seq = large_seq::type_id::create("l_seq");

seq2  = delay_seq::type_id::create("seq2");
join_none

phase.raise_objection(this);

    l_seq.start(env_h.m_agent.magent[0].seqr);
    
    seq2.start(env_h.s_agent.sagent[address].seqr);
    
phase.drop_objection(this);

endtask

