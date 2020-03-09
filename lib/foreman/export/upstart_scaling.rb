require "erb"
require "fileutils"
require "foreman/export"

class Foreman::Export::UpstartScaling < Foreman::Export::Base
  def initialize(location, engine, options={})
    super location, engine, options.merge(template: File.expand_path("../../../../data/export/upstart_scaling", __FILE__))
  end

  def export
    super

    Dir["#{location}/#{app}*.conf"].each do |file|
      clean file
    end

    write_template master_template, "#{app}.conf", binding

    engine.each_process do |name, process|
      next if engine.formation[name] < 1

      port = engine.port_for(process, 1)

      write_template process_master_template, "#{app}-#{name}.conf", binding
      write_template process_instances_template, "#{app}-#{name}-instances.conf", binding
      write_template process_template, "#{app}-#{name}-instance.conf", binding
    end
  end

  def master_template
    "upstart_scaling/master.conf.erb"
  end

  def process_master_template
    "upstart_scaling/process_master.conf.erb"
  end

  def process_template
    "upstart_scaling/process.conf.erb"
  end

  def process_instances_template
    "upstart_scaling/process_instances.conf.erb"
  end
end

