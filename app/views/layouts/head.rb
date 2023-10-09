# frozen_string_literal: true

class Head < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::LinkTo

  def initialize
    @context = Ibcx::ApplicationContext.build
  end

  def template(&block)
    title { helpers.header_page_title }

    meta name: "viewport", content: "width=device-width,initial-scale=1"
    meta content: "text/html; charset=UTF-8", "http-equiv": "Content-Type"

    helpers.favicon_link

    csrf_meta_tags
    csp_meta_tag

    # stylesheet_link_tag "application", data_turbo_track: "reload"

    link rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback'

    javascript_include_tag "https://www.gstatic.com/charts/loader.js"
    stylesheet_link_tag "adminlte", "data-turbo-track": "reload"
    javascript_include_tag "adminlte", "data-turbo-track": "reload"
    javascript_importmap_tags
  end

end
