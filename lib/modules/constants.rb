# frozen_string_literal: true

module Constants
  INITIAL_BANK_PARTICIPANT = 100
  INITIAL_GAME_BANK = 0
  INITIAL_SCORE = 0

  CARD_POINTS = {
    '🂡': 11, '🂢': 2, '🂣': 3,  '🂤': 4,  '🂥': 5,  '🂦': 6,
    '🂧': 7,  '🂨': 8, '🂩': 9,  '🂪': 10, '🂫': 10, '🂭': 10, '🂮': 10,
    '🂱': 11, '🂲': 2, '🂳': 3,  '🂴': 4,  '🂵': 5,  '🂶': 6,  '🂷': 7,
    '🂸': 8,  '🂹': 9, '🂺': 10, '🂻': 10, '🂽': 10, '🂾': 10,
    '🃁': 11, '🃂': 2, '🃃': 3,  '🃄': 4,  '🃅': 5,  '🃆': 6,
    '🃇': 7,  '🃈': 8, '🃉': 9,  '🃊': 10, '🃋': 10, '🃍': 10, '🃎': 10,
    '🃑': 11, '🃒': 2, '🃓': 3,  '🃔': 4,  '🃕': 5,  '🃖': 6,
    '🃗': 7,  '🃘': 8, '🃙': 9,  '🃚': 10, '🃛': 10, '🃝': 10, '🃞': 10
  }.freeze

  ACES = %i[🂡 🂱 🃁 🃑].freeze

  CARDS = CARD_POINTS.keys

  MAKE_FIRST_MOVE = "skip move - Пропуск хода\tadd card - Добавить карту\nВыберите вариант"
  MAKE_MOVE_WITHOUT_ADD_CARD = "skip move - Пропуск хода\tshow cards - Открыть карты\nВыберите вариант"
  MAKE_MOVE_WITHOUT_SKIP_MOVE = "show cards - Открыть карты\tadd card Добавить карту\nВыберите вариант"
  INPUT_ERROR = 'Ошибка ввода. Введите правильный вариант.'
end
