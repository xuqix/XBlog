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
    SyntaxMatcher = [
      {
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

    def code_type(text)
      HTMLwithCodeRay::SyntaxMatcher.each do |o|
        o[:matcher].each do |m|
          return o[:format] if m =~ text
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
