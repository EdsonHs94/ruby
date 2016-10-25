class ArticlesController < ApplicationController
	#GET  /articles
	before_action :authenticate_user!, except: [:show,:index]
	before_action :set_article, except: [:index,:new,:create]
	before_action :authenticate_editor!, only:[:new,:create,:update]
	before_action :authenticate_admin!, only:[:destroy]



	def index
		@articles = Article.all
	end
	#GET  /articles/:id
	def show

		@article.update_visits_count
		@comment = Comment.new
		
	end

	def edit
		
	end

	def new
		@article = Article.new
		@categories = Category.all
	end
	#post articles
	def create
		@article = current_user.articles.new(article_params)
		#title: params[:article][:title], body: params[:article][:body]
		@article.categories = params[:categories]
		if @article.save
			redirect_to @article
		else
			render :new			
		end
	end
	#
	def destroy
		
		@article.destroy
		redirect_to articles_path
	end
	#PUT /articles/:id
	def update
		
		if @article.update(article_params)
			redirect_to @article
			
		else
			render :edit
			
		end
	end

	private
	
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover,:categories)
	end
end
