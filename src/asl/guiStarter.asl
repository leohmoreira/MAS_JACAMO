// Agent guiStarter in project producerCustomer

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true 
	<- 	makeArtifact("MyGUI","UI",[],Id);
		focus(Id);
		.broadcast(achieve,drawYourself).
