module Hairails
  module Helpers
    class Runner
      def self.invoke
        status = run(ARGV, $stderr, $stdout).to_i
        exit(status) if status != 0
      end

      def self.run(args = [], err=$stderr, out=$stdout)
        case args.shift
        when '--gapi'
          run_script 'rails_api', args
        else
          man; exit(0)
        end
      end

      def self.run_script name, args
        script = File.dirname(__FILE__) + "/runners/#{name}.sh"
        cmd = "bash #{script} #{args.join(' ')} "
        status = system cmd
        status ? 0 : 1
      end

      def self.man
        puts "To generate rails api app: "
        puts "$ hairails-help --gapi <app_name>"
      end
    end
  end
end
