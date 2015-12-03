class KitchenSinkNSTableviewController

  def layout
    @layout ||= KitchenSinkNSTableviewLayout.new
  end

  def init
#    super.tap do
#      self.window = layout.window
#    end
    @contributors = [
      { name: 'Jamon Holmgren', role: 'Owner' },
      { name: 'Colin T.A. Gray', role: 'Owner' },
    ]
    p @contributors

    @table_view = @layout.get(:table_view)
    @table_view.delegate = self
    @table_view.dataSource = self
  end

  def get_root
    @layout.get(:outer_view)
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

end
