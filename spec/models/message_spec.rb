require 'rails_helper'

RSpec.describe Message, type: :model do

  describe "#create" do

    context "can save" do

      it "is valid with a message" do
        expect(build(:message, image: nil)).to be_valid
      end

      it "is valid with a message and image" do
        expect(build(:message)).to be_valid
      end

      it "is valid with a image" do
        expect(build(:message, message: nil)).to be_valid
      end

    end

    context "can not save" do

      it "is invalid without a message" do
        message = build(:message, message: nil, image: nil)
        message.valid?
        expect(message.errors[:message]).to include("が入力されていません。")
      end

      it "is invalid without a group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("が入力されていません。")
      end

      it "is invalid without a user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("が入力されていません。")
      end

    end

  end

end
