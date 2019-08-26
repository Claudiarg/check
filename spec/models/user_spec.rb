require 'rails_helper'

RSpec.describe User, type: :model do

  #Validate attributes
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_length_of(:kind).is_at_most(255) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_inclusion_of(:kind).in_array(%w(admin employee))}

end
