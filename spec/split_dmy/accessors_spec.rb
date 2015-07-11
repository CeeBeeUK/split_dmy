require 'active_support/all'
require 'active_model'
require 'split_dmy/accessors'
require 'split_dmy/date_parse'
require_relative '../../spec/support/matchers/accessors_shared'

describe SplitDmy::Accessors do

  let(:model) { Model.new }

  before do
    class ModelParent; include ActiveModel::Validations; end
    class Model < ModelParent; attr_accessor :date_of_birth; end
    Model.extend(SplitDmy::Accessors)
    Model.split_dmy_accessor(:date_of_birth)
  end

  describe 'model' do
    it 'is valid' do
      model.date_of_birth = '2015-4-11'
      expect(model).to be_valid
    end

    it 'has a date of birth field to extend' do
      expect(model).to respond_to :date_of_birth
    end

    ['date_of_birth_day', 'date_of_birth_month', 'date_of_birth_year'].each do |attr|
      describe 'responds to' do
        it "##{attr}" do
          expect(model).to have_attr_accessor(attr)
        end
      end
    end
  end

  describe 'split dmy methods' do
    describe 'set themselves but do not set date' do
      describe '#date_of_birth_day' do
        it 'can be set and returned' do
          model.date_of_birth_day = 1
          expect(model.date_of_birth_day).to eq 1
          expect(model.date_of_birth).to be nil
        end
      end
      describe '#date_of_birth_month' do
        it 'can be set and returned' do
          model.date_of_birth_month = 10
          expect(model.date_of_birth_month).to eq 10
          expect(model.date_of_birth).to be nil
        end
      end
      describe '#date_of_birth_year' do
        it 'can be set and returned' do
          model.date_of_birth_year = 10
          expect(model.date_of_birth_year).to eq 10
          expect(model.date_of_birth).to be nil
        end
      end
    end
  end
end