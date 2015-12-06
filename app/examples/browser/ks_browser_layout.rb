class KitchenSinkBrowserLayout < MK::Layout
  def layout
    root(NSView, :outer_view) do
      frame [[0, 0], [480, 360]]

      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      set_autoresizes_subviews true

      @web_view = WebView.alloc.initWithFrame(NSMakeRect(0, 0, 480, 360))
      @web_view.setAutoresizingMask(NSViewMinXMargin|
                                    NSViewMaxXMargin|
                                    NSViewMinYMargin|
                                    NSViewMaxYMargin|
                                    NSViewWidthSizable|
                                    NSViewHeightSizable)

      add @web_view, :web_view do
        constraints do
          top.equals(:superview, :top).plus(50)
          right.equals(:superview, :right).minus(10)
          left.equals(:superview, :left).plus(10)
          bottom.equals(:superview, :bottom).minus(10)
        end
      end

      add NSTextField, :location
      add NSButton, :go_button
    end
  end

  def go_button_style
    title 'open URL'
    constraints do
      width 100
      height 30
      top.equals(:superview, :top).plus(10)
      right.equals(:superview, :right).minus(10)
    end
  end

  def location_style
    stringValue "https://github.com"
    constraints do
      top.equals(:superview, :top).plus(20)
      right.equals(:go_button, :left).minus(10)
      left.equals(:superview, :left).plus(10)
    end

  end
end
