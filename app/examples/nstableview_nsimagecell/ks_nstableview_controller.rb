module KitchenSinkExamples
  class KitchenSinkNSTableviewImageCellController < KSSuperController

    def initialize

      @title = 'NSTableView + NSImageCell'
      @layout = layout

      Dispatch::Queue.concurrent.sync do
        profile_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString('http://www.rubymotion.com/img/rubymotion-logo-shadow.png'))
        if profile_image_data
          @image_from_internet = NSImage.alloc.initWithData(profile_image_data)
          @contributors = [
            { name: 'Jamon Holmgren', role: 'Owner', avatar: @image_from_internet },
            { name: 'Colin T.A. Gray', role: 'Owner', avatar: @image_from_internet }
          ]
        end
      end


      p @contributors

      @table_view = @layout.get(:table_view)
      @table_view.delegate = self
      @table_view.dataSource = self
    end

    def layout
      @layout ||= KitchenSinkNSTableviewImageCellLayout.new
    end

    def numberOfRowsInTableView(table_view)
      p @contributors.length
      @contributors.length
    end

    def tableView(aTableView, objectValueForTableColumn: aTableColumn, row: rowIndex)
      row = @contributors[rowIndex]

      case aTableColumn.identifier
      when "avatar"
        p row[:avatar]
        row[:avatar]
      when "role"
        row[:role]
      when "name"
        row[:name]
      end
    end

    def tableViewColumnDidResize(notification)
    end

  end
end
