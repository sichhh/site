shared_context "with stubbed active record order" do |options|
  before(:all) do
    options[:model].class_eval do
      default_scope { order(options[:order]) }
    end
  end

  after(:all) do
    options[:model].default_scopes.pop
  end
end
