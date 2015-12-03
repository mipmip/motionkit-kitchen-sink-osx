class KSSuperController

  def object_entry
    @subview = @layout.get :outer_view
    p @subview
    {"Title" => @title, "subview"=> @subview}
  end
end
