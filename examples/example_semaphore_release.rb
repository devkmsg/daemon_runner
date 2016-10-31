#!/usr/bin/env ruby

require_relative '../lib/daemon_runner'
require 'dev/consul'

@service = 'myreleaseservice'
@lock_count = 3
@locked = false
@lock_time = 10

@semaphore = DaemonRunner::Semaphore.start(@service)
lock = DaemonRunner::Semaphore.lock(@lock_count)

@lock_time.downto(0).each do |i|
  @semaphore.logger.info "Releasing lock in #{i} seconds"
  sleep 1
end

lock.join
DaemonRunner::Semaphore.release