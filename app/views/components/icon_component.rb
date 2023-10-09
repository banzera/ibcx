# frozen_string_literal: true

class IconComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ContentTag

  def initialize(names = "flag", original_options = {})
    @names   = names
    @options = original_options.deep_dup

    @classes  = ["fa"]
    @classes.concat Private.icon_names(names)
    @classes.concat Array(@options.delete(:class))
    # text = @options.delete(:text)
    # right_icon = @options.delete(:right)
    # icon = content_tag(:i, nil, @options.merge(:class => classes))
    # Private.icon_join(icon, text, right_icon)
  end

  def template
    content_tag(:i, nil, @options.merge(:class => @classes))
  end

  module Private
    extend ActionView::Helpers::OutputSafetyHelper

    def self.icon_join(icon, text, reverse_order = false)
      return icon if text.blank?
      elements = [icon, ERB::Util.html_escape(text)]
      elements.reverse! if reverse_order
      safe_join(elements, " ")
    end

    def self.icon_names(names = [])
      array_value(names).map { |n| "fa-#{n}" }
    end

    def self.array_value(value = [])
      value.is_a?(Array) ? value : value.to_s.split(/\s+/)
    end
  end

end
