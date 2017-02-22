require "bundler/setup"
require "rubygems"
Bundler.require

require "roo"
require "pry"

xlsx = Roo::Excelx.new("./yochiyochirb-tickets-57728.xlsx")

# NOTE: やりたいことカラムの、有効な値があるセルを抜き出す。[0] は header なので無視してる。
todos = xlsx.sheet("参加者").column(7)[1..-1].select{|todo| !todo.empty? }
