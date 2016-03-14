class KitchenSinkNSTabViewLayout < MK::Layout
  def layout
    root(NSView, :outer_view) do

      frame [[0, 0], [480, 360]]

      autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
      set_autoresizes_subviews true

      add NSTabView, :tabview do
        add_tab "tab_identifier", "tab_label" do
          wantsLayer true
          backgroundColor NSColor.redColor
        end
      end
    end
  end
end
