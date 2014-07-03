// Agent producer in project producerCustomer

/* Initial beliefs and rules */
i_am_ready(false).
sold_itens(0).
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
		+myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT);
		-i_am_ready(false);
		+i_am_ready(true); //indicates producerA is ready
		+itensAvailable(0);	//update belief
		!working(0).//starts with 0 available itens

+!working(V): i_am_ready(true) & myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT)
	<-	!manufacture(V).
		
+!working(V): i_am_ready(false)
	<-	.print("nothing to do").
		
+!manufacture(ITENS_AVAILABLE): i_am_ready(true) 
	<-	?myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT); //recover configuration
		if ((ITENS_AVAILABLE + 1) < LIMIT)
		{
			//.print("Producer: ",PRODUCER_ID," -> assembling new item ... ");
			.wait(TIME_TO_ASSEMBLE * 100);
			T = ITENS_AVAILABLE + 1;
			+itensAvailable(T);	//update belief
			-itensAvailable(ITENS_AVAILABLE);	//update belief
			//.print("Producer: ",PRODUCER_ID," -> new item assembled ",T);
			!working(T); //continue working
		}
		else
		{
			//.print("Producer: ",PRODUCER_ID," -> reached limit capacity. ");
			//-i_am_ready(true);
			//+i_am_ready(false);
		}
		.

+!howMuch(CUSTOMER,MONEY): true
	<- 	?i_am_ready(Status);
		if(Status == true)
		{
			?myConfiguration(PRODUCER_ID,PRICE,TIME_TO_ASSEMBLE,LIMIT); //recover configuration
			if(MONEY >= PRICE)
			{
				// avisa que pode vender
				.send(CUSTOMER,achieve,producerPrice(PRODUCER_ID,PRICE));//update price list
			}
			
		}
		else
		{
			.print("wait, i am not ready yet");
		}
		.

	
+!sell(CUSTOMER): true	
	<- 	?i_am_ready(Status);
		if(Status == true)
		{
			?itensAvailable(T);	//update belief
			if(T > 2)
			{
				TMP = T - 1;
				-itensAvailable(T);	//update belief
				+itensAvailable(TMP);	//update belief
				?sold_itens(SoldQtd);
				TmpSoldItens = SoldQtd + 1;
				+sold_itens(TmpSoldItens); 
				-sold_itens(SoldQtd);
				.print("I have already sold ",TmpSoldItens, " itens");
				.send(CUSTOMER,achieve,sold);//update price list
				!working(TMP);
				
			}
		}
		else
		{
			.print("wait, i am not ready yet");
		}
		.