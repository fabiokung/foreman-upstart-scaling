require "erb"
require "fileutils"
require "foreman/export"

class Foreman::Export::UpstartScaling < Foreman::Export::Base

  def export
    super

    Dir["#{location}/#{app}*.conf"].each do |file|
      clean file
    end

    write_template master_template, "#{app}.conf", binding

    engine.each_process do |name, process|
      next if engine.formation[name] < 1

      port = engine.port_for(process, num)

      write_template process_master_template, "#{app}-#{process.name}.conf", binding
      write_template process_instances_template, "#{app}-#{process.name}-instances.conf", binding
      write_template process_template, "#{app}-#{process.name}-instance.conf", binding
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

