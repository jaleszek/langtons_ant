require 'spec_helper'

describe World do
  subject{ described_class.new }
  before { n.times{ subject.move } }

  context 'before first move' do
    let(:n) { 0 }

    it 'ant stands on 0,0' do
      expect(subject.ant_position).to eq([0,0])
    end

    it '0,0 is white' do
      expect(subject.at(0,0)).to eq('white')
    end
  end

  context 'after first move' do
    let(:n) { 1 }
    it 'ant stands on 1,0' do
      expect(subject.ant_position).to eq([1,0])
    end

    it '0,0 is black' do
      expect(subject.at(0,0)).to eq('black')
    end

    it '1,0 is white' do
      expect(subject.at(1,0)).to eq('white')
    end
  end

  context 'after second move' do
    let(:n) { 2 }
    it 'ant stands on 1,-1' do
      expect(subject.ant_position).to eq([1,-1])
    end

    it '0,0 is black' do
      expect(subject.at(0,0)).to eq('black')
    end

    it '1,0 is black' do
      expect(subject.at(1,0)).to eq('black')
    end

    it '1,-1 is white' do
      expect(subject.at(1,-1)).to eq('white')
    end
  end

  context 'after fifth move' do
    let(:n) { 5 }

    it 'ant stands on -1,0' do
      expect(subject.ant_position).to eq([-1,0])
    end

    it '0,0 is white' do
      expect(subject.at(0,0)).to eq('white')
    end
  end
end
