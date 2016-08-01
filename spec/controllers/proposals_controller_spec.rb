require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do
  render_views
  
  it "should show index page" do
    get :index
    expect(response).to be_ok
    expect(response.body).to include "http://openpolitics.org.uk"
  end

  it "should show individual proposal page", :vcr do
    # Load a user
    User.create(login: 'Floppy')
    # Load a proposal
    Proposal.create_from_github!(405) # proposed by this user
    # Test show page
    get :show, params: {id: 405}
    expect(response).to be_ok
    expect(response.body).to include "Floppy"
  end

end
