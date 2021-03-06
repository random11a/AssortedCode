class RecipeController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    if params[:category_id].nil? 
      if params[:user_id].nil?
        @recipes = Recipe.find(:all)
      else
        @recipes = Recipe.find(:all, :conditions => ["user_id = ?", params[:user_id]]) 
        params[:user_id] = nil
      end
    else 
      @recipes = Recipe.find(:all, :conditions => ["category_id = ?", params[:category_id]]) 
      params[:category_id] = nil 
    end 

  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    if cookies.size == 1 #why 1? good question
      redirect_to(:controller => 'user', :action => 'list')
    end
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    @recipe.date = Time.now
    @recipe.user_id = cookies[:cur_user] #should be based on the current user
    if @recipe.save
      flash[:notice] = 'Recipe was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.date = Time.now
    if @recipe.update_attributes(params[:recipe])
      flash[:notice] = 'Recipe was successfully updated.'
      redirect_to :action => 'show', :id => @recipe
    else
      render :action => 'edit'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
