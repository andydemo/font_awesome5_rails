require "font_awesome5_rails/parsers/fa_icon_parser"
require "font_awesome5_rails/parsers/fa_layered_icon_parser"
require "font_awesome5_rails/parsers/fa_stacked_icon_parser"

module FontAwesome5
  module Rails
    module IconHelper

      def fa_icon(icon, options = {})
        parser = FaIconParser.new(icon, options)
        if parser.text.nil?
          content_tag(:i, nil, class: parser.classes, style: parser.style, data: parser.data)
        else
          content_tag(:i, nil, class: parser.classes, style: parser.style, data: parser.data) +
          content_tag(:span, parser.text, class: "fa5-text #{parser.sizes}", style: parser.style)
        end
      end


      def fa_stacked_icon(icon, options = {})
        parser = FaStackedIconParser.new(icon, options)

        tags = content_tag :span, class: parser.span_classes do
          content_tag(:i, nil, class: (parser.reverse ? parser.second_icon_classes : parser.first_icon_classes) ) +
          content_tag(:i, nil, class: (parser.reverse ? parser.first_icon_classes : parser.second_icon_classes) )
        end
        tags += parser.text unless parser.text.nil?
        tags
      end

      def fa_layered_icon(options = {}, &block)
        parser = FaLayeredIconParser.new(options)
        if parser.size.nil?
          content_tag(:span, class: parser.classes, style: parser.style, &block)
        else
          content_tag :div, class: "fa-#{parser.size}" do
            content_tag(:span, class: parser.classes, style: parser.style, &block)
          end
        end
      end

    end
  end
end