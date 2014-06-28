// Agent customer in project producerCustomer

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	.random(MAXIMUM_PRICE);
		!set_configuration("P",1 + math.round(10*MAXIMUM_PRICE)).

+!set_configuration(CUSTOMER_ID,MAXIMUM_PRICE): true
	<-	.print("Created. Maximum Price: ",MAXIMUM_PRICE);
		+i_am_ready(true); //indicates it is ready
		+myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		!working(0).//starts with 0 available itens

+!working(V): i_am_ready(true) 
	<-	?myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		.print("Ready and working ...");
		!buy.
		
		
+!buy: i_am_ready(true) 
	<-	//.print("wants to buy");
		//.all_names(N);//todos os agents no ambiente
		.broadcast(tell,sell);
		//.print(N);
		!buy.

