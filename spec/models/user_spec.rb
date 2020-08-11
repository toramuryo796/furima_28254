require 'rails_helper'

RSpec.describe User, type: :model do
  dwscribe 'ユーザー新規登録' do
    it "ニック位ネームが空だと登録できない" do
    end
    it "メールアドレスが空だと登録できない" do
    end
    it "重複したメールアドレスでは登録できない" do
    end
    it "メールアドレスに@がなければ登録できない" do
    end
    it "パスワードがなければ登録できない" do
    end
    it "パスワードが5文字以下だと登録できない" do
    end
    it "パスワードが全角では登録できない" do
    end
    it "ユーザー本名(苗字)がなければ登録できない" do
    end
    it "ユーザー本名(名前)がなければ登録できない" do
    end
    it "ユーザー本名(苗字)は全角でないと登録できない" do
    end
    it "ユーザー本名(名前)は全角でないと登録できない" do
    end
    it "ユーザー本名(苗字)の振り仮名が全角カタカナでなければ登録できない" do
    end
    it "ユーザー本名(名前)の振り仮名が全角カタカナでなければ登録できない" do
    end
    it "生年月日がなければ登録できない" do
    end
  end
end
