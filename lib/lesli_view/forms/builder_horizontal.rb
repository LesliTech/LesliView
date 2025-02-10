module LesliView
    module Forms
      class BuilderHorizontal < Builder
        def field(attribute, label: nil)
          super(attribute, label: label, horizontal: true)
        end
  
        def field_select(attribute, choices, options = {}, html_options = {}, label: nil, humanize: true)
          super(attribute, choices, options, html_options, label: label, humanize: humanize, horizontal: true)
        end
  
        def submit(value = nil, options = {})
          super(value, options, horizontal: true)
        end
      end
    end
  end
  