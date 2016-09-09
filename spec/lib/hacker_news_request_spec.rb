require 'rails_helper'

RSpec.describe HackerNewsRequest do
  describe 'initializing' do
    subject { HackerNewsRequest.new }

    it 'assigns net_http to be an instance of Net::HTTP' do
      expect(subject.net_http).to be_a(Net::HTTP)
    end

    it 'assigns uri to be an instance of URI::HTTP' do
      expect(subject.uri).to be_a(URI::HTTP)
    end
  end

  describe 'results' do
    subject do
      VCR.use_cassette 'hn/request', record: :new_episodes do
        HackerNewsRequest.new.results(@page)
      end
    end

    it 'returns news results' do
      @page = 0
      results = subject
      expect(results['hits']).not_to be_empty
    end

    it 'returns empty if no more results was found' do
      @page = 2
      results = subject
      expect(results['hits']).to be_empty
    end
  end
end
