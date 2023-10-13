class RequestsController < ApplicationController
  load_and_authorize_resource

  def index
    # @datatable = RequestsDatatable.new, buttons: false, pagination: false, entries: false
  end

  def show
  end

  private

    # Only allow a list of trusted parameters through.
    def policy_params
      params.fetch(:policy, {})
    end
end
