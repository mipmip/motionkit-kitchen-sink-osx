class MainWindowController < NSWindowController

  def layout
    @layout ||= MainWindowLayout.new
  end

  def init
    super.tap do
      self.window = layout.window
    end
    @contributors = [
      { name: 'Jamon Holmgren', role: 'Owner' },
      { name: 'Colin T.A. Gray', role: 'Owner' },
    ]

    @table_view = @layout.get(:table_view)
    @table_view.delegate = self
    @table_view.dataSource = self

    @outline_view = @layout.get(:outline_view)
    @outline_view.outlineTableColumn = @layout.outline_view_column
    @outline_view.delegate = self
    @outline_view.dataSource = self
  #  @outline_view.reloadData
  end

  def numberOfRowsInTableView(table_view)
    @contributors.length
  end

  def tableView(table_view, viewForTableColumn: column, row: row)
    text_field = table_view.makeViewWithIdentifier(column.identifier, owner: self)

    unless text_field
      text_field = NSTextField.alloc.initWithFrame([[0, 0], [column.width, 0]])
      text_field.identifier = column.identifier
      text_field.editable = false
      text_field.drawsBackground = false
      text_field.bezeled = false
    end

    row = @contributors[row]

    case column.identifier
    when 'name'
      text_field.stringValue = row[:name]
    when 'role'
      text_field.stringValue = row[:role]
    end

    return text_field
  end

  def tableViewColumnDidResize(notification)
    # notification.object
    # notification.userInfo['NSTableColumn']
    # notification.userInfo['NSTableColumn'].width
    # notification.userInfo['NSOldWidth']
  end

  def outlineView _, numberOfChildrenOfItem: item
    #p 'numberOfRowsInTableView'
    item == nil ? 15 : 0
  end

  def outlineView(outlineView, isItemExpandable:item)
    p "isItemExpandable"
    p item
    false
  end

  def outlineView(outlineView, child:index, ofItem:item)
   # p "child of Item"
    p "child_index: #{index} of item:#{item}"
    nil
  end

  def outlineView _, objectValueForTableColumn: column, byItem: item
    p "item value for column:"
    p  column
    p " by item:"
    p item
#    p 'objectValueForTableColumn'
    'test'
  end





end
