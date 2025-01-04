module top;

   import router_pkg::*;
   import uvm_pkg::*;
   
   bit clk;
   
   always begin
      #5 clk=~clk;
   end
   
   
    master_inf vif(clk);
    slave_inf  vif0(clk);
    slave_inf  vif1(clk);
    slave_inf  vif2(clk);
    
    
router_top DUV(.clock(clk),.data_in(vif.data_in),.resetn(vif.resetn),.pkt_valid(vif.pkt_valid),.err(vif.error),.busy(vif.busy),
                                         .data_out_0(vif0.data_out),.data_out_1(vif1.data_out),.data_out_2(vif2.data_out),
                                         .vld_out_0(vif0.vld_out),.vld_out_1(vif1.vld_out),.vld_out_2(vif2.vld_out),
                                         .read_enb_0(vif0.read_enb),.read_enb_1(vif1.read_enb),.read_enb_2(vif2.read_enb) ); 
                                         


             
   initial begin                       
     uvm_config_db #(virtual master_inf)::set(null,"*","vif",vif);
     uvm_config_db #(virtual slave_inf)::set(null,"*","vif0",vif0);
     uvm_config_db #(virtual slave_inf)::set(null,"*","vif1",vif1);
     uvm_config_db #(virtual slave_inf)::set(null,"*","vif2",vif2);
     run_test("small_test");
   end
endmodule


     
  


    
   
