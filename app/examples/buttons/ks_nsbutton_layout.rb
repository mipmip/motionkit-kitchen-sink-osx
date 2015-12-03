class KitchenSinkNSButtonLayout < MK::WindowLayout
  def layout
    root(NSView, :outer_view) do

      frame [[0, 0], [480, 360]]

      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      set_autoresizes_subviews true

      add NSButton, :button01 do
        title "a test button"
        width 200
        height 30
        autoresizing_mask :pin_to_center
        frame from_center
        title 'click me'
      end
    end
  end
end
