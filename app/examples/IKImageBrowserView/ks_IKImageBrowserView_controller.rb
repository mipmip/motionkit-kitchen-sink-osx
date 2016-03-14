class Photo
  attr_reader :url, :link

  def initialize(url, link)
    @urlString = url
    @url = NSURL.alloc.initWithString(url)
    @link = NSURL.alloc.initWithString(link)
  end

  # IKImageBrowserItem protocol.

  def imageUID
    @urlString
  end

  def imageRepresentationType
    :IKImageBrowserNSImageRepresentationType
  end

  PhotoDownloadFinishedNotification = 'PhotoDownloadFinishedNotification'

  def imageRepresentation
    @image ||= begin
      Dispatch::Queue.concurrent.async do
        @image = NSImage.alloc.initWithContentsOfURL(@url)
        Dispatch::Queue.main.async { NSNotificationCenter.defaultCenter.postNotificationName(PhotoDownloadFinishedNotification, object:self) }
      end
    end
  end
end

module KitchenSinkExamples
  class KitchenSinkIKImageBrowserViewController < KSSuperController

    PhotoDownloadFinishedNotification = 'PhotoDownloadFinishedNotification'

    def initialize

      @title = 'IKImageBrowserView'
      @layout = layout

      @browserView = @layout.get(:imagebrowserview)
      @browserView.delegate = self
      @browserView.dataSource = self

      @go_button = @layout.get(:go_button)
      @go_button.target = self
      @go_button.action = 'openUrl'


      NSNotificationCenter.defaultCenter.addObserver self,
        selector:'feedRefreshed:',
        name:PSFeedRefreshingNotification,
        object:nil

      NSNotificationCenter.defaultCenter.addObserver self,
        selector:'photoDownloaded:',
        name:Photo::PhotoDownloadFinishedNotification,
        object:nil

    end

    def openUrl
      searchImages('cat')
    end

    def layout
      @layout ||= KitchenSinkIKImageBrowserViewLayout.new
    end

    def searchImages(tag)
      url = "http://api.flickr.com/services/feeds/photos_public.gne?tags=#{tag}&lang=en-us&format=rss_200".stringByAddingPercentEscapesUsingEncoding NSUTF8StringEncoding
      @feed = PSFeed.alloc.initWithURL(NSURL.URLWithString(url))
      p url
      @feed.refresh(nil)
    end

    def feedRefreshed(notification)
      feed = notification.object
      @results = feed.entryEnumeratorSortedBy(nil).allObjects
      @cache = []
      @browserView.reloadData
    end

    def photoDownloaded(notification)
      photo = notification.object
      @browserView.reloadData if @cache.include?(photo)
    end

    # IKImageBrowserViewDatasource/Delegate protocol.

    def numberOfItemsInImageBrowser(browser)
      @results ? @results.size : 0
    end

    def imageBrowser(browser, itemAtIndex:index)
      photo = @cache[index]
      if photo.nil?
        entry = @results[index]
        html = entry.content.HTMLString
        link = html.scan(/<a\s+href="([^"]+)" title/)[0][0]
        url = html.scan(/<img\s+src="([^"]+)"/)[0][0]
        photo = Photo.new(url, link)
        @cache[index] = photo
      end
      p photo
      photo
    end

    def imageBrowser(browser, cellWasDoubleClickedAtIndex:index)
      NSWorkspace.sharedWorkspace.openURL @cache[index].link
    end

  end
end
