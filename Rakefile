# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'MotionKit Kitchensink App OS X'
  app.frameworks << 'WebKit'
  app.frameworks += ['Quartz', 'PubSub']
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }

  app.info_plist['NSAppTransportSecurity'] = {
    'NSExceptionDomains' => {
      'flickr.com' => {
        'NSTemporaryExceptionAllowsInsecureHTTPLoads' => true,
        'NSIncludesSubdomains' => true
      },
      'staticflickr.com' => {
        'NSTemporaryExceptionAllowsInsecureHTTPLoads' => true,
        'NSIncludesSubdomains' => true
      }
    }
  }
end
