// Agent producer in project producerCustomer

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	.my_name(ID);
		.random(PRICE);
		.random(TIME_TO_ASSEMBLE);
		.random(LIMIT);
		!set_configuration(ID,1 + math.round(10*PRICE),1 + math.round(10*TIME_TO_ASSEMBLE),10+math.round(10*LIMIT)).

+!set_configuration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT): true
	<-	.print("Producer: ",PRODUCER_ID," -> Created. Price: ",PRICE," Time to assemble: ",TIME_TO_ASSEMBLE);
		+i_am_ready(true); //indicates producerA is ready
		+myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT);
		!working(0).//starts with 0 available itens

+!working(V): i_am_ready(true) & myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT)
	<-	.print("Producer ",PRODUCER_ID,"  -> Ready and working ...");
		!manufacture(V).
		
		
+!manufacture(ITENS_AVAILABLE): i_am_ready(true) 
	<-	?myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT); //recover configuration
		if ((T - 1) > LIMIT)
		{
			.print("Producer: ",PRODUCER_ID," -> assembling new item ... ");
			.wait(TIME_TO_ASSEMBLE * 1000);
			T = ITENS_AVAILABLE + 1;
			-+itens_available(T);	//update belief
			.print("Producer: ",PRODUCER_ID," -> new item assembled ");
		}
		else
		{
			.print("Producer: ",PRODUCER_ID," -> reached limit capacity. ");
		}
		!working(T). //continue working

+sell: true
	<- .print("SELLING").