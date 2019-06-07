class RailsApp < KTE::App
  env(:prod) do
    template do
      KTE::Template.new(KTE.templates_folder.join('values', 'envs.prod'))
    end    
  end
  container(:web_prod) do
    name "web-prod"
    template do
      KTE::Template.new(KTE.templates_folder.join('container'))
    end
    env(:prod)
  end
  deployment(:web) do
    name "app-name"
    namespace :myapp
    template do
      KTE::Template.new(KTE.templates_folder.join('deployment'))
    end
    containers [:web_prod, :sidekiq_prod]
  end
end