require 'active_support/all'
require 'active_model'
require 'split_dmy/accessors'

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

    it 'has a date of birth field' do
      expect(model).to respond_to :date_of_birth
    end
  end
end