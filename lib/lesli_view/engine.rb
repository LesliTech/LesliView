# lib/lesli_element/engine.rb
module LesliView
    class Engine < ::Rails::Engine
        isolate_namespace LesliView

        initializer "lesli_view" do |app|
            app.config.assets.precompile += %w[lesli_view/toolbar.css]
        end
    end
end
