# Tickets belong to Projects
class TicketsController < ApplicationController
  before_action :set_project

  def new
    @ticket = @project.tickets.build
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
