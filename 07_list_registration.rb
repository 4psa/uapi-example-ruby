require "net/http"
require "json"

# Modify these values with the ones you intend to use
VN_SERVER_ADDRESS   = "CHANGEME"
API_ACCESS_TOKEN    = "CHANGEME"
EXTENSION_NUMBER    = "CHANGEME"

# URI that identifies the presence of an extension
uri = URI("https://"+VN_SERVER_ADDRESS+"/uapi/extensions/@me/"+EXTENSION_NUMBER+"/presence")

# Initializes the request by setting the HTTP headers, query and body parameters and the URI path
req = Net::HTTP::Get.new(uri.path)
req['Authorization'] = 'Bearer ' + API_ACCESS_TOKEN
req['Content-type'] = 'application/json'

# Makes a HTTP GET request using SSL
res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  http.request(req)
end

# Parses the JSON response
objectResult = JSON.parse(res.body)
puts JSON.pretty_generate(objectResult)

