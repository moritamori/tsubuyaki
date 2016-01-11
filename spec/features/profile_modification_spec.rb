require 'rails_helper'

feature "Profile Modification" do

  let(:user) { create(:user1) }

  scenario "goes well with nomal length introduction" do

    as_user(user) do

      visit user_path(user)

      click_link 'プロフィール変更'

      expect {
        fill_in 'profile_introduction', with: Faker::Lorem.characters(60)
        click_button '保存'
      }.to change(Profile, :count).by(1)
      expect(page).to have_content 'プロフィールを登録しました'
      expect(current_path).to eq edit_user_profile_path(user)

      expect {
        fill_in 'profile_introduction', with: Faker::Lorem.characters(60)
        click_button '保存'
      }.not_to change(Profile, :count)
      expect(page).to have_content 'プロフィールを更新しました'

      expect(current_path).to eq edit_user_profile_path(user)

    end
  end

  scenario "goes wrong with long introduction" do

    as_user(user) do

      visit user_path(user)

      click_link 'プロフィール変更'

      expect {
        fill_in 'profile_introduction', with: Faker::Lorem.characters(61)
        click_button '保存'
      }.not_to change(Profile, :count)
      expect(page).to have_content 'プロフィールの登録に失敗しました'
      expect(current_path).to eq edit_user_profile_path(user)

      expect {
        fill_in 'profile_introduction', with: Faker::Lorem.characters(60)
        click_button '保存'
      }.to change(Profile, :count).by(1)
      expect(page).to have_content 'プロフィールを登録しました'
      expect(current_path).to eq edit_user_profile_path(user)

      expect {
        fill_in 'profile_introduction', with: Faker::Lorem.characters(61)
        click_button '保存'
      }.not_to change(Profile, :count)
      expect(page).to have_content 'プロフィールの更新に失敗しました'
      expect(current_path).to eq edit_user_profile_path(user)
    end
  end
end
