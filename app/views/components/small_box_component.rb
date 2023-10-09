# frozen_string_literal: true

class SmallBoxComponent < ApplicationComponent

  def initialize(style: :success, title: "Title", subtitle: "Subtitle", icon: nil, link_to: "#", link_label: "More Info")
    @style      = style
    @title      = title
    @subtitle   = subtitle
    @icon       = icon
    @link_to    = link_to
    @link_label = link_label
  end

  def style = "bg-#{@style}"

  def template
    div **classes("small-box", style) do
      div class: :inner do
        h3 {@title}
        p {@subtitle}
      end

      div(class: :icon) { render IconComponent.new @icon }


      a class: "small-box-footer", href: @link_to do
        plain @link_label
        whitespace
        render IconComponent.new "arrow-circle-right"
      end
    end
  end
end
