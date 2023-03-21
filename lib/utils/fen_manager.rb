# frozen_string_literal: true

require_relative '../errors'
require_relative '../pieces/king'
require_relative '../pieces/pawn'

module FenManager
  def process_fen(text)
    meta_data = text.split
    raise InvalidFENError.new('Missing FEN arguments.') if meta_data.length != 6

    turn = meta_data[1] == 'w' ? :white : :black
    board = validate(meta_data[0], turn)
    castle_rights = meta_data[2]
    en_passant = validate_en_passant(meta_data[3], board, turn)
    fifty_turns_tally = meta_data[4].to_i

    [board, turn, castle_rights, en_passant, fifty_turns_tally]
  end

  def validate(string, turn)
    pre = pre_validate(string)
    post = parse_board(pre)
    post_validate(post, turn)
    post
  end

  def pre_validate(string)
    invalid_king_numbers = InvalidFENError.new('The board has an invalid number of kings.')
    only_one_king = string.count('k').eql?(1) && string.count('K').eql?(1)
    raise invalid_king_numbers if only_one_king

    string
  end

  def post_validate(pieces, turn)
    inactive_king = pieces.find { |piece| piece.instance_of?(King) && piece.type != turn }
    inactive_king_in_check = InvalidFENError.new('The board has inactive king in check')
    raise inactive_king_in_check if inactive_king.position_in_check?
  end

  def parse_board(string)
    board = string.split('').reverse
    invalid_rank_error = InvalidFENError.new('The board has more than 8 ranks.')
    raise invalid_rank_error unless board.length.eql?(8)
    
    pieces = {}
    board.each_with_index { | rank_text, rank | tally_rank(pieces, rank_text, rank) }
    pieces
  end

  def validate_en_passant(square, pieces, turn)
    passes_match = square.match?(/^[a-h][36]$/)
    position = square_to_array(square)

    position[0] = position[0] == 3 ? position[0] + 1 : position[0] - 1
    exists_same = pieces.find(proc { nil }) do |piece|
      piece.instance_of?(Pawn) && piece.type != type && piece.position == position
    end

    position_for_active = [position[1] + 1, position[1] - 1]
      .map { |col| [position[0], col] }
      .filter { |array| array[0].between?(0, 7) }
  
    exists_diff = pieces.find(proc { nil }) do |piece|
      is_opponent_pawn = piece.instance_of?(Pawn) && piece.type == type
      is_opponent_pawn && position_for_active.include?(piece.position)
    end

    unless passes_match && [exists_same, exists_diff].none? { |element| element.nil? }
      raise InvalidFENError.new('This en-passant is not valid.')
    end
  end

  def tally_rank(pieces, rank_text, rank)
    too_many_files_error = InvalidFENError.new("The board at rank #{rank} does not have 8 files.")
    invalid_piece_error = InvalidFENError.new("The board at rank #{rank} has invalid syntax.")

    rank_array = rank_text.split('')
    expanded_array = rank_array.map do |character|
      character.to_i.between?(1, 8) ? Array.new(character.to_i) : character
    end.flatten

    raise too_many_files_error unless expanded_array.length.eql?(8)

    expanded_array.each_with_index do |character, file|
      position = [rank, file]
      create_piece(pieces, character, position)
      raise invalid_piece_error unless char.match?(/^[rnbqkp]$/i)
    end
  end

  def create_piece(pieces, character, position)
    case character
    in 'r' | 'R' then pieces.push(Rook.new(character, position))
    in 'n' | 'N' then pieces.push(Knight.new(character, position))
    in 'b' | 'B' then pieces.push(Bishop.new(character, position))
    in 'q' | 'Q' then pieces.push(Queen.new(character, position))
    in 'k' | 'K' then pieces.push(King.new(character, position))
    in 'p' | 'P' then pieces.push(Pawn.new(character, position))
    end
  end
end
