# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    user_id {FactoryGirl.create(:user).id}
    email "z.stayman@gmail.com"
    password "test"
    password_confirmation "test"
    first_name "zack"
    last_name "stayman"
  end
end
