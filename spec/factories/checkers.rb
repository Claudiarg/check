FactoryBot.define do
  factory :checker do
    checkin { FFaker::Time.datetime }
    checkout { checkin + 8.hours }
    user
  end
end
