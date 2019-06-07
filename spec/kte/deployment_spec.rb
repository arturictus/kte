require 'spec_helper'

RSpec.describe KTE::Deployment do
  it do
    klass = Class.new(described_class) do
              name "app-name"
              template do
                KTE::Template.new(KTE.templates_folder.join('deployment'))
              end
              containers [:web, :sidekiq]
            end
    inst = klass.new('app')
    value = inst.template.value
    parsed = inst.template.result(inst)
    binding.pry
  end
end