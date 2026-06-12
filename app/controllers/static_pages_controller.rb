class StaticPagesController < ApplicationController
  def home
    # render ....
    # =>app/views/static_pages
  end

  # app/views/コントローラ名/アクション名.html.erb
  def help
    # => app/views/static_pages/help.html.erb
    #
  end

  def about
    # => app/views/static_pages/about.html.erb
  end

  def contact
    # => app/views/static_pages/contact.html.erb
  end
end
