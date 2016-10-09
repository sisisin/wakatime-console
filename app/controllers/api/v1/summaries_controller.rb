class Api::V1::SummariesController < ApplicationController
  def index
    @project = Project
      .includes(:editor, :entity, :language, :operating_system)
      .references(:editor, :entity, :language, :operating_system)
      .find_by(date: Date::today - 1)
      .to_json(:include => [:editor, :entity, :language, :operating_system])

    render json: @project
  end
end
