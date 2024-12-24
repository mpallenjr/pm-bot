require 'net/http'
require 'uri'
require 'json'

def get_data
  begin
    success = 0
    error = 0
    uri = URI.parse("https://www.reddit.com/r/Pmsforsale/new.json")
    while true
      request = Net::HTTP::Get.new(uri)

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      if JSON.parse(response.body)['data']['children'].first['data']['title'] != "PMSForsale Bot Test"
        puts JSON.parse(response.body)['data']['children'].first['data']['title'] #title
        puts JSON.parse(response.body)['data']['children'].first['data']['author'] #author
        puts JSON.parse(response.body)['data']['children'].first['data']['author_flair_text'] #trade count
        puts "#{Time.at(JSON.parse(response.body)['data']['children'].first['data']['created_utc']).strftime('%I:%M:%S %p  %D')}" #time created
        puts JSON.parse(response.body)['data']['children'].first['data']['selftext'] #trade count
        puts JSON.parse(response.body)['data']['children'].first['data']['url'] #trade count
        puts "----------------------------------- #{success} -----------------------------------"
        success += 1
      end
      sleep(60)
    end
  rescue => e
    puts "Error: #{e} ----------------------------------- #{error} -----------------------------------"
    error += 1
    get_data
  end
end

get_data