require "erb"
require "fileutils"
require "foreman/export"

class Foreman::Export::UpstartScaling < Foreman::Export::Base

  def export
    error("Must specify a location") unless location
    FileUtils.mkdir_p location
    @location = Pathname.new(@location)

    app = self.app || File.basename(engine.directory)
    user = self.user || app
    template_root = self.template || File.expand_path("../../../data/export/upstart_scaling", __FILE__)

    Dir["#{location}/#{app}*.conf"].each do |file|
      say "cleaning up: #{file}"
      FileUtils.rm(file)
    end

    master_template = export_template("upstart_scaling", "master.conf.erb", template_root)
    master_config   = ERB.new(master_template).result(binding)
    write_file "#{location}/#{app}.conf", master_config

    engine.procfile.entries.each do |process|
      process_master_template = export_template("upstart_scaling", "process_master.conf.erb", template_root)
      process_master_config = ERB.new(process_master_template).result(binding)
      write_file "#{location}/#{app}-#{process.name}.conf", process_master_config

      process_instances_template = export_template("upstart_scaling", "process_instances.conf.erb", template_root)
      process_instances_config = ERB.new(process_instances_template).result(binding)
      write_file "#{location}/#{app}-#{process.name}-instances.conf", process_instances_config

      process_template = export_template("upstart_scaling", "process.conf.erb", template_root)
      process_config = ERB.new(process_template).result(binding)
      write_file "#{location}/#{app}-#{process.name}-instance.conf", process_config
    end
  end

end

