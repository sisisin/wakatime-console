class Api::V1::SummariesController < ApplicationController
  def index
    exclude_repos = ExcludeRepository.first&.names
    exclude_repos ||= []
    @project = Project
      .includes(:editors, :entities, :languages, :operating_systems)
      .references(:editors, :entities, :languages, :operating_systems)
      .where('date <= ?', Date::today - 1)
      .where.not(name: exclude_repos)
      .to_json(:include => [:editors, :entities, :languages, :operating_systems])

    render json: @project
  end
end
