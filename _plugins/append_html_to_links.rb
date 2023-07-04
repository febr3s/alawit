module Jekyll
    module AppendHtmlToLinksFilter
      def append_html_to_links(content)
        content.gsub(/(<a[^>]+href=["'])([^"']+)(["'])/) do
          link = $2
          if !link.end_with?(".html") && !link.start_with?("#") && !link.start_with?("http") && !link.start_with?("//") && !link.include?(".Library") && !link.include?(".Download")
            "#{$1}#{link}.html#{$3}"
          else
            $&
          end
        end
      end
    end
  end
  
  Liquid::Template.register_filter(Jekyll::AppendHtmlToLinksFilter)
  