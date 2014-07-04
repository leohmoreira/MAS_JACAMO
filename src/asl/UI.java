// CArtAgO artifact code for project producerCustomer

import java.awt.event.ActionEvent;
import java.awt.event.WindowEvent;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.INTERNAL_OPERATION;
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

	@OPERATION void drawItem(String value)
	{
		frame.addItem(value);
	}
	class MyFrame extends JFrame 
	{    
		private JButton okButton;
		private JTextField text;
		private JPanel panel;
		public MyFrame()
		{
			setTitle("Producer Customer ");
			setSize(400,200);
			this.panel = new JPanel();
			setContentPane(panel);
			//this.addItem();
		}
		public void addItem(String value)
		{			
			text = new JTextField(10);
			text.setText(value);
			text.setEditable(true);
			this.panel.add(text);
		}
	}
}

