class HackerNewsRequest
  attr_reader :net_http
  attr_accessor :uri

  ENDPOINT = 'http://hn.algolia.com/api/v1/search_by_date'.freeze

  def initialize(**args)
    args.reverse_merge!(
      hitsPerPage: 10, # limited to 10 so pagination can be used, only has 13 results, default was 20
      restrictSearchableAttributes: 'url',
      query: 'github',
      numericFilters: 'points>1000'
    )
    @uri = URI ENDPOINT
    @uri.query = args.to_param
    @net_http = Net::HTTP.new(uri.host, uri.port)
  end

  def results(page = 0)
    JSON.parse(
      net_http.request(
        request(page)
      ).body
    )
  end

  private

  def request(page = 0)
    uri.query = "#{uri.query}&page=#{page}"
    Net::HTTP::Get.new(uri.request_uri)
  end
end
