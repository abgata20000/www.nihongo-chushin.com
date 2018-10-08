# frozen_string_literal: true

module NihongoChushin
  class ExpireDataRemover
    class << self
      def run
        Chat::ExpireDataRemover.run
      end
    end
  end
end
