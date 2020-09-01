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
      expect(@user.errors.full_messages).to include("ニックネームを入力してください", "ニックネーム 数字・スペースを入れないでください")
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
  end
end
