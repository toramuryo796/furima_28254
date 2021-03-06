require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '商品購入' do
    before do
      @buyer = FactoryBot.create(:user, nickname: 'suzuki')
      @purchase = FactoryBot.build(:purchase, user: @buyer)
      @seller = @purchase.item.user
      @purchase.price = @purchase.item.price
    end

    it '全ての記入事項が正しく記入されていれば購入できる' do
      expect(@purchase).to be_valid
    end
    it '建物名が空でも購入できる' do
      @purchase.building_name = ''
      expect(@purchase).to be_valid
    end
    it '価格が空だと購入できない' do
      @purchase.price = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("価格を入力してください")
    end
    it '郵便番号が空だと購入できない' do
      @purchase.postal_code = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号がひらがなだと購入できない' do
      @purchase.postal_code = 'あいうえお'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号がカタカナだと購入できない' do
      @purchase.postal_code = 'アイウエオ'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号が半角英字だと購入できない' do
      @purchase.postal_code = 'aiueo'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号にハイフンがないと購入できない' do
      @purchase.postal_code = '1234567'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号が2文字-4文字だと購入できない' do
      @purchase.postal_code = '12-1234'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号が4文字-4文字だと購入できない' do
      @purchase.postal_code = '1234-1234'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号が3文字-3文字だと購入できない' do
      @purchase.postal_code = '123-123'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '郵便番号が3文字-5文字だと購入できない' do
      @purchase.postal_code = '123-12343'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("郵便番号には'-'(ハイフン)を入れてください")
    end
    it '都道府県名を選択していなければ購入できない' do
      @purchase.origin_area_id = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("都道府県を入力してください")
    end
    it '市区町村が空だと購入できない' do
      @purchase.city = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("市町村を入力してください", "市町村は全角文字を入力してください")
    end
    it '市区町村名が半角だと購入できない' do
      @purchase.city = 'Yokohama'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('市町村は全角文字を入力してください')
    end
    it '市区町村名に数字があると購入できない' do
      @purchase.city = '横浜市12'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('市町村は全角文字を入力してください')
    end
    it '番地が半角英字だと購入できない' do
      @purchase.house_number = 'Shobuzawa894-1'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('番地は全角文字または半角数字を入力してください')
    end
    it '電話番号が空だと購入できない' do
      @purchase.phone_number = ''
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("電話番号を入力してください", "電話番号は半角数字の10または11桁の数字を入れてください")
    end
    it '電話番号が0から出なければ購入できない' do
      @purchase.phone_number = '123456789101'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
    it '電話番号にひらがながあると購入できない' do
      @purchase.phone_number = '01234あ67891'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
    it '電話番号にカタカナがあると購入できない' do
      @purchase.phone_number = '01234ア67891'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
    it '電話番号に半角英字があると購入できない' do
      @purchase.phone_number = '01234a67891'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
    it '電話番号が9文字以下だと購入できない' do
      @purchase.phone_number = '012345678'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
    it '電話番号が12文字以上だと購入できない' do
      @purchase.phone_number = '0123456789101'
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include('電話番号は半角数字の10または11桁の数字を入れてください')
    end
  end
end
