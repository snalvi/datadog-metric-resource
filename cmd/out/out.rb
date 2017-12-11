# source -> {api_key: ''}
# params -> {metric_name: '', metric_value: ''}

#!/usr/bin/env ruby

require 'json'
require 'net/http'

request = JSON.parse(STDIN.read)

source = request.fetch('source')
params = request.fetch('params')

api_key = source['api_key']
metric_name = params['metric_name']
metric_value = params['metric_value']
current_time = Time.now

uri = URI.parse("https://app.datadoghq.com/api/v1/series?api_key=#{api_key}")
header = {'Content-Type': 'application/json'}
post_body = {'series': [{'metric_name': "#{metric_name}",
  'points': [["#{current_time}", "#{metric_value}"]],
  'type': 'gauge',
  'tags': ['environment:concourse']}
]}

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = post_body.to_json
response = http.request(request)

if response.code != 200
end


