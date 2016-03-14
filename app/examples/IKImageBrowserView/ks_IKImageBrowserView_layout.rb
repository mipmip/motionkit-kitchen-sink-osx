class KitchenSinkIKImageBrowserViewLayout < MK::Layout

  def layout
    root(NSView, :outer_view) do

      @browserView = IKImageBrowserView.alloc.initWithFrame(NSMakeRect(0, 0, 480, 360))
      @browserView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable

      frame [[0, 0], [480, 360]]

      add NSScrollView, :scroll_view
      add NSButton, :go_button

    end
  end

  def scroll_view_style
        frame v.superview.bounds

        constraints do
          top.equals(:superview, :top).plus(40)
          right.equals(:superview, :right).minus(0)
          left.equals(:superview, :left).plus(0)
          bottom.equals(:superview, :bottom).minus(40)
        end

        autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
        has_vertical_scroller true
        set_autoresizes_subviews true

        document_view add @browserView, :imagebrowserview
  end

  def imagebrowserview_style
#    constraints do
#      top.equals(:superview, :top).plus(50)
#      right.equals(:superview, :right).minus(10)
#      left.equals(:superview, :left).plus(10)
#      bottom.equals(:superview, :bottom).minus(10)
#    end
  end

  def go_button_style
    title 'get images'
    constraints do
      width 100
      height 30
      top.equals(:superview, :top).plus(10)
      right.equals(:superview, :right).minus(10)
    end
  end
end
