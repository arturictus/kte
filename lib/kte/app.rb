module KTE
  class App < Miller::Collectable
    include Miller.with(:name, :version)
    named_collectable :deployment, Deployment
  end
end