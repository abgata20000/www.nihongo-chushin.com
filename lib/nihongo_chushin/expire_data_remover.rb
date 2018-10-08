# frozen_string_literal: true

module NihongoChushin
  class ExpireDataRemover < BaseExecutor
    def run_process
      Chat::ExpireDataRemover.run
    end
  end
end
