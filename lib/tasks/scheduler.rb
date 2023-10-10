namespace :scheduler do
  task :kickoff => :environment do
    def active?(schedule)
      !ActiveRecord::ConnectionAdapters::Column::FALSE_VALUES.include?(schedule)
    end

    Rails.logger.info "Setting up background schedule"

    require 'rufus-scheduler'
    scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")

    unless scheduler.down?
      # add active scheduled jobs here...
    end

    # kickoff the delayed jobs worker
    Rails.logger.info "Kicking off rake delayed jobs worker"

    begin
      Rake::Task["jobs:work"].invoke
    rescue SignalException => ex
      raise ex unless ex.signm == 'SIGTERM'
    end
  end
end
