require 'rails_helper'

describe TicketPolicy do
  context 'permissions' do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project) }

    context 'for anonymous users' do
      let(:user) { nil }

      %i[show create update destroy].each do |action|
        it { should_not permit_action action }
      end
    end

    context 'for viewers ofthe project' do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }

      %i[create update destroy].each do |action|
        it { should_not permit_action action }
      end
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      %i[show create].each do |action|
        it { should permit_action action }
      end

      %i[update destroy].each do |action|
        it { should_not permit_action action }
      end
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      %i[show create update destroy].each do |action|
        it { should permit_action action }
      end
    end

    context 'for managers of other projects' do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end

      %i[show create update destroy].each do |action|
        it { should_not permit_action action }
      end
    end

    context 'for admins' do
      let(:user) { FactoryGirl.create :user, :admin }

      %i[show create update destroy].each do |action|
        it { should permit_action action }
      end
    end
  end
end
