// CArtAgO artifact code for project producerCustomer

import java.awt.GridBagLayout;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.OPERATION;

public class UI extends cartago.tools.GUIArtifact {
	
	private MyFrame frame;

	public void setup() 
	{
		frame = new MyFrame();

	/*	linkActionEventToOp(frame.okButton,"ok");
		linkKeyStrokeToOp(frame.text,"ENTER","updateText");
		linkWindowClosingEventToOp(frame, "closed");
	*/	
		frame.setVisible(true);
	}

	@OPERATION void drawItem(String id, Object value)
	{
		frame.addItem(id,String.valueOf(value));
	}
	class MyFrame extends JFrame 
	{    
		private JPanel panel;
		Map<String,JTextField> text_agent = new HashMap<String,JTextField>();
		public MyFrame()
		{
			setTitle("Producer Customer ");
			setSize(400,200);
			this.panel = new JPanel();
			setContentPane(panel);
		}
		public void addItem(String id, String value)
		{	
			if(this.text_agent.containsKey(id))
			{
				JTextField updateText2 = this.text_agent.get(id);
				updateText2.setText(id+" vendeu/comprou "+value);
			}
			else
			{
				JTextField updateText = new JTextField(30);
				updateText.setText(value);
				updateText.setEditable(true);
				this.text_agent.put(id, updateText);
				this.panel.add(updateText);		
			}
		}		
	}
}

