class AppDelegate
  attr :main_menu_layout, :image_from_internet

  def applicationDidFinishLaunching(notification)
    @main_menu_layout = MainMenu.new
    NSApp.mainMenu = @main_menu_layout.menu

    @main_controller = MainWindowController.alloc.init
    @main_controller.showWindow(self)
    @main_controller.window.orderFrontRegardless
    @main_controller.expand_menu


  end
end
