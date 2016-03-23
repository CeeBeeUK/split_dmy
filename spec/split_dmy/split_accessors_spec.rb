require 'spec_helper'
require 'split_dmy/split_accessors'
require_relative '../../spec/support/matchers/accessors_shared'

describe SplitDmy::SplitAccessors do
  let(:date_of_birth) { nil }
  let(:model) do
    User.extend(described_class)
    User.split_dmy_accessor(:date_of_birth)
    User.new(date_of_birth: date_of_birth)
  end

  describe 'the test model' do
    it 'has a date of birth field to extend' do
      expect(model).to respond_to :date_of_birth
    end
    it 'responds to date_of_birth' do
      expect(model).to have_attr_accessor :date_of_birth
    end
  end

  ['day', 'month', 'year'].each do |part|
    it "responds to attribute_#{part}" do
      expect(model).to respond_to "date_of_birth_#{part}".to_sym
    end

    it "has split accessor for attribute_#{part}" do
      expect(model).to have_attr_accessor "date_of_birth_#{part}".to_sym
    end
  end

  context 'when date is pre-filled' do
    let(:date_of_birth) { Date.new(1992, 1, 21) }

    describe 'it splits the partials' do
      it 'sets the day' do
        expect(model.date_of_birth_day).to eq 21
      end

      it 'sets the month' do
        expect(model.date_of_birth_month).to eq 1
      end

      it 'sets the year' do
        expect(model.date_of_birth_year).to eq 1992
      end
    end

    describe 'setting the _day' do
      before { model.date_of_birth_day = dob_day }
      describe 'when sent numbers' do
        (1..31).each do |i|
          describe 'between 1 and 31 ' do
            let(:dob_day) { i }
            before { model.valid? }

            it 'sets the value' do
              expect(model.date_of_birth_day).to eq i
            end

            it 'sets the date' do
              expect(model.date_of_birth).to eq Date.new(1992, 1, i)
            end

            it 'makes the model valid' do
              expect(model).to be_valid
            end

            it 'returns no errors' do
              expect(model.errors.count).to eq 0
            end
          end
        end
      end

      describe 'to text' do
        let(:dob_day) { 'first' }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_day).to eq 'first'
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to eq nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end

      describe 'to too low a value' do
        let(:dob_day) { 0 }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_day).to eq 0
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to eq nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end

      describe 'to too high a value' do
        let(:dob_day) { 32 }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_day).to eq 32
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to eq nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end

      describe 'to nil' do
        let(:dob_day) { nil }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_day).to eq nil
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to be nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end
    end

    describe 'setting the _month' do
      before { model.date_of_birth_month = dob_month }

      describe 'when sent text' do

        I18n.t('date.month_names').each_with_index do |month, _index|
          next if month.nil?
          describe 'of long month names' do
            let(:dob_month) { model.date_of_birth_month = month }

            before { model.valid? }

            it { expect(model.date_of_birth_month).to eq Date::MONTHNAMES.index(month) }

            it 'sets the date to nil' do
              expect(model.date_of_birth).to eq Date.new(1992, Date::MONTHNAMES.index(month), 21)
            end

            it 'makes the model valid' do
              expect(model).to be_valid
            end

            it 'returns no errors' do
              expect(model.errors.count).to eq 0
            end
          end
        end

        I18n.t('date.abbr_month_names').each_with_index do |month, _index|
          next if month.nil?
          describe 'of long month names' do
            let(:dob_month) { model.date_of_birth_month = month }

            before { model.valid? }

            it { expect(model.date_of_birth_month).to eq Date::ABBR_MONTHNAMES.index(month) }

            it 'sets the date to nil' do
              expect(model.date_of_birth).to eq Date.new(1992, Date::ABBR_MONTHNAMES.index(month), 21)
            end

            it 'makes the model valid' do
              expect(model).to be_valid
            end

            it 'returns no errors' do
              expect(model.errors.count).to eq 0
            end
          end
        end

        describe 'that is not a valid month' do
          let(:dob_month) { 'first' }

          before { model.valid? }

          it 'sets the value' do
            expect(model.date_of_birth_month).to eq 'first'
          end

          it 'sets the date to nil' do
            expect(model.date_of_birth).to eq nil
          end

          it 'makes the model invalid' do
            expect(model).to be_invalid
          end

          it 'sets the error to invalid' do
            expect(model.errors[:date_of_birth]).to eq ['is invalid']
          end
        end
      end

      describe 'when sent numbers' do
        (1..12).each do |i|
          describe 'between 1 and 12 ' do
            let(:dob_month) { i }
            before { model.valid? }

            it 'sets the value' do
              expect(model.date_of_birth_month).to eq i
            end

            it 'sets the date' do
              expect(model.date_of_birth).to eq Date.new(1992, i, 21)
            end

            it 'makes the model valid' do
              expect(model).to be_valid
            end

            it 'returns no errors' do
              expect(model.errors.count).to eq 0
            end
          end
        end

        describe 'to too high a value' do
          let(:dob_month) { 13 }

          before { model.valid? }

          it 'sets the value' do
            expect(model.date_of_birth_month).to eq 13
          end

          it 'sets the date to nil' do
            expect(model.date_of_birth).to eq nil
          end

          it 'makes the model invalid' do
            expect(model).to be_invalid
          end

          it 'sets the error to invalid' do
            expect(model.errors[:date_of_birth]).to eq ['is invalid']
          end
        end

        describe 'to too low a value' do
          let(:dob_month) { 0 }

          before { model.valid? }

          it 'sets the value' do
            expect(model.date_of_birth_month).to eq 0
          end

          it 'sets the date to nil' do
            expect(model.date_of_birth).to eq nil
          end

          it 'makes the model invalid' do
            expect(model).to be_invalid
          end

          it 'sets the error to invalid' do
            expect(model.errors[:date_of_birth]).to eq ['is invalid']
          end
        end
      end

      describe 'to nil' do
        let(:dob_month) { nil }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_month).to eq nil
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to be nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end
    end

    describe 'setting the _year' do
      before { model.date_of_birth_year = dob_year }

      describe 'as numbers' do
        describe 'numerically' do
          describe 'in the acceptable range' do
            let(:dob_year) { 1961 }

            before { model.valid? }

            it 'sets the value' do
              expect(model.date_of_birth_year).to eq 1961
            end

            it 'sets the date to nil' do
              expect(model.date_of_birth).to eq Date.new(1961, 1, 21)
            end

            it 'makes the model valid' do
              expect(model).to be_valid
            end

            it 'returns no errors' do
              expect(model.errors.count).to eq 0
            end
          end

          describe 'outside the acceptable range' do
            let(:dob_year) { 3334 }

            before { model.valid? }

            it 'sets the value' do
              expect(model.date_of_birth_year).to eq 3334
            end

            it 'sets the date to nil' do
              expect(model.date_of_birth).to eq nil
            end

            it 'makes the model invalid' do
              expect(model).to be_invalid
            end

            it 'sets the error to invalid' do
              expect(model.errors[:date_of_birth]).to eq ['is invalid']
            end
          end
        end

        describe 'as text' do
          let(:dob_year) { '1961' }

          before { model.valid? }

          it 'sets the value' do
            expect(model.date_of_birth_year).to eq 1961
          end

          it 'sets the date to nil' do
            expect(model.date_of_birth).to eq Date.new(1961, 1, 21)
          end

          it 'makes the model valid' do
            expect(model).to be_valid
          end

          it 'returns no errors' do
            expect(model.errors.count).to eq 0
          end
        end
      end

      describe 'using text' do
        let(:dob_year) { 'Nineteen Sixty One' }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_year).to eq 'Nineteen Sixty One'
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to eq nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end

      describe 'to nil' do
        let(:dob_year) { nil }

        before { model.valid? }

        it 'sets the value' do
          expect(model.date_of_birth_year).to eq nil
        end

        it 'sets the date to nil' do
          expect(model.date_of_birth).to be nil
        end

        it 'makes the model invalid' do
          expect(model).to be_invalid
        end

        it 'sets the error to invalid' do
          expect(model.errors[:date_of_birth]).to eq ['is invalid']
        end
      end
    end

    describe 'when passed implausible dates' do
      before do
        model.date_of_birth_day = 30
        model.date_of_birth_month = 2
        model.date_of_birth_year = 2015
        model.valid?
      end

      it 'returns an error' do
        expect(model.errors[:date_of_birth]).to eq ['is invalid']
      end
    end
  end
end
