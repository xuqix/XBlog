module ApplicationHelper
  def markdown(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
    markdown.render(h(text)).html_safe
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def syntax_matcher
      [ {
        :matcher => [
          /(char[\s]+\w+?;)|(short[\s]+\w+?;)|(int[\s]+\w+?;)|(long[\s]+\w+?;)|(float[\s]+\w+?;)|(double[\s]+\w+?;)/,
          /for[\s]+\([\s\S]*?\)/,
          /[\w]+?[\s]+[\w]+?[\s]*\([\s\S]*?\)[\s]+{/,
          /struct[\s\S]*?{/,
          /class[\s\S]*?{/,
        ],
        :format => :cplusplus
      },
      {
        :matcher => [
          /local[\s]+[\w]+?/,
          /for[\s][\w]+?[\s]+in[\s]+[i]?pairs/,
          /local[\s]+function/,
          /function[\s]+?[\w]+/,
        ],
        :format => :lua
      },
      {
        :matcher => [
          /def[\s]+[\w]+[\s\S]+?end/,
          /class[\s]+[\w]+[\s\S]+?end/,
          /module[\s]+[\w]+[\s\S]+?end/,
        ],
        :format => :ruby
      },
      {
        :matcher => [
          /for[\s][\w]+?[\s]+in[\s]+[\w]+?[\s]*:/,
          /def[\s]+[\w]+[\s]*:/,
          /class[\s]+[\w]+[\s]*:/,
        ],
        :format => :python
      },
    ]
    end

    def code_type(text)
      syntax_matcher.each do |o|
        o[:matcher].each do |m|
          if m =~ text
            p m
            return o[:format]
          end
        end
      end
      return :text
    end

    def block_code(code, language)
      language ||= code_type(code)
      CodeRay.scan(code, language).div(:tab_width=>2, :line_numbers => nil)
    end
  end
end
