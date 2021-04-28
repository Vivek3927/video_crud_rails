module Concerns::TestConcern
  extend ActiveSupport::Concerns

  included do 
    def index
      @books = Book.all
    end
  end

end
