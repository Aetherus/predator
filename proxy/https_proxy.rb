#!/usr/bin/env ruby
require 'bundler'
Bundler.require :default

proxy = EvilProxy::MITMProxyServer.new Port: 8888

proxy.before_request do |request|
  puts request.body
end

proxy.before_response do |request, response|
  puts response.body
end

trap "INT"  do proxy.shutdown end
trap "TERM" do proxy.shutdown end

proxy.start
