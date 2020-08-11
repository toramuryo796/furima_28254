require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    it "全ての記入事項を記入していれば登録できる" do
      expect(@user).to be_valid
    end
    it "ニックネームが空だと登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "メールアドレスが空だと登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "重複したメールアドレスでは登録できない" do
      @user.save
      user2 = FactoryBot.build(:user)
      user2.email = @user.email
      user2.valid?
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end
    it "メールアドレスに@がなければ登録できない" do
      @user.email = "kkkk"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid", "Email is invalid, Include '@'.")
    end
    it "パスワードがなければ登録できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードが5文字以下だと登録できない" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "パスワードが全角では登録できない" do
      @user.password = "あいうえおか"
      @user.password_confirmation = "あいうえおか"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid.Input half_width characters")
    end
    it "ユーザー本名(苗字)がなければ登録できない" do
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid. Input full_width characters.")
    end
    it "ユーザー本名(名前)がなければ登録できない" do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid. Input full_width characters.")
    end
    it "ユーザー本名(苗字)が全角出ないとと登録できない" do
      @user.family_name = "abe"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid. Input full_width characters.") 
    end
    it "ユーザー本名(名前)は全角でないと登録できない" do
      @user.first_name = "abe"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full_width characters.") 
    end
    it "ユーザー本名(苗字)の振り仮名が全角カタカナでなければ登録できない" do
      @user.family_name_reading = "阿部"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name reading is invalid. Input half_width characters.") 
    end
    it "ユーザー本名(名前)の振り仮名が全角カタカナでなければ登録できない" do
      @user.first_name_reading = "阿部"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading is invalid. Input half_width characters.") 
    end
    it "生年月日がなければ登録できない" do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
