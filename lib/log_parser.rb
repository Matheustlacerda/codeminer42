# frozen_string_literal: true

require 'json'

class LogParser
  def initialize(file_path)
    @file_path = file_path
    raise StandardError, 'File not found' unless File.exist?(@file_path)
  end

  def read_first_line
    File.readlines(@file_path).first
  end

  def json_output
    {
      "#{@file_path}": {
        'lines': lines_counter,
        'players': remove_world
      }
    }
  end

  private

  def lines_counter
    File.readlines(@file_path).count
  end

  def players
    game_players = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed'
        game_players << line.split('killed')[0].split(':').last.strip
        game_players << line.split('killed')[1].split('by').first.strip
      end
    end
    game_players = game_players.uniq
  end

  def remove_world
    gamers = players
    gamers.delete('<world>')
    gamers
  end
end
