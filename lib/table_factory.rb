require 'ostruct'

module TableFactory
  class Section
    def tab number = 1
      tab    = '    '
      output = tab
      1.upto(number).map { output }.join(tab)
    end

    def attrs(options = { })
      return '' unless options
      options.keys.map do |k|
        " #{k}=\"#{options[k].is_a?(Array) ?
            options[k].to_a.join(' ') :
            options[k]}\""
      end.join(' ')
    end
  end

  class Header < Section
    def initialize(options = { })
      @columns = []
      @style   = options || { }
    end

    def column= col
      text, options = col
      column        = { }
      column[:text] = text
      column[:style] = options if options
      @columns << column
    end

    def to_s
      return '' if @columns.empty?
      [
          "<thead#{attrs(@style)}>",
          "<tr>",
          @columns.map do |column|
            [
                "<th#{attrs(column[:style])}>",
                "#{column[:text].to_s}",
                "</th>"
            ]
          end.join,
          "</tr>",
          "</thead>"
      ].join
    end
  end

  class Body < Section
    def initialize(data, options = { })
      @data  = data
      @style = options
    end

    def build(options = { })
      @html = [
          "<tbody#{attrs(@style)}>",
          @data.map do |data|
            row = OpenStruct.new
            yield row, data, @data.index(data)
            [
                "<tr>",
                row.instance_variable_get("@table").keys.map do |key|
                  text, style = row.send(key.to_sym)
                  "<td#{attrs(style)}>#{text}</td>"
                end.join,
                "</tr>"
            ]
          end.join,
          "</tbody>"
      ].join
    end

    def to_s
      @html
    end
  end

  class Footer < Header
    def to_s
      return '' if @columns.empty?
      [
          "<tfoot#{attrs(@style)}><tr>",
          @columns.map do |column|
            "<td#{attrs(column[:style])}>#{column[:text].to_s}</td>"
          end.join,
          "</tr></tfoot>"
      ].join
    end
  end

  class Table < Section
    def initialize(data, options = { })
      @data = data
    end

    def build(options = { })
      @header = Header.new(options[:header])
      @body   = Body.new(@data, options[:body])
      @foot   = Footer.new(options[:foot])
      @attrs  = attrs(options[:attributes])
      yield @header, @body, @foot
    end

    def to_s
      "<table#{@attrs}>#{@header.to_s}#{@body.to_s}#{@foot.to_s}</table>"
    end
  end
end
#example
a     = [1, 2, 3, 4, 5, 6, 7]
table = TableFactory::Table.new(a)
table.build({
                header:     {
                                class: :testing
                            },
                attributes: {
                    cellspasing: 0,
                    cellpadding: 0
                }
            }) do |header, body, footer|
  header.column = :name, { class: [:test1] }
  header.column = :number
  body.build do |row, num, index|
    row.name   = num, { class: [:test2] }
    row.number = num + 1
  end
  footer.column = 42, { colspan: 2 }
end

puts table
