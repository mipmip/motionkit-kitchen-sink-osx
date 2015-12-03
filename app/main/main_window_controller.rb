class MainWindowController < NSWindowController

  def layout
    @layout ||= MainWindowLayout.new
  end

  def init
    super.tap do
      self.window = layout.window
    end

    @displayItem = {
      "Children" => [
        {
          "Title" => "Data views",
          "Children" =>
          [
            {"Title" => "NSTableView", "Class"=>'KitchenSinkNSTableview'},
            {"Title" => "NSOutlineView"},
            {"Title" => "SourceList"}
          ]},
          {"Title" => "Buttons"},
          {"Title" => "Text Fields"}
      ]}


    @outline_view = @layout.get(:outline_view)
    @outline_view.outlineTableColumn = @layout.outline_view_column
    @outline_view.delegate = self
    @outline_view.dataSource = self
  #  @outline_view.reloadData

  end

  def outlineView _, numberOfChildrenOfItem: item
    item.nil? ? 1 : item["Children"].length
  end


  def outlineViewSelectionDidChange(notification)
    selected_item = @outline_view.itemAtRow(@outline_view.selectedRow)
    p selected_item

    @table_view = KitchenSinkNSTableviewController.new
    @table_view_layout = @table_view.layout

#    p @table_view.get_root
    @scroll_view = @table_view_layout.get :scroll_view
    @layout.set_right_sub_view  @scroll_view
    @layout.reapply!
  end


  def outlineView(outlineView, isItemExpandable:item)
    item.nil? ? false : (item["Children"].nil? ? false : item["Children"].length != 0)
  end

  def outlineView(outlineView, child:index, ofItem:item)
    item.nil? ? @displayItem : item["Children"][index]
  end

  def outlineView _, objectValueForTableColumn: column, byItem: item
    item["Title"].nil? ? "Root" : item["Title"]
  end

end
