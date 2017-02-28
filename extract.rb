require "bundler/setup"
require "rubygems"
Bundler.require
require "dotenv/load"

require "roo"
require "octokit"

MEDIA_TYPE = "application/vnd.github.inertia-preview+json"

xlsx = Roo::Excelx.new(ARGV[0])

# NOTE: やりたいことカラムの、有効な値があるセルを抜き出す。[0] は header なので無視してる。
todos = xlsx.sheet("参加者").column(7)[1..-1].reject{|todo| todo.nil? || todo.empty? }

client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
project = client.projects(ENV["REPO_NAME"], accept: MEDIA_TYPE).find{|proj| proj[:name] == ENV["PROJECT_NAME"] }
column = client.project_columns(project[:id], accept: MEDIA_TYPE).find{|col| col[:name] == ENV["COLUMN_NAME"] }

todos.each do |todo|
  client.create_project_card(column[:id], note: todo, accept: MEDIA_TYPE)
  puts "Created note: #{todo}"
end
