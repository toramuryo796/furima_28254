require 'rails_helper'

RSpec.describe Personal, type: :model do
  describe 'ユーザー情報登録'do
    before do
      @user = FactoryBot.build(:personal)
    end
    it "全ての記入事項を正しく記入していれば登録できる" do
      expect(@user).to be_valid
    end
     it 'ユーザー本名(苗字)がなければ登録できない' do
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角文字を入力してください")
    end
    it 'ユーザー本名(名前)がなければ登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角文字を入力してください")
    end
    it 'ユーザー本名(苗字)が全角でないと登録できない' do
      @user.family_name = 'abe'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字は全角文字を入力してください')
    end
    it 'ユーザー本名(苗字)に半角があると登録できない' do
      @user.family_name = '阿部Chris'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字は全角文字を入力してください')
    end
    it 'ユーザー本名(名前)に半角があると登録できない' do
      @user.first_name = 'ひろしChris'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前は全角文字を入力してください')
    end
    it 'ユーザー本名(苗字)の振り仮名が全角カタカナでなければ登録できない(漢字)' do
      @user.family_name_reading = '阿部'
      @user.valid?
      expect(@user.errors.full_messages).to include('フリガナ(苗字)は半角文字を入力してください')
    end
    it 'ユーザー本名(苗字)の振り仮名が全角カタカナでなければ登録できない(ひらがな)' do
      @user.family_name_reading = 'あべ'
      @user.valid?
      expect(@user.errors.full_messages).to include('フリガナ(苗字)は半角文字を入力してください')
    end
    it 'ユーザー本名(名前)の振り仮名が全角カタカナでなければ登録できない(漢字)' do
      @user.first_name_reading = '宏'
      @user.valid?
      expect(@user.errors.full_messages).to include('フリガナ(名前)は半角文字を入力してください')
    end
    it 'ユーザー本名(名前)の振り仮名が全角カタカナでなければ登録できない(ひらがな)' do
      @user.first_name_reading = 'ひろし'
      @user.valid?
      expect(@user.errors.full_messages).to include('フリガナ(名前)は半角文字を入力してください')
    end
    it '生年月日がなければ登録できない' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("誕生日を入力してください")
    end
  end
end
