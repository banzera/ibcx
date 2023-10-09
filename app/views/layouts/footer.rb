# frozen_string_literal: true

class Footer < ApplicationView
  include Phlex::Rails::Layout
  include Phlex::Rails::Helpers::ContentFor
  include Phlex::Rails::Helpers::LinkTo

  def initialize
    @context = Ibcx::ApplicationContext.build
  end

  def template(&block)
    footer class: "main-footer"
    strong do
      plain "Copyright © #{Date.current.year}"
      whitespace
      link_to @context.company.name, @context.company.url
      plain "."
    end
    whitespace
    plain "All rights reserved."

    div **classes("float-right", "d-none", "d-sm-inline-block") do
      div class: "text-small" do
        plain "Powered by"
        whitespace
        link_to '5&2 Northwest', 'https://www.5and2northwest.com'
        whitespace
        strong { "Olivander v#{Olivander::VERSION}" }
      end
    end
  end

end
