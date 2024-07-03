# frozen_string_literal: true

require_relative 'lib/modules/constants'
require_relative 'lib/modules/input_handler'
require_relative 'lib/modules/validation'
require_relative 'lib/modules/rules'
require_relative 'lib/modules/game_bank_handler'
require_relative 'lib/entities/participant'
require_relative 'lib/entities/player'
require_relative 'lib/entities/dealer'
require_relative 'lib/entities/deck'
require_relative 'lib/entities/display'
require_relative 'lib/entities/game'

Game.initialize_game.start_game
