# frozen_string_literal: true

require_relative '../../lib/interface/prompt'
require 'stringio'

RSpec.describe Prompt do
  let(:question) { 'Enter a number between 1 and 6' }
  let(:invalid) { "Invalid, #{question}" }

  def generate_prompt(*args)
    input_str = StringIO.new "#{args.join("\n")}\n"
    output_str = StringIO.new
    [Prompt.new(input_str, output_str), output_str]
  end

  def verify(input)
    /^[1-6]$/.match(input)
  end

  context 'when the input meets the required condition' do
    it 'asks for input just once' do
      prompt, output = generate_prompt(4)
      input = prompt.ask(question, invalid) { |i| verify(i) }

      expect(input).to match(/^[1-6]$/)
      expect(output.string).to eq(prompt.prettify(question))
    end
  end

  context 'when the input doesn\'t have to meet a condition' do
    it 'asks for input just once' do
      prompt, output = generate_prompt(4)
      input = prompt.ask(question)

      expect(input).not_to eq nil
      expect(output.string).to eq(prompt.prettify(question))
    end
  end

  context 'when the input is wrong sometimes' do
    it 'keeps looping till an apt input is given' do
      prompt, output = generate_prompt(24, -17, 4)
      input = prompt.ask(question, invalid) { |i| verify(i) }
      probable_output = [question, invalid, invalid]
        .map { |i| prompt.prettify(i) }
        .join

      expect(input).to eq "4"
      expect(output.string).to eq probable_output
    end
  end
end
