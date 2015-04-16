class NamespacesController < ApplicationController
  # GET /
  def index
    @namespaces = Namespace.all
  end

  # GET /1
  def show
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

  private

  def namespace_params
    params.require(:namespace).permit(:name)
  end

  def find_with_redirect
    @namespace = Namespace.find_by_slug!(params[:id])
    yield if block_given?
  rescue ActiveRecord::RecordNotFound
    redirect_to new_namespace_path name: params[:id]
  end
end
