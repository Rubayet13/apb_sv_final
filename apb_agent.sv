class apb_agent; 
	monitor mon; 
	driver drv; 
	function new(string name = "apb_agent", virtual apb_intf INTF);
		//$display ("%s is created", name);
		mon = new("mon",INTF);
		drv = new("drv",INTF); 
	endfunction 
endclass 
