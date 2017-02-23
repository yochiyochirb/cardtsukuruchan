require "bundler/setup"
require "rubygems"
Bundler.require
require "dotenv/load"

require "roo"
require "octokit"

xlsx = Roo::Excelx.new(ARGV[0])

# NOTE: やりたいことカラムの、有効な値があるセルを抜き出す。[0] は header なので無視してる。
todos = xlsx.sheet("参加者").column(7)[1..-1].select{|todo| !todo.empty? }

client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])

project = client.projects(ENV["REPO_NAME"]).select{|proj| proj[:name] == ENV["PROJECT_NAME"]}.shift

column = client.project_columns(project[:id]).select{|col| col[:name] == ENV["COLUMN_NAME"]}.shift

todos.each do |todo|
  client.create_project_card(column[:id], note: todo)
end
