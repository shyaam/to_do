require 'spec_helper'

describe Task do
  context 'validations' do
    it {should validate_presence_of :name}
    it {should ensure_length_of(:name).
      is_at_least(3).
      is_at_most(100)}
    it {should validate_uniqueness_of(:name)}
  end

  context 'callbacks' do
    it 'converts the name to lowercase' do
      task = Task.create(:name => "PACK A LUNCH")
      task.name.should eq "pack a lunch"
    end
  end

  context 'associations' do
    it {should belong_to :list}
  end

  context '.not_done' do
    it 'returns only not done tasks' do
      not_done_tasks = (1..5).to_a.map {|number| Task.create(:name => "task #{number}", :done => false)}
      done_task = Task.create(:name => "done task", :done => true)
      Task.not_done.should eq not_done_tasks
    end
  end
end