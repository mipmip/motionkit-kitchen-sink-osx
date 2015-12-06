module KitchenSinkExamples
  class KitchenSinkNSButtonController < KSSuperController

    def initialize
      @title = 'NSButtons'
      @layout = layout
    end

    def layout
      @layout ||= KitchenSinkNSButtonLayout.new
    end

  end
end
