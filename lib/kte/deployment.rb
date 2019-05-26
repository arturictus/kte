module KTE
  class Deployment < Miller.base(
      :name, 
      :image, 
      :template
    )
    def initialize(app = nil)
      @app = app
    end
  end
end