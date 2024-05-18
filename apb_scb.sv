class apb_scb; 
	mailbox exp_mbx;
	mailbox act_mbx;
	
	// packet instance 
	packet exp_pkt;
	packet act_pkt;
	packet exp_pkt_c;
	packet act_pkt_c;

	//taking instance of an array to store expected packet 
	//packet exp_arry [9:0]; //packet type cause we are saving packet type in this array, both save data and data save variable have to be of same type
	packet exp_queue [$];
	//packet act_queue [$];
	function new (string name = "apb_scb", virtual apb_intf INTF);
		$display ("%s is created", name);
		act_mbx = new();
		exp_mbx = new();
		//$display ("act_mbx created at scb");
		fork
			get_exp_packet();
			get_act_pkt ();
		join_none
	endfunction 
	
	//get expected packet 
	task get_exp_packet();
		begin 
			forever begin 
				exp_mbx.get(exp_pkt);	
				//$display ("expected scb addr :: %0h, data :: %0h", exp_pkt.addr, exp_pkt.data);
				//$display ("expected scb queue size :: %0d", exp_queue.size());
				exp_queue.push_front(exp_pkt);
				//$display ("expected scb queue size :: %0d", exp_queue.size());
			end
		end		
	endtask

	//get actual packet 
	task get_act_pkt ();
		begin  
			forever begin 
				act_mbx.get(act_pkt);	
				//$display ("actual scb  addr :: %0h, data :: %0h", act_pkt.addr, act_pkt.data);
				//$display ("actual scb queue size :: %0d", exp_queue.size());
				//act_queue.push_front(act_pkt);
				//$display ("expected mon queue size :: %0d", exp_queue.size());
				compare (act_pkt);
			end		
		end
	endtask 

	task compare(packet act_pkt_c);
		begin 
			if(exp_queue.size())begin 
				exp_pkt_c = exp_queue.pop_back();
				if ((act_pkt_c.addr == exp_pkt_c.addr) && (act_pkt_c.data == exp_pkt_c.data))begin 	
					//$display("check1");
					$display ("PASS' EXP ADDR : %0h, ACT ADDR: %0h, EXP_DATA : %0h, ACT_DATA : %0h", exp_pkt_c.addr, act_pkt_c.addr, exp_pkt_c.data, act_pkt_c.data); 
				end
			end
			else begin
				$display ("FAIL' EXP ADDR : %0h, ACT ADDR: %0h, EXP_DATA : %0h, ACT_DATA : %0h", exp_pkt_c.addr, act_pkt_c.addr, exp_pkt_c.data, act_pkt_c.data);
			end

		end
				
	endtask

endclass 


