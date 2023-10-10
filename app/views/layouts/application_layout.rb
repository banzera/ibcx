# frozen_string_literal: true

class ApplicationLayout < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::TurboFrameTag

  def sidebar_collapsed? = helpers.cookies['lte.pushmenu.collapsed'] == 'true'

  def template
    doctype

    html do
      # render Head.new
      render partial: 'layouts/olivander/adminlte/head'

      body **classes("hold-transition", "sidebar-mini", "layout-fixed", sidebar_collapsed?: 'sidebar-collapse') do

        div **classes(:wrapper) do
          render partial: 'layouts/olivander/adminlte/navbar'
          render partial: 'layouts/olivander/adminlte/sidebar'
          # render partial: @content_partial || 'layouts/olivander/adminlte/content', locals: { content: yield }

          turbo_frame_tag 'modal'
          render partial: 'layouts/olivander/adminlte/flashes'

          # render partial: 'layouts/olivander/adminlte/footer'
          render Footer.new

          render partial: 'layouts/olivander/adminlte/control_sidebar'
        end

        content_for :javascript
      end
    end
  end
end
