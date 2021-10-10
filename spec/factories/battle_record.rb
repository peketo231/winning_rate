FactoryBot.define do
    factory :battle_record do
        rate { '400' }
        association :user
        association :winning_eleven
    end
end