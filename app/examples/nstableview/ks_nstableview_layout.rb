class KitchenSinkNSTableviewLayout < MK::WindowLayout
  def layout
    root(NSScrollView, :scroll_view) do
#      add NSView, :outer_view do

#          top.equals(:superview).plus(0)
#          left.equals(:superview).plus(0)
#          right.equals(:superview).plus(0)
#          bottom.equals(:superview).plus(0)

      #frame v.superview.bounds

      frame [[100, 100], [480, 360]]
      #height v.superview.bounds.size.height - 80

      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      has_vertical_scroller true

      document_view add NSTableView, :table_view
    end

  #      add NSButton, :but do
  #        title "hallo"
  #        constraints do
  #          height 22
  #          width 100
  #          top.equals(:superview).plus(10)
  #          left.equals(:superview).plus(10)
  #        end
  #      end

 #     end
  end

  def table_view_style
#    top.equals(:superview).plus(100)
#    left.equals(:superview).plus(0)
#    right.equals(:superview).plus(0)
#    bottom.equals(:superview).plus(0)

    uses_alternating_row_background_colors true
    row_height 24
    parent_bounds = v.superview.bounds
    frame parent_bounds
    height parent_bounds.size.height - 50

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
