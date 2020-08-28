require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end
    it '全ての記入事項が正しく記入さていれば出品できる' do
      expect(@item).to be_valid
    end
    it '価格が300円以上であれば出品できる' do
      @item.price = '300'
      expect(@item).to be_valid
    end
    it '価格が9,999,999円以内であれば出品できる' do
      @item.price = '9999999'
      expect(@item).to be_valid
    end
    it '商品の名前が空だと出品できない' do
      @item.title = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Title can't be blank")
    end
    it '商品の名前が41文字以上だと出品できない' do
      @item.title = Faker::Lorem.characters(number: 41)
      @item.valid?
      expect(@item.errors.full_messages).to include('Title is invalid. Input within 40 characters.')
    end
    it '画像がなければ出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品説明が空だと出品できない' do
      @item.explain = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Explain can't be blank")
    end

    it '商品説明がが1001文字以上だと出品できない' do
      @item.explain = Faker::Lorem.characters(number: 1001)
      @item.valid?
      expect(@item.errors.full_messages).to include('Explain is invalid. Input within 40 characters.')
    end
    it '価格が空だと出品できない' do
      @item.price = nil
      @item.invalid?
      expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is invalid. Input number from 300 to 9,999,999.', 'Price is invalid. Input number.')
    end
    it '価格が300円未満だと出品できない' do
      @item.price = '299'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it '価格が10,000,000円以上だと出品できない' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it '価格が全角の数字だと出品できない' do
      @item.price = '１２３４５'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it '価格がひらがなだと出品できない' do
      @item.price = 'ごひゃく'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it '価格がカタカナだと出品できない' do
      @item.price = 'ゴヒャク'
      @item.invalid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it '価格が半角英字だと出品できない' do
      @item.price = 'five hundred'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input number from 300 to 9,999,999.')
    end
    it 'カテゴリーについて選択されていなければ出品できない' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態について選択されていなければ出品できない' do
      @item.status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end
    it '配送料の負担について選択していなければ出品できない' do
      @item.fee_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Fee can't be blank")
    end
    it '発送元の地域について選択していなければ出品できない' do
      @item.origin_area_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Origin area can't be blank")
    end
    it '発送までの日数について選択していなければ出品できない' do
      @item.take_day_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Take day can't be blank", 'Take day is not a number')
    end
  end
end
