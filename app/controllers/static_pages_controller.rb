class StaticPagesController < ApplicationController
  def home

  end

  def help
    Pusher['test_channel'].trigger('my_event', {
        message: 'hello world'
    })
  end

  def about
  end

  def contact

  end

  def search
    
  end
end
