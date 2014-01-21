require 'spec_helper'

describe World do
  subject { described_class.new }
  context 'initial state' do
    it 'starts with all white squares' do
      expect(subject.at(12222,123124)).to eq('white')
    end

  end

  it 'has array of squares' do
    expect(subject.squares).to eq({}) 
  end

  it 'adds black square at 0,0' do
    subject.toggle_square(0,0)
    expect(subject.at(0,0)).to eq('black')
  end

  describe '#toggle_square' do
    context 'initialy black square' do

      it 'toggles to white square' do
        subject.toggle_square(0,0)
        expect(subject.at(0,0)).to eq('black')

        subject.toggle_square(0,0)
        expect(subject.at(0,0)).to eq('white')
      end
    end

    context 'initialy white square' do
      it 'toggles to black square' do
        expect(subject.at(0,0)).to eq('white')
        subject.toggle_square(0,0)
        expect(subject.at(0,0)).to eq('black')
      end
    end
  end
end

describe Ant do
  let(:world) { World.new }
  subject { described_class.new(world) }
  
  context 'for initial state' do
    it 'starts from x coordinates'   do
      expect(subject.x).to eq(0)
    end

    it 'starts from y coordinates' do
      expect(subject.y).to eq(0)
    end
  end

  context 'after first move' do
    it 'should be aware of new position she is' do
      subject.move
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(0)
    end

    it 'should change color of previous square' do
      subject.move
      expect(world.at(0,0)).to eq('black')
    end

    it 'not change color of current square' do
      subject.move
     expect(world.at(0,1)).to eq('white') 
    end
  end

  context 'after second move' do
    before { 2.times { subject.move } }

    it 'sets appropriate colors' do
      expect(world.at(0,0)).to eq('black')
      expect(world.at(1,0)).to eq('black')
      expect(world.at(1,-1)).to eq('white')
    end

    it 'should be aware of new position' do
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(-1)
    end
  end

  context 'after fifth move' do
    before { 5.times { subject.move }}

    
    it 'should be aware of new position' do
      expect(subject.x).to eq(-1)
      expect(subject.y).to eq(0)
    end

    it 'sets appropriate colors' do
      expect(world.at(0,0)).to eq('white')
      expect(world.at(1,0)).to eq('black')
      expect(world.at(1,-1)).to eq('black')
      expect(world.at(0,-1)).to eq('black')
      expect(world.at(-1, 0)).to eq('white')
    end
  end
end

describe AntCompass do
  subject { described_class.new }

  describe '.for_int_direction' do
    context '+1 input' do
      it 'turns right' do
        subject.for_int_direction(1)
        expect(subject.current_direction).to eq('EAST')
      end

    end

    context '-1 input' do
      it 'turns left' do
        subject.for_int_direction(-1)
        expect(subject.current_direction).to eq('WEST')
      end
    end
  end

  context 'for starting with NORTH direction' do
    let(:north) { 'NORTH' }
  
    describe '#current_direction' do
      it 'starts from north' do
        expect(subject.current_direction).to eq(north)
      end
    end

    context 'for first turn left' do
      it 'stares at WEST' do
        subject.turn_left
        expect(subject.current_direction).to eq('WEST')
      end
    end

    context 'for second turn left' do
      it 'stares at SOUTH' do
        2.times { subject.turn_left }
        expect(subject.current_direction).to eq('SOUTH')
      end
    end

    context 'for fourth turn left' do
      it 'stares at NORTH' do
        4.times { subject.turn_left }
        expect(subject.current_direction).to eq('NORTH')
      end
    end

    context 'for first turn right' do
      it 'stares at EAST' do
        subject.turn_right
        expect(subject.current_direction).to eq('EAST')
      end
    end

    context 'for second turn right' do
      it 'stares at SOUTH' do
        2.times { subject.turn_right }
        expect(subject.current_direction).to eq('SOUTH')
      end
    end

    context 'for fourth turn right' do
      it 'stares at NORTH' do
        4.times { subject.turn_right }
        expect(subject.current_direction).to eq('NORTH')
      end
    end
  end
end


describe WorldPrinter do
  subject { described_class.new(input)}

  context 'for empty world' do
    let(:input) { [] }

    it 'should print default world' do
      expect(subject.print).to eq(
        "***\n***\n***"
        )
    end
  end
end