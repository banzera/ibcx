# frozen_string_literal: true

class CardComponent < ApplicationComponent

  TOOL_ICON_MAP = {
    refresh:   'sync-alt',
    maximize:  :expand,
    collapse:  :minus,
    'collapse-alt': :plus,
    remove:    :times,
  }

  attr_reader :title, :card_id, :tools

  def initialize(title: "Card Title", style: [:primary, :outline], collapsed: false, tools: [])
    @title   = title
    @card_id = unique_id

    @classes = ['card'] + Array(style).map {|a| a.to_s.prepend 'card-' }

    @tools = case tools
    when :all  then TOOL_ICON_MAP.keys
    when :none then Array.new
    else Array(tools)
    end

    if collapsed
      @classes << 'collapsed-card'
      @tools.delete(:collapse)
      @tools << :'collapse-alt'
    end
  end

  def template(&)
    div **classes(@classes) do

      if title.present? || tools.present?
        div class: "card-header" do
          h3(class: "card-title") { @title}
          div(class: "card-tools") do
            helpers.content_for(@tool_id) if helpers.content_for?(@card_id)
            @tools.each do |t|
              card_tool(t)
            end
          end
        end
      end

      div class: "card-body" do
        yield
      end
    end
  end

  def unique_id
    # Set the first unique value
    @@_unique_id ||= Time.zone.now.usec
    # Everytime we access this function make a new one
    @@_unique_id += 1
  end

  def card_tool(widget, data: {})
    icon = TOOL_ICON_MAP[widget] || :tools

    widget = widget.to_s.gsub!('-alt','')

    data.reverse_merge!('card-widget' => widget )

    button(type: :button, data: data, **classes('btn', 'btn-tool')) do
      render IconComponent.new(icon)
    end

  end

  def card_tool_refresh
    data = {
      "load-on-init"    => "false",
      "source"          => "widgets.html",
      "source-selector" => "#card-refresh-content",
    }

    card_tool(:refresh, data: data)
  end

  def card_with_tabs(active: nil, unique: false, list: {}, content: {}, style: [], &block)
    raise 'expected a block' unless block_given?

    classes = ['card', 'card-tabs'] + Array(style).map {|a| a.to_s.prepend 'card-' }
    content_tag(:div, class: classes.join(' ')) do
      content_tag(:div, class: 'card-header p-0 border-bottom-0') do
        @_tab_mode = :tablist
        @_tab_active = (active || :first)
        @_tab_unique = effective_bootstrap_unique_id if unique

        content_tag(:ul, {class: 'nav nav-tabs', role: 'tablist'}.merge(list)) do
          yield # Yield to tab the first time
        end
      end +
      content_tag(:div, class: 'card-body') do
        content_tag(:div, {class: 'tab-content'}.merge(content)) do
          @_tab_mode = :content
          @_tab_active = (active || :first)
          yield # Yield to tab the second time
        end
      end
    end
  end
end
