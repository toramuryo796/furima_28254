require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    it '全ての記入事項を記入していれば登録できる' do
      expect(@user).to be_valid
    end
    it 'ニックネームが空だと登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください", "ニックネームは不正な値です")
    end
    it 'メールアドレスが空だと登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください", "Eメールには'@'をつけてください")
    end
    it '重複したメールアドレスでは登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'メールアドレスに@がなければ登録できない' do
      @user.email = 'kkkk'
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です", "Eメールには'@'をつけてください")
    end
    it 'パスワードがなければ登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは半角英数字を混合させて入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'パスワードが5文字以下だと登録できない' do
      @user.password = 'a2345'
      @user.password_confirmation = 'a2345'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワードが全角では登録できない' do
      @user.password = 'あいうえおか'
      @user.password_confirmation = 'あいうえおか'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字を混合させて入力してください')
    end
    it 'パスワードが半角英字だけでは登録できない' do
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字を混合させて入力してください')
    end
    it 'パスワードが数字だけでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字を混合させて入力してください')
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
