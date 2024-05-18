class apb_env; 
	apb_scb scb;
	apb_agent agent;

	function new (string name = "apb_env", virtual apb_intf INTF); 
		//$display ("%s is created", name); 
		scb = new ("scb",INTF);
		agent = new ("env",INTF);
		scb.exp_mbx = new();
		//$display ("exp_mbx created at scb");
		agent.drv.exp_mbx = new ();
		//$display ("exp_mbx created at scb");
		scb.exp_mbx = agent.drv.exp_mbx;
		scb.act_mbx = agent.mon.act_mbx;
	endfunction 

endclass
