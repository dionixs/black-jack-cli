# frozen_string_literal: true

module Constants
  INITIAL_BANK = 100
  INITIAL_SUM = 0

  CARD_POINTS = {
    '🂡': 1, '🂢': 2, '🂣': 3,   '🂤': 4,  '🂥': 5,  '🂦': 6,
    '🂧': 7, '🂨': 8, '🂩': 9,   '🂪': 10, '🂫': 10, '🂭': 10, '🂮': 10,
    '🂱': 1, '🂲': 2, '🂳': 3,   '🂴': 4,  '🂵': 5,  '🂶': 6,  '🂷': 7,
    '🂸': 8, '🂹': 9, '🂺': 10,  '🂻': 10, '🂽': 10, '🂾': 10,
    '🃁': 1, '🃂': 2, '🃃': 3,   '🃄': 4,  '🃅': 5,  '🃆': 6,
    '🃇': 7, '🃈': 8, '🃉': 9,   '🃊': 10, '🃋': 10, '🃍': 10, '🃎': 10,
    '🃑': 1, '🃒': 2, '🃓': 3,   '🃔': 4,  '🃕': 5,  '🃖': 6,
    '🃗': 7, '🃘': 8, '🃙': 9,   '🃚': 10, '🃛': 10, '🃝': 10, '🃞': 10
  }.freeze

  CARDS = CARD_POINTS.keys
end
