class Spud::Admin::SnippetsController < Spud::Admin::ApplicationController
  belongs_to_spud_app :snippets
  layout '/spud/admin/detail'
  add_breadcrumb "Snippets", {:action => :index}
  add_breadcrumb "New",'', :only => [:new,:create]
  add_breadcrumb "Edit",'', :only => [:edit,:update]
  before_filter :load_snippet, :only => [:show, :edit, :update, :destroy]

  cache_sweeper :snippet_sweeper, :only => [:update,:destroy,:create]

  def index
    @snippets = SpudSnippet.site(session[:admin_site]).order(:name).paginate :page => params[:page]

    respond_with @snippets
  end

  def new

    @snippet = SpudSnippet.new
    respond_with @snippet
  end

  def create
    @snippet = SpudSnippet.new(params[:spud_snippet])
    @snippet.site_id = session[:admin_site]

    @snippet.save

    respond_with @snippet, :location => spud_core.admin_snippets_url
  end

  def edit

    respond_with @snippet
  end

  def update
    flash[:notice] = "Snippet saved successfully!" if @snippet.update_attributes(params[:spud_snippet])
    respond_with @snippet, :location => spud_core.admin_snippets_url
  end

  def destroy
    flash[:notice] = "Snippet removed!" if @snippet.destroy
    respond_with @snippet,:location => spud_core.admin_snippets_url
  end


private
  def load_snippet
    @snippet = SpudSnippet.where(:id => params[:id]).first
    if @snippet.blank?
      flash[:error] = "Snippet does not exist!"
      redirect_to spud_core.admin_snippets_url and return false
    elsif Spud::Core.multisite_mode_enabled && @snippet.site_id != session[:admin_site]
      flash[:warning] = "This snippet is for a different site"
      redirect_to spud_core.admin_snippets_url and return false
    end
  end
end
