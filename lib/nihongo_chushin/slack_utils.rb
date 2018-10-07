# frozen_string_literal: true

module NihongoChushin
  class SlackUtils
    class << self
      def post(message)
        return if disable_env?

        webhook_urls.each do |webhook_url|
          notifier = Slack::Notifier.new(webhook_url)
          notifier.ping(message)
        end
      end

      private

      def webhook_urls
        tmp = []
        tmp << ENV["SLACK_WEBHOOK_URL"]
        tmp.compact
      end

      def disable_env?
        allow_env = %i[development staging production]
        !allow_env.include?(Rails.env.to_sym)
      end
    end
  end
end
