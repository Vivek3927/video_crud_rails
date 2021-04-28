class ArticlesController < ApplicationController

  include CommonCrud

  private

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end