


class master_sequencer extends uvm_sequencer #(master_trans);
   
   `uvm_component_utils(master_sequencer)
   
   extern function new(string name = "master", uvm_component parent);
   
endclass

function master_sequencer::new(string name = "master", uvm_component parent);
  super.new(name,parent);
  
endfunction