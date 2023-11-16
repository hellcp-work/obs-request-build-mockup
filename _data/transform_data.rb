require 'json'
require 'active_support'
require 'active_support/core_ext/hash'

order = ['failed', 'unresolvable', 'broken', 'blocked', 'scheduled', 'dispatching', 'building', 'signing', 'finished', 'succeeded', 'disabled', 'excluded', 'locked', 'deleting', 'unknown']
mapping = { failed: 'failed', unresolvable: 'failed', broken: 'failed', blocked: 'building', scheduled: 'building', dispatching: 'building', building: 'building', signing: 'building', finished: 'building', locked: 'locked', deleting: 'building', unknown: 'unknown', succeeded: 'succeeded', disabled: 'disabled', excluded: 'disabled' }
packages = {}
Hash.from_xml(File.read('status.xml'))['resultlist']['result'].each do |r|
  r['status']&.each do |s|
    packages[s['package']] ||= {}
    packages[s['package']]['repositories'] ||= {}
    packages[s['package']]['repositories'][r['repository']] ||= {}
    packages[s['package']]['repositories'][r['repository']]['arches'] ||= {}
    packages[s['package']]['repositories'][r['repository']]['arches'][r['arch']] = s['code']
    packages[s['package']]['results'] ||= []
    packages[s['package']]['results'] << mapping[s['code'].to_sym]
  end
end

packages.each do |name, package|
  ['failed', 'building', 'locked', 'succeeded', 'disabled'].each do |status|
    package['totals'] ||= {}
    package['totals'][status] = package['results'].count(status)
  end
end

File.open('status.json', 'w') do |f|
  f.write(packages.to_json)
end
