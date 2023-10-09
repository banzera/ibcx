module SimpleForm

  class AjaxFormBuilder < FormBuilder
    def default_button_contents
      @default_button_contents ||= '<i class="fa fa-lg fa-icon fa-remove text-danger" title="Delete"></i>'.html_safe
    end

    def default_alternate_button_contents
      @default_alternate_button_contents ||= '<i class="fa fa-lg fa-icon fa-circle text-success" title="Alternate"></i>'.html_safe
    end

    def delete_button(*args, &block)
      options = args.extract_options!
      options.reverse_merge! :class => 'btn btn-link'

      data_remote_options = {
        data: {
            remote: true,
            method: :delete,
            url:    (options.delete(:remote) || template.url_for(object)),
        }
      }
      if block_given?
        button :button, options.deep_merge(data_remote_options), &block
      else
        button :button, default_button_contents, options.deep_merge(data_remote_options)
      end
    end

    def alternate_button(*args, &block)
      options = args.extract_options!
      options.reverse_merge! :class => 'btn btn-link'

      data_remote_options = {
        data: {
            remote: true,
            method: :post,
            url:    (options.delete(:remote) || template.url_for(object)),
        }
      }
      if block_given?
        button :button, options.deep_merge(data_remote_options), &block
      else
        button :button, default_alternate_button_contents, options.deep_merge(data_remote_options)
      end
    end

    def input(attribute_name, options = {}, &block)
      data_remote_options = {
        input_html: {
          data: {
            remote: true,
            method: :patch,
            url:    (options.delete(:remote) || template.url_for(object)),
          }
        }
      }

      super(attribute_name, options.deep_merge(data_remote_options), &block)
    end
  end

  module Components
    module Icons
      def icon(_wrapper_options = nil)
        return icon_class unless options[:icon].nil?
      end

      def icon_class
        template.content_tag(:i, '', class: options[:icon])
      end

      def prepend(_wrapper_options = nil)
        return nil if options[:prepend].nil?

        template.content_tag(:div, class: 'input-group-prepend') do
          template.content_tag(:span, class: 'input-group-text') do
            template.content_tag(:i, '', class: options[:prepend])
          end
        end
      end

      def append(_wrapper_options = nil)
        return nil if options[:append].nil?

        template.content_tag(:div, class: 'input-group-append') do
          template.content_tag(:span, class: 'input-group-text') do
            template.content_tag(:i, '', class: options[:append])
          end
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icons)
