


class router_env extends uvm_env;

  `uvm_component_utils(router_env)
  
  master_agent_top m_agent;
  
  slave_agent_top s_agent;
  
  env_config econfig;
  
  extern function new(string name = "router_env",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  
endclass

  function router_env::new(string name = "router_env",uvm_component parent);
       super.new(name,parent);
  endfunction
  
    
//---------------------------------------------------build_phase----------------------------------------------------------
  
  
  function void router_env::build_phase(uvm_phase phase);
       
       if(!uvm_config_db #(env_config)::get(this,"","env_config",econfig))
           
           `uvm_fatal("ENV","get econfig was not working see once set");
           
       super.build_phase(phase);
       
       
       
       if(!econfig.has_master_agent_top)
           `uvm_error("ENV","has_master_agent_top");
           
       m_agent = master_agent_top::type_id::create("m_agent",this);
       
       
       
       if(!econfig.has_slave_agent_top)
            `uvm_error("ENV","has_slave_agent_top");
            
       s_agent = slave_agent_top::type_id::create("s_agent",this);
   
endfunction
   
   

       