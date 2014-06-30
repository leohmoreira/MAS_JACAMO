// Agent customer in project producerCustomer

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	.my_name(ID);
		.random(MAXIMUM_PRICE);
		//!set_configuration(ID,1 + math.round(10*MAXIMUM_PRICE)).
		!set_configuration(ID,100).

+!set_configuration(CUSTOMER_ID,MAXIMUM_PRICE): true
	<-	.print("Created. Maximum Price: ",MAXIMUM_PRICE);
		+i_am_ready(true); //indicates it is ready
		+myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		!working.//starts with 0 available itens

+!working: i_am_ready(true) 
	<-	?myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		.broadcast(achieve,howMuch(CUSTOMER_ID,MAXIMUM_PRICE));//aviso a todos que quero saber o preco
		.print("sent");
		.wait(2000);
		!working.
		
		
+buy: i_am_ready(true) 
	<-	.print("COMPREI").
+!producerPrice(PRODUCER_ID,PRICE)
	<- 	.union([PRODUCER_ID,PRICE],X,X);
		.print("@@@@@@",X).
		

