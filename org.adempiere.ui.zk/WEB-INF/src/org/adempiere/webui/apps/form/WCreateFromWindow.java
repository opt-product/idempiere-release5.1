/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.apps.form;

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.grid.CreateFrom;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

public class WCreateFromWindow extends Window implements EventListener<Event>, WTableModelListener, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1525723342123192509L;

	private CreateFrom createFrom;
	private int windowNo;
	
	private Panel parameterPanel = new Panel();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private StatusBarPanel statusBar = new StatusBarPanel();
	private WListbox dataTable = ListboxFactory.newDataTable();

	private boolean isCancel;
	
	public static final String SELECT_DESELECT_ALL = "SelectAll";
	private ToolBarButton selectAllAction = new ToolBarButton(SELECT_DESELECT_ALL);
	private boolean checkAllSelected = true;

	public WCreateFromWindow(CreateFrom createFrom, int windowNo)
	{
		super();
		
		this.createFrom = createFrom;
		this.windowNo = windowNo;
		
		try
		{
			zkInit();
			confirmPanel.addActionListener(this);
			
			statusBar.setStatusDB("");
			tableChanged(null);
			createFrom.setInitOK(true);
		}
		catch(Exception e)
		{
			createFrom.setInitOK(false);
		}		
    }
	
	protected void zkInit() throws Exception
	{
		Borderlayout contentPane = new Borderlayout();
		appendChild(contentPane);
		
		North north = new North();
		contentPane.appendChild(north);
		north.appendChild(parameterPanel);
		
		Center center = new Center();
        contentPane.appendChild(center);
		center.appendChild(dataTable);

		selectAllAction.setMode("toggle");
		selectAllAction.setImage(ThemeManager.getThemeResource("images/SelectAll24.png"));
		selectAllAction.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), SELECT_DESELECT_ALL)));
		selectAllAction.addEventListener(Events.ON_CLICK, this);

		South south = new South();
		contentPane.appendChild(south);
		Panel southPanel = new Panel();
		south.appendChild(southPanel);
		southPanel.appendChild(new Separator());
		southPanel.appendChild(confirmPanel);
		southPanel.appendChild(selectAllAction);

		southPanel.appendChild(new Separator());
		southPanel.appendChild(statusBar);
		
		setWidth("750px");
		setHeight("550px");
		setSizable(true);
		setBorder("normal");
		contentPane.setWidth("100%");
		contentPane.setHeight("100%");
	}

	public void onEvent(Event e) throws Exception
	{
		//  OK - Save
		if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			isCancel = false;
			try
			{
				Trx.run(new TrxRunnable()
				{
					public void run(String trxName)
					{
						save(trxName);
					}
				});
				dispose();
			}
			catch (Exception ex)
			{
				FDialog.error(windowNo, this, "Error", ex.getLocalizedMessage());
			}
		}
		//  Cancel
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			isCancel = true;
			dispose();
		}
		// Select All
		// Trifon
		else if (e.getTarget().equals(selectAllAction)) {
			ListModelTable model = dataTable.getModel();
			int rows = model.getSize();
			Boolean selectAll = selectAllAction.isPressed() ? Boolean.FALSE : Boolean.TRUE;
			selectAllAction.setPressed(! selectAllAction.isPressed());
			checkAllSelected = false;
			for (int i = 0; i < rows; i++) {
				model.setValueAt(selectAll, i, 0);
			}
			checkAllSelected = true;
			//refresh
			dataTable.setModel(model);
			info();
		}
	}

	public void tableChanged (WTableModelEvent e)
	{
		int type = -1;
		if (e != null)
		{
			type = e.getType();
			if (type != WTableModelEvent.CONTENTS_CHANGED)
				return;

			if (checkAllSelected && e.getColumn() == 0) {
				ListModelTable model = dataTable.getModel();
				boolean rowUnSelected = false;
				for (int i = 0; i < model.getRowCount(); i++) {
					if ( ! (Boolean) model.getValueAt(i, 0) ) {
						rowUnSelected = true;
						break;
					}
				}
				selectAllAction.setPressed(! rowUnSelected);
			}
		}
		info();
	}
	
	public boolean save(String trxName)
	{
		ListModelTable model = dataTable.getModel();
		int rows = model.getSize();
		if (rows == 0)
			return false;
		
		return createFrom.save(dataTable, trxName);
	}

	public void info()
	{
		ListModelTable model = dataTable.getModel();
		int rows = model.getRowCount();
		int count = 0;
		for (int i = 0; i < rows; i++)
		{
			if (((Boolean) model.getValueAt(i, 0)).booleanValue())
				count++;
		}
		setStatusLine(count, null);
		
		createFrom.info(dataTable, statusBar);
	}
	
	public void setStatusLine(int selectedRowCount, String text) 
	{
		StringBuilder sb = new StringBuilder(String.valueOf(selectedRowCount));
		if (text != null && text.trim().length() > 0) {
			sb.append(" - ").append(text);
		}
		statusBar.setStatusLine(sb.toString());
		//
		confirmPanel.getOKButton().setEnabled(selectedRowCount > 0);
	}
	
	public WListbox getWListbox()
	{
		return dataTable;
	}
	
	public Panel getParameterPanel()
	{
		return parameterPanel;
	}
	
	public ConfirmPanel getConfirmPanel()
	{
		return confirmPanel;
	}
	
	public boolean isCancel() 
	{
		return isCancel;
	}
}
