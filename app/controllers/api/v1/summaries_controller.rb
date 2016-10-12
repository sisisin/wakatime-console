require_relative '../../concerns/exclude_repository'

class Api::V1::SummariesController < ApplicationController
  def index
    exclude_repos = ExcludeRepository.new.get_exclude_repos
    @project = Project
      .includes(:editors, :entities, :languages, :operating_systems)
      .references(:editors, :entities, :languages, :operating_systems)
      .where(date: Date::today - 1)
      .where.not(name: exclude_repos)
      .first
      .to_json(:include => [:editors, :entities, :languages, :operating_systems])

    render json: @project
  end
end
