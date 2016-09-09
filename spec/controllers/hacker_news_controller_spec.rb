require 'rails_helper'

RSpec.describe HackerNewsController, type: :controller do
  describe 'GET #index' do
    subject do
      VCR.use_cassette 'hn/request', match_requests_on: [:host, :method] do
        get :index
      end
    end

    it 'requests should be successful' do
      subject
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(subject).to render_template(:index)
    end
  end
end
