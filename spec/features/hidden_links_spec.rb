require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:project) { FactoryGirl.create(:project) }

  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, author: user)
  end

  context 'non-admin users (project viewers)' do
    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario 'cannot see the dit link' do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link 'Edit Ticket'
    end

    scenario 'cannot see the project delete link' do
      visit project_path(project)
      expect(page).not_to have_link 'Delete Project'
    end

    scenario 'cannot see the new Project link' do
      visit '/'
      expect(page).not_to have_link 'New Project'
    end

    scenario 'cannot see the project delete link' do
      visit project_path(project)
      expect(page).not_to have_link 'Delete Project'
    end

    scenario 'cannot see the edit project link' do
      visit project_path(project)
      expect(page).not_to have_link 'Edit Project'
    end
  end

  context 'admin users' do
    before { login_as(admin) }

    scenario 'can see the edit ticket link' do 
      visit project_ticket_path(project, ticket)
      expect(page).to have_link 'Edit Ticket'
    end

    scenario 'can see the Delete Project Link' do
      visit project_path(project)
      expect(page).to have_link 'Delete Project'
    end

    scenario 'can see the New Project Link' do
      visit '/'
      expect(page).to have_link 'New Project'
    end

    scenario 'can see the edit project link' do
      visit project_path(project)
      expect(page).to have_link 'Edit Project'
    end
  end
end
