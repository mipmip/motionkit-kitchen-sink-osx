module KitchenSinkExamples
  class KitchenSinkBrowserController < KSSuperController

    def initialize
      @title = 'Browser'
      @layout = layout
      self.prepare_views
    end

    def layout
      @layout ||= KitchenSinkBrowserLayout.new
    end

    def prepare_views
      @location = @layout.get(:location)
      @web_view = @layout.get(:web_view)
      @go_button = @layout.get(:go_button)
      @go_button.target = self
      @go_button.action = 'openUrl'
    end

    def openUrl
      @web_view.setMainFrameURL @location.stringValue
    end


  end
end
