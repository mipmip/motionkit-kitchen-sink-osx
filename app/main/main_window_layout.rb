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
        has_vertical_scroller true
        frame v.superview.bounds

        document_view add NSOutlineView, :outline_view
      end

      add NSScrollView, :scroll_view_right do
        frame v.superview.bounds
        autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
        has_vertical_scroller true

        document_view add NSTableView, :table_view
      end

    end
  end

  def outline_view_column
    @outline_view_column
  end

  def outline_view_style
    header_view nil
    focus_ring_type    NSFocusRingTypeNone
    parent_bounds = v.superview.bounds
    frame parent_bounds

    selection_highlight_style NSTableViewSelectionHighlightStyleSourceList

    add_column @outline_view_column do
      editable false
      width parent_bounds.size.width
    end

  end

  def table_view_style
    uses_alternating_row_background_colors true
    row_height 24
    parent_bounds = v.superview.bounds
    frame parent_bounds

    add_column('name') do
      title 'Name'
      min_width 102
      width 170
      resizing_mask NSTableColumnUserResizingMask
    end
    add_column('role') do
      title 'Role'
      min_width 102
      width parent_bounds.size.width - 170
      resizingMask NSTableColumnAutoresizingMask
    end
  end

end
