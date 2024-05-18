class monitor;
	virtual apb_intf INTF;
	mailbox act_mbx;
	packet act_pkt;
	//packet act_queue [$];
	function new (string name = "apb_monitor", virtual apb_intf INTF); 
		//$display ("%s is created", name);	
		this.INTF = INTF;
		act_mbx=new();
		$display ("act_mbx created at mon");
		fork 
			capture_write(); 
			capture_read();
		join_none
	
	endfunction 

	task capture_write (); 
		forever begin 
			@(negedge INTF.pclk);
			if(INTF.psel && INTF.penable && INTF.pwrite && INTF.rst_n) begin 
				//$display ("[%0t] Write is captured:: Addr: %0h DATA:%0h", $time, INTF.paddr, INTF.pwdata);   
			end
		end 
	endtask 

	task capture_read (); 
		forever begin 
			@(negedge INTF.pclk);
			if(INTF.psel && INTF.penable && !INTF.pwrite && INTF.rst_n) begin 
				//$display ("[%0t] Read is captured:: Addr: %0h DATA:%0h", $time, INTF.paddr, INTF.prdata);
				act_pkt = new();
				//act_queue.push_front(act_pkt);
				act_pkt.addr = INTF.paddr;
				act_pkt.data = INTF.prdata;
				//$display ("actual monitor Addr :: %0h, DATA :: %0h", act_pkt.addr, act_pkt.data);
				act_mbx.put(act_pkt);   
			end
		end 
	endtask 


endclass
