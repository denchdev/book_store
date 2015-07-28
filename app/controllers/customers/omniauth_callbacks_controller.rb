class Customers::OmniauthCallbacksController < Device::OmniauthCallbacksController
  def facebook
    redirect_to books_path
  end
end
