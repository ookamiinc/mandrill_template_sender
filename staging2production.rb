#!/usr/bin/env ruby

require 'mandrill'
#
# This program assumes your staging, production API key
# is stored as an environment valiable called
# MANDRILL_STAGING_APIKEY, MANDRILL_PRODUCTION_APIKEY
#

# This is template slug you want to move from staging to production
target_template_slug = ARGV[0] || nil
puts "Target template slug: #{target_template_slug}"
target_missing = target_template_slug.nil? || target_template_slug.empty?
fail Error, 'You must provide a Target template slug' if target_missing

pm = Mandrill::API.new(ENV['MANDRILL_PRODUCTION_APIKEY'])

# Check existing templates in production
templates_list = pm.templates.list
slug_list = templates_list.map { |item| item['slug'] }
slug_exist = slug_list.include?(target_template_slug)
puts 'Slug exists' if slug_exist

sm = Mandrill::API.new(ENV['MANDRILL_STAGING_APIKEY'])

# template info
info = nil
begin
  info = sm.templates.info(target_template_slug)
rescue => ex
  puts "#{ex.message}: #{ex.message}"
  return
end

# Update or Add template
if slug_exist
  puts pm.templates.update(
    info['name'],
    info['from_email'],
    info['from_name'],
    info['subject'],
    info['code'],
    info['text'],
    true,
    info['labels'])
  puts "#{info['name']} template updated"
else
  puts pm.templates.add(
    info['name'],
    info['from_email'],
    info['from_name'],
    info['subject'],
    info['code'],
    info['text'],
    true,
    info['labels'])
  puts "#{info['name']} template added"
end
