# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  extend Enumerize
  extend ActiveHash::Associations::ActiveRecordExtensions

  scope :unique_randoms, lambda { |limit = 1|
    ids = [*0..(count - 1)]
          .sample(limit)
          .map { |offset| offset(offset).first.id }
    where(id: ids)
  }

  class << self
    def randoms(limit = 1)
      record_count = count
      return [] if record_count.zero?

      [*0...limit].map do |_index|
        offset([*0...record_count].sample).first
      end
    end

    def random
      records = randoms
      records.empty? ? nil : records.first
    end

    def next_id
      last ? last.id + 1 : 1
    end

    def collection
      all.map { |data| [data.name, data.id] }
    end

    def destroy_all!(records)
      records = records.destroy_all
      raise ActiveRecord::RecordInvalid unless records.all?(&:destroyed?)
    end

    def now
      Time.zone.now
    end
  end

  private

  def now
    self.class.now
  end

  def notice_to_slack(message)
    NihongoChushin::SlackUtils.post(message)
  end
end
