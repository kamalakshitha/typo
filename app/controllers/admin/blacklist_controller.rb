class Admin::BlacklistController < Admin::BaseController
  def index
    @blacklist_patterns = BlacklistPattern.paginate :page => params[:page], :order => 'pattern ASC', :per_page => 10
  end

  def new
    @blacklist_pattern = BlacklistPattern.new

    if params[:blacklist_pattern].has_key?('type')
      @blacklist_pattern = case params[:blacklist_pattern][:type]
        when "StringPattern": StringPattern.new
        when "RegexPattern": RegexPattern.new
      end
    end rescue nil

    @blacklist_pattern.attributes = params[:blacklist_pattern]

    if request.post? and @blacklist_pattern.save
      flash[:notice] = _('BlacklistPattern was successfully created.')
      redirect_to :action => 'index'
    end
  end

  def edit
    @blacklist_pattern = BlacklistPattern.find(params[:id])
    @blacklist_pattern.attributes = params[:blacklist_pattern]
    if request.post? and @blacklist_pattern.save
      flash[:notice] = _('BlacklistPattern was successfully updated.')
      redirect_to :action => 'index'
    end
  end

  def destroy
    @blacklist_pattern = BlacklistPattern.find(params[:id])
    if request.post?
      @blacklist_pattern.destroy
      redirect_to :action => 'index'
    end
  end

end
