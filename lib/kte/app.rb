module KTE
  class Env < Miller.base(:template, :data)
    attr_reader :app, :opts
    def initialize(app, opts = {})
      @app = app
      @opts = opts
    end
  end
  class Container < Miller.base(:name,
                                :image,
                                :command,
                                :volumeMounts,
                                :env)
    attr_reader :object, :opts
    def initialize(object, opts = {})
      @object = object
      @opts = opts
    end                           
  end
  class Deployment < Miller.base(
      :name, 
      :template,
      :containers,
      :volumes
    )
    attr_reader :app, :opts
    def initialize(app, opts = {})
      @app = app
      @opts = opts
    end
  end
  class App 
    include Miller.with(:name, :version)
    include Miller::Collectable
    named_collectable :deployment, Deployment
    named_collectable :container, Container
    named_collectable :env, Env
    named_collectable :volume, Volume
  end
end