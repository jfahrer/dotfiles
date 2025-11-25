require "irb/completion"
# require "irb/ext/save-history"
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb-save-history"
IRB.conf[:EVAL_HISTORY] = 5
IRB.conf[:USE_AUTOCOMPLETE] = false

%w[irbtools active_support/all awesome_print].each do |gem|
  require gem
rescue LoadError
  puts "Failed to load #{gem} gem."
end

class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

# http://ozmm.org/posts/railsrc.html
load File.dirname(__FILE__) + "/.rails-irbrc" if defined?(Rails) && Rails.env
