// Agent producer in project producerCustomer

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	!set_configuration("A",5,2).

+!set_configuration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE): true
	<-	.print("Producer ",PRODUCER_ID," -> Configurating artifact ...");
		+i_am_ready(true); //indicates producerA is ready
		!working(0).//starts with 0 available itens

+!working(V): i_am_ready(true)
	<-	.print("Producer ",PRODUCER_ID,"  -> Ready and working ...");
		!manufacture(V).
		
		
+!manufacture(ITENS_AVAILABLE): i_am_ready(true)
	<-	T = ITENS_AVAILABLE + 1;
		.print("QTDE = ", T);
		-+itens_available(T);	//update belief
		if (T > 2)
		{
			.print("OLA");
		}
		!working(T). //continue working
