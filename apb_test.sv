class apb_test; 
	
	 apb_env env; 
	
	function new (string name = "apb_test", virtual apb_intf INTF); 
		//$display ("%s is created", name); 
		env = new ("env",INTF);
	endfunction 
	
	task run_test(); 
		//reset
		env.agent.drv.reset();
		for (int i=0; i < (2**8)-1; i++)begin 
			//i++;
			env.agent.drv.write(i, $random);
			env.agent.drv.read(i);
		end
		//$display ("1st write done"); 
		//env.agent.drv.write(8'd0,16'hdacd);
		//$display ("2nd write done");
		//env.agent.drv.write(8'd1,16'hdabd);
		//$display ("3rd write done");
		//env.agent.drv.write(8'd2,16'hdabb);
		 
		//env.agent.drv.write(8'd3,16'hdbbd);
		//$display ("4th write done"); 
		//env.agent.drv.write(8'd4,16'hdadd);
		//$display ("5th write done"); 
		//env.agent.drv.write(8'd5,16'hddbd);
		//$display ("6th write done"); 
		//env.agent.drv.write(8'd6,16'hdadd);
		//$display ("7th write done"); 

		//env.agent.drv.write(8'b0,16'hdabcd);
		//env.agent.drv.write(8'd1,16'hdabbd);
		//env.agent.drv.write(8'd2,16'hdabbb);
		//env.agent.drv.write(8'd3,16'hdbbcd);
		//env.agent.drv.write(8'd4,16'hdabdd);
		//env.agent.drv.write(8'd5,16'hddbcd);
		//env.agent.drv.write(8'd6,16'hdadcd);

		//env.agent.drv.read(8'd0);
		//$display ("1st read done"); 
		//env.agent.drv.read(8'd1);
		//$display ("2nd read done"); 
		//env.agent.drv.read(8'd2);
		//$display ("3rd read done"); 
		//env.agent.drv.read(8'd3);
		//$display ("4th read done"); 
		//env.agent.drv.read(8'd4);
		//$display ("5th read done"); 
		//env.agent.drv.read(8'd5);
		//$display ("6th read done"); 
		//env.agent.drv.read(8'd7);
		//$display ("7th read done"); 

		//env.agent.drv.write(8'b0,16'hdabcd);
		//env.agent.drv.write(8'd1,16'hdabbd);
		//env.agent.drv.write(8'd2,16'hdabbb);
		//env.agent.drv.write(8'd3,16'hdbbcd);
		//env.agent.drv.write(8'd4,16'hdabdd);
		//env.agent.drv.write(8'd5,16'hddbcd);
		//env.agent.drv.write(8'd6,16'hdadcd);
		
	endtask 
endclass 
