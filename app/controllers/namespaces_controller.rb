class NamespacesController < ApplicationController
  before_filter :authenticate!, except: [:index, :show]

  # GET /
  def index
    @namespaces = Namespace.all
  end

  # GET /:id
  def show
    find_with_redirect do
      authenticate! if @namespace.locked?
      @pages = @namespace.pages
    end
  end

  # GET /:id/edit
  def edit
    find_with_redirect
  end

  # GET /new
  def new
    @namespace = Namespace.find_by_slug!(params[:id])
    redirect_to @namespace, notice: 'Already exists'
  rescue ActiveRecord::RecordNotFound
    @namespace = Namespace.new name: params[:id]
  end

  # POST /
  def create
    @namespace = Namespace.new(namespace_params)
    if @namespace.save
      redirect_to @namespace, notice: 'Created'
    else
      render :new
    end
  end

  # PATCH/PUT /:id
  def update
    @namespace = Namespace.find_by_slug!(params[:id])
    if @namespace.update(namespace_params)
      redirect_to @namespace, notice: 'Updated'
    else
      render :edit
    end
  end

  private

  def namespace_params
    params.require(:namespace).permit(:name, :state)
  end

  def find_with_redirect
    @namespace = Namespace.find_by_slug!(params[:id])
    yield if block_given?
  rescue ActiveRecord::RecordNotFound
    redirect_to new_namespace_path name: params[:id]
  end
end
