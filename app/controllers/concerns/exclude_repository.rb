require 'octokit'

class ExcludeRepository
  def get_exclude_repos
    org = ENV['GITHUB_EXCLUDE_ORGS']
    raise 'Invalid nil enviroment variable "GITHUB_EXCLUDE_ORGS".' unless org

    c = Octokit::Client.new(get_github_user)
    c.org_repos(org).map(&:name)
  end

  def get_github_user
    login = ENV['GITHUB_USER']
    password = ENV['GITHUB_API_KEY']
    raise 'Invalid nil enviroment variable "GITHUB_USER".' unless login
    raise 'Invalid nil enviroment variable "GITHUB_API_KEY".' unless password

    { login: login, password: password }
  end

end
