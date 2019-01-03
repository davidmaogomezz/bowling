class HomeController < ApplicationController
  def index
  end

  def add_player
    puts "params"
    @number_players = params[:number_players]
    respond_to do |format|
      format.html
      format.js
    end              
  end

  def add_score
    @data = params[:data]
    @line = @data["0"]["line"]
    10.times do |time|
      puts @data["#{time+1}"]
    end
  end
end
