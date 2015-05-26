require "net/http"
require "json"

# Modify these values with the ones you intend to use
VN_SERVER_ADDRESS    = "CHANGEME"
API_ACCESS_TOKEN     = "CHANGEME"
PHONECALL_ID         = "CHANGEME"
PHONECALLVIEW_ID     = "CHANGEME"

# URI that identifies the phone call
uri = URI("https://"+VN_SERVER_ADDRESS+"/uapi/phoneCalls/@me/@self/"+PHONECALL_ID)

# The parameters sent in the body of the request
data = {
    "action" => "StartRecording",
    "format" => "wav",
    "phoneCallViewId" => PHONECALLVIEW_ID
}

# Initializes the request by setting the HTTP headers, query and body parameters and the URI path
req = Net::HTTP::Put.new(uri.path)
req.body = JSON.dump(data)
req['Authorization'] = 'Bearer ' + API_ACCESS_TOKEN
req['Content-type'] = 'application/json'
  
# Makes a HTTP PUT request using SSL
res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  http.request(req)
end

# Parses the JSON response
objectResult = JSON.parse(res.body)
puts JSON.pretty_generate(objectResult)

