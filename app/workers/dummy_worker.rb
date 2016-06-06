class DummyWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    message_json = message.to_json
    redis.rpush(queue, message_json)
  end

  def redis
    Redis.new url: redis_url
  end

  def queue
    'message_queue'
  end

  private
  def redis_url
    'redis://redis'
  end
end
