class driver; 
	//expected mailbox
	mailbox exp_mbx;
	//packet instance 
	packet pkt;
	virtual apb_intf  INTF;
	function new (string name, virtual apb_intf INTF); 
		//$display ("%s is created", name);	
		this.INTF = INTF;
		exp_mbx = new ();
	endfunction 
	
	task reset();
		//$display ("[%t] Reset called", $time);
		repeat (2)@(negedge INTF.pclk);
		INTF.rst_n  <= 1'b0; 
		INTF.pwrite <= 1'b0; 
		INTF.psel	<= 1'b0;
		INTF.paddr	<= 8'd0;
		INTF.pwdata	<= 32'd0;
		INTF.penable<= 1'b0;
		//repeat (5)@(negedge INTF.pclk);
		@(negedge INTF.pclk);
		INTF.rst_n  <= 1'b1;
		//$display ("[%t] Reset done", $time);
		@(negedge INTF.pclk);	
	endtask
	
	task write(logic [7:0] addr, logic [31:0] data); 
		//setup
		//$display ("[%t] write task called", $time);
		@(negedge INTF.pclk); //writing only pclk will not work, cause drive knows only INTF
			//pkt = new();
			//pkt.data = data;
			//pkt.addr = addr;
			//$display ("expected drvr addr :: %0h, data :: %0h", pkt.addr, pkt.data);
			INTF.pwrite <= 1'b1; 
			INTF.psel	<= 1'b1;
			INTF.paddr	<= addr;
			INTF.pwdata	<= data;
		//Enable
 
		@(negedge INTF.pclk);
			INTF.penable <= 1'b1;
			//$display ("[%t] write done", $time);
		//Idle
		@(negedge INTF.pclk);
			INTF.pwrite 	<= 1'b0; 
			INTF.psel		<= 1'b0;
			INTF.penable 	<= 1'b0;
			pkt = new();
			pkt.data = data;
			pkt.addr = addr;
			//$display ("expected drvr addr :: %0h, data :: %0h", pkt.addr, pkt.data);
			exp_mbx.put(pkt);
		//@(negedge INTF.pclk);
	endtask 

	task read(logic [7:0] addr); 
		//setup
		//$display ("[%0t] Read called", $time);
		@(negedge INTF.pclk); //writing only pclk will not work, cause drive knows only INTF)
			INTF.pwrite <= 1'b0; 
			INTF.psel	<= 1'b1;
			INTF.paddr	<= addr;
			//INTF.pwdata	<= data;
		//Enable
 
		@(negedge INTF.pclk);
			INTF.penable <= 1'b1;
			//$display ("[%t] read done", $time);
		//Idle
		@(negedge INTF.pclk);
			INTF.pwrite 	<= 1'b0; 
			INTF.psel		<= 1'b0;
			INTF.penable 	<= 1'b0;
			//$display ("read done");
		@(negedge INTF.pclk);
	endtask
	
endclass
