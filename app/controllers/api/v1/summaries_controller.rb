class Api::V1::SummariesController < ApplicationController
  def index
    @project = Project
      .includes(:editors, :entities, :languages, :operating_systems)
      .references(:editors, :entities, :languages, :operating_systems)
      .find_by(date: Date::today - 1)
      .to_json(:include => [:editors, :entities, :languages, :operating_systems])

    render json: @project
  end
end
