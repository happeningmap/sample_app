class PagesController < ApplicationController
  def home
    
    if signed_in?
      redirect_to current_user
    else
      @title = "HOME"
    end
    
    
    
  end

  def contact
    @title = "CONTACT"
    
  end
  
  def about
    @title = "ABOUT"
    
  end
  
  def help
    @title = "HELP"
    
  end
  
end
