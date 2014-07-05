// Agent customer in project producerCustomer

/* Initial beliefs and rules */
i_am_ready(false). 
bestPrice(-1).
qtd_bought_itens(0).
qtd_prducers(0).

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<-	
		.my_name(ID);
		.random(MAXIMUM_PRICE);
		//!set_configuration(ID,1 + math.round(10*MAXIMUM_PRICE)).
		//.concat("gui",ID,MyGUI);
		!set_configuration(ID,100).

+!set_configuration(CUSTOMER_ID,MAXIMUM_PRICE): true
	<-	.print("Created. Maximum Price: ",MAXIMUM_PRICE);
		+i_am_ready(true); //indicates it is ready
		-i_am_ready(false); 
		+myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		!working.//starts with 0 available itens

+!working: i_am_ready(true) 
	<-	?myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
		.broadcast(achieve,howMuch(CUSTOMER_ID,MAXIMUM_PRICE));//aviso a todos que quero saber o preco
		//.print("sent");
		.wait(2000);
		!working.

+!producerPrice(PRODUCER_ID,PRICE):i_am_ready(Status)
	<- 	+i_am_ready(false);
		-i_am_ready(true);
		?bestPrice(BestPrice);
		if(Status == true)
		{
			if(BestPrice == -1)
			{
				+bestPrice(PRICE);
				-bestPrice(-1);
				+bestProducer(PRODUCER_ID);
			}
			else
			{
				if(BestPrice > PRICE)
				{
					-bestProducer(BestProducer);
					+bestProducer(PRODUCER_ID);
					+bestPrice(PRICE);
					-bestPrice(BestPrice);
				}
			}
			?bestProducer(BestProducer);
			?myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
			?qtd_prducers(Q);
			.random(RandomProducer);
			ChosenProducer = math.floor(Q * RandomProducer);
			!startBuying(ChosenProducer);
			//.send(BestProducer,achieve,sell(CUSTOMER_ID));
			-i_am_ready(false);
			+i_am_ready(true);
		}
		.
+!startBuying(INDEX):true
	<-	if(producers(INDEX,ID))
		{
			?myConfiguration(CUSTOMER_ID,MAXIMUM_PRICE);
			.send(ID,achieve,sell(CUSTOMER_ID));
		}
		.
+!sold: i_am_ready(Status)
	<-	if(Status == true)
		{
			?bestProducer(BestProducer);
			?qtd_bought_itens(Qtd);
			TmpQtde = Qtd + 1;
			+qtd_bought_itens(TmpQtde);
			-qtd_bought_itens(Qtd);
			.print("I have already bought from ",BestProducer, ". Now I have ",TmpQtde, " itens");
		}
		.
+!addProducers(PRODUCER_ID):qtd_prducers(Q)
	<-  +producers(Q,PRODUCER_ID);
		T = Q + 1;
		+qtd_prducers(T);
		-qtd_prducers(Q).

+!drawYourself: true
	<- 	.my_name(CUSTOMER_ID);
		lookupArtifact("MyGUI",_);
		drawItem(CUSTOMER_ID).
		