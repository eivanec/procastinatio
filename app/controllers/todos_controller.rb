class TodosController < ApplicationController
  before_filter :login_required
  before_filter :get_list


def create
    # Create a todo object that has
    # been instantiated with attributes
    # and linked to the list object
    @todo = @list.todos.create(params[:todo])
    if @todo.save
      flash[:notice] = 'Todo was successfully created.'
      respond_to do |format|
        format.html { redirect_to list_url(@list) }
        format.xml  { render :xml => @todo,
          :status => :created, :location => @list }
      end
    else
      flash[:notice] = 'Todo was not created.'
      respond_to do |format|
        format.html { redirect_to list_url(@list) }
        format.xml  { render :xml => @todo.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo = @list.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to list_url(@list) }
      format.xml  { render :xml => @todo,
          :status => :destroyed, :location => @list }
    end
  end


private

  def get_list
     @list = List.find(params[:list_id])
  end

end
