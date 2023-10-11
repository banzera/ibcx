module Ibcx
  class RouteBuilder
    include Olivander::Resources::RouteBuilder
  end

  class ApplicationContext
    include Rails.application.routes.url_helpers

    class << self
      def build
        builder = ApplicationContext.new

        Olivander::ApplicationContext.default.tap do |context|
          context.name            = 'IBCx'
          context.logo.url        = '/logo/vector/image.svg'
          context.logo.alt        = 'Logo'
          context.company.name    = 'IBCx'
          context.menu_items      = builder.build_menu_items
          context.route_builder = Ibcx::RouteBuilder
          context.sign_out_path = builder.destroy_user_session_path
        end
      end

    end

    def build_menu_items
      [
        build_menu_item(key: "dashboard", url: root_path, is_module: true),
        build_menu_item(key: 'policies', url: policies_path, is_module: false),
        build_menu_item(key: 'accounts', url: accounts_path, is_module: true),
      ]
    end

    def build_menu_item(key: nil, controller: nil, action: nil, url: nil, is_module: false, condition: nil, items: nil)
      url ||= url_for(controller: controller, action: action, only_path: true)
      key ||= url.parameterize(separator: '_')

      unless items
        submenu_key = "#{key.parameterize(separator: '_')}_submenu"
        items = Proc.new{ send(submenu_key) } if respond_to?(submenu_key)
      end

      Olivander::Menus::MenuItem.new(key, url, nil, is_module: is_module).tap do |mi|
        mi.with_submenu_items { items.call } if items.present?
      end
    end

    def policies_submenu
        Policy.all.collect do |p|
          build_menu_item(key: p.number, url: policy_path(p))
        end
    end

  end
end
