class MainWindowLayout < MK::WindowLayout
  MAIN_WINDOW_IDENTIFIER = 'MAIN_WINDOW'

  def layout
    frame [[100, 100], [480, 360]], 'WindowLayout'

    @outline_view_column = NSTableColumn.alloc.initWithIdentifier 'Column'

    add NSSplitView, :split_view do
      frame v.superview.bounds
      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      vertical true

      add NSScrollView, :scroll_view_left do
#        self.translatesAutoresizingMaskIntoConstraints = true
        has_vertical_scroller true
        frame v.superview.bounds
        translatesAutoresizingMaskIntoConstraints

        document_view add NSOutlineView, :outline_view
      end

      @right_view = add NSView, :right_view do
        frame v.superview.bounds
        width v.superview.bounds.size.width - 300

        set_autoresizes_subviews true

      end
    end
  end

  def clear_right_view
    right_view = context get(:right_view)
    right_view.setSubviews []
  end

  def set_right_sub_view sub_view
    context get(:right_view) do
      add sub_view
    end
  end

  def outline_view_column
    @outline_view_column
  end

  def outline_view_style
    header_view nil
    focus_ring_type NSFocusRingTypeNone
    parent_bounds = v.superview.bounds
    frame parent_bounds

    selection_highlight_style NSTableViewSelectionHighlightStyleSourceList

    add_column @outline_view_column do
      editable false
      width parent_bounds.size.width
    end
  end
end
