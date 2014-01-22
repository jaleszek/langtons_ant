require 'spec_helper'

describe World do
  subject { described_class.new }
  context 'initial state' do
    it 'center square is white' do
      expect(subject.at(0, 0)).to eq('white')
    end

    it 'ants is in 0,0' do
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
    end
  end

  context 'after first move' do
    before { subject.move_ant }
    it '0,0 is black' do
      expect(subject.at(0,0)).to eq('black')
    end

    it 'sets up ant in 1,0' do
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(0)
    end
  end

  context 'after second move' do
    before { 2.times { subject.move_ant } }

    it '0,0 is black' do
      expect(subject.at(0,0)).to eq('black')
    end

    it '1,0 is black' do
      expect(subject.at(1,0)).to eq('black')
    end

    it 'sets up ant in 1,-1' do
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(-1)
    end
  end

  context 'after fifth move' do
    before { 5.times { subject.move_ant }}

    it '1,0 is black' do
      expect(subject.at(1,0)).to eq('black')
    end

    it '1,-1 is black' do
      expect(subject.at(1,-1)).to eq('black')
    end

    it '0,-1 is black' do
      expect(subject.at(0,-1)).to eq('black')
    end

    it '0,0 is white' do
      expect(subject.at(0,0)).to eq('white')
    end

    it 'sets up ant in -1,0' do
      expect(subject.x).to eq(-1)
      expect(subject.y).to eq(0)
    end
  end

  describe '#toggle_color' do
    context 'for initialy white square' do
      it 'sets up black square' do
        subject.toggle_color(0, 0)
        expect(subject.at(0, 0)).to eq('black')
      end
    end
  end
end


describe Compass do
  subject { described_class.new }
  context 'for NORTH as initial direction' do
    it 'stares at NORTH' do
      expect(subject.current_direction).to eq('NORTH')
    end


    context 'turning left' do
      context '1 TIME' do
        before { subject.turn_left }

        it 'stares at WEST' do
          expect(subject.current_direction).to eq('WEST')
        end
      end

      context '2 TIMES' do
        before { 2.times { subject.turn_left } }

        it 'stares at SOUTH' do
          expect(subject.current_direction).to eq('SOUTH')
        end
      end

      context '5 TIMES' do
        before { 5.times { subject.turn_left }}

        it 'stares at WEST' do
          expect(subject.current_direction).to eq('WEST')
        end
      end

    end

    context 'turning right' do
      context '1 TIME' do
        before { subject.turn_right }
        it 'stares at EAST' do
          expect(subject.current_direction).to eq('EAST')
        end
      end

      context '2 TIMES' do
        before { 2.times { subject.turn_right } }

        it 'stares at SOUTH' do
          expect(subject.current_direction).to eq('SOUTH')
        end
   
      end

      context '5 TIMES' do
        before { 5.times { subject.turn_right }}

        it 'stares at EAST' do
          expect(subject.current_direction).to eq('EAST')
        end
      end
    end
  end
end