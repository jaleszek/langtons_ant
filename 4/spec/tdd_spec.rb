require 'spec_helper'

describe World do
  # we assume that all squares are white
  subject { described_class.new }
  before { n.times { subject.move } }

  context 'before first move' do
    let(:n) { 0 }
    it 'ant is at 0,0' do
      expect(subject.ant_position).to eq([0,0])
    end

    it '0,0 is white' do
      expect(subject.at(0,0)).to eq('white')
    end
  end

  context 'after first move' do
    let(:n) { 1 }

    it 'ant is at 1,0' do
      expect(subject.ant_position).to eq([1,0])
    end

    it '0,0 is black' do
      expect(subject.at(0,0)).to eq('black')
    end
  end

  context 'after second move' do
    let(:n) { 2 }

    it 'ant is at 1,-1' do
      expect(subject.ant_position).to eq([1,-1])
    end

    it '1,0 is black' do
      expect(subject.at(1,0)).to eq('black')
    end 
  end

  context 'after fifth move' do
    let(:n) { 5 }
    it 'ant is at -1,0' do
      expect(subject.ant_position).to eq([-1,0])
    end
  end
end

describe Compass do
  subject { described_class.new }

  context 'initialy' do
    it 'stares at NORTH' do
      expect(subject.current_direction).to eq('NORTH')
    end
  end

  context 'after 1 turn right' do
    before { subject.turn_right }
    it 'stares at EAST' do
      expect(subject.current_direction).to eq('EAST')
    end
  end

  context 'after 2 turns right' do
    before { 2.times { subject.turn_right }}

    it 'stares at SOUTH' do
      expect(subject.current_direction).to eq('SOUTH')
    end
  end

  context 'after 3 turns right' do
    before { 3.times { subject.turn_right }}

    it 'stares at WEST' do
      expect(subject.current_direction).to eq('WEST')
    end
  end

  context 'after 4 turns right' do
    before { 4.times { subject.turn_right }}

    it 'stares at NORTH' do
      expect(subject.current_direction).to eq('NORTH')
    end
  end

  context 'after 1 turn left' do
    before { subject.turn_left }
    it 'stares at WEST' do
      expect(subject.current_direction).to eq('WEST')
    end
  end

  context 'after 2 turn left' do
    before { 2.times { subject.turn_left }}
    it 'stares at SOUTH' do
      expect(subject.current_direction).to eq('SOUTH')
    end
  end

  context 'after 3 turn left' do
    before { 3.times { subject.turn_left }}
    it 'stares at EAST' do
      expect(subject.current_direction).to eq('EAST')
    end
  end

  context 'after 4 turn left' do
    before { 4.times {subject.turn_left }}

    it 'stares at NORTH' do
      expect(subject.current_direction).to eq('NORTH')
    end
  end
end


describe WalkStrategy do
  subject { described_class.new }
  context 'walking at WEST' do
    it 'decreases X coordinate by 1' do
      @x= 0
      eval(subject.perform('WEST'))
      expect(@x).to eq(-1)
    end
  end
  context 'walking at SOUTH' do
    it 'decreases Y coordinate by 1' do
      @y = 0
      eval(subject.perform('SOUTH'))
      expect(@y).to eq(-1)
    end
  end
  context 'walking at EAST' do
    it 'increases X coordinate by 1' do
      @x = 0
      eval(subject.perform('EAST'))
      expect(@x).to eq(1)
    end
  end
  context 'walking at NORTH' do
    it 'increases Y coordinate by 1' do
      @y = 0
      eval(subject.perform('NORTH'))
      expect(@y).to eq(1)
    end
  end
end