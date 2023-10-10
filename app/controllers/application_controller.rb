class ApplicationController < ActionController::Base
  layout 'olivander/adminlte/main'

  before_action :authenticate_user!

  before_action do
    @context = Ibcx::ApplicationContext.build
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    logger.info "Bad route caught by #{controller_path} controller..."
    error    = {code: 404, message: Rack::Utils::HTTP_STATUS_CODES[404]}

    respond_to do |format|
      format.html { render 'application/404', :status => :not_found }
      format.xml  { render :xml  => error.to_xml(root: :error), :status => :not_found }
      format.json { render :json => {error: error},             :status => :not_found }
      format.all  { head :not_found }
    end
  end

end
