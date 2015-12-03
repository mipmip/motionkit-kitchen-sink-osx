class MainWindowController < NSWindowController
  def layout
    @layout ||= MainWindowLayout.new
  end

  def expand_menu
    @outline_view.expandItem(nil, expandChildren:true)
  end

  def init
    super.tap do
      self.window = layout.window
    end

    build_navigation

    @outline_view = @layout.get(:outline_view)
    @outline_view.outlineTableColumn = @layout.outline_view_column
    @outline_view.delegate = self
    @outline_view.dataSource = self
    #@outline_view.reloadData
  end

  def build_navigation
    children = []
    @instances = {}
    KitchenSinkExamples.constants.each do |c|
      if c.to_s.start_with? 'KitchenSink' and c.to_s.include? 'Controller'
        @instances[KitchenSinkExamples::const_get(c.to_s)] = KitchenSinkExamples::const_get(c.to_s).new
        children << @instances[KitchenSinkExamples::const_get(c.to_s)].object_entry
      end
    end

    @displayItem = {
      "Title" => 'Cocoa Elements',
      "Children" => children
    }

  end

  def outlineView _, numberOfChildrenOfItem: item
    item.nil? ? 1 : item["Children"].length
  end

  def outlineViewSelectionDidChange(notification)
    selected_item = @outline_view.itemAtRow(@outline_view.selectedRow)

    @layout.clear_right_view
    if selected_item['subview']

      right_view = @layout.get(:right_view)
      selected_item['subview'].setFrame right_view.bounds

      @layout.set_right_sub_view selected_item['subview']
      @layout.reapply!
    end
  end

  def outlineView(outlineView, isItemExpandable:item)
    item.nil? ? false : (item["Children"].nil? ? false : item["Children"].length != 0)
  end

  def outlineView(outlineView, child:index, ofItem:item)
    item.nil? ? @displayItem : item["Children"][index]
  end

  def outlineView _, objectValueForTableColumn: column, byItem: item
    if item["Title"].nil?
      @root_item = item
      "Root"
    else
      item["Title"]
    end
  end

end
