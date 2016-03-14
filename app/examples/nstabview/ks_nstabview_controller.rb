module KitchenSinkExamples
  class KitchenSinkNSTabViewController < KSSuperController

    def initialize
      @title = 'NSTabView'
      @layout = layout
    end

    def layout
      #@layout ||= KitchenSinkNSTabViewLayout.new
      @layout ||= KitchenSinkNSButtonLayout.new
    end

  end
end
