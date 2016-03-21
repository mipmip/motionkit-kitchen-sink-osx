class KitchenSinkNSTableviewImageCellLayout < MK::WindowLayout
  def layout
    root(NSScrollView, :outer_view) do

      frame [[0, 0], [480, 360]]

      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      has_vertical_scroller true
      set_autoresizes_subviews true

      document_view add NSTableView, :table_view
    end
  end

  def table_view_style

    uses_alternating_row_background_colors true
    row_height 24
    parent_bounds = v.superview.bounds
    frame parent_bounds

    autoresizing_mask NSViewWidthSizable | NSViewHeightSizable

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

    add_column('avatar') do
      title 'Avatar'
      width 40
      editable false
      dataCell NSImageCell.alloc.init
      resizingMask NSTableColumnAutoresizingMask
    end

  end
end
