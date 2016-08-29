require 'rails_helper'

feature 'posts' do
  context 'no pictures have been posted' do
    scenario 'should display a prompt to post a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures have been posted. Why not be the first?'
      expect(page).to have_link 'POST A PICTURE'
    end
  end

  context 'pictures have been add' do
    before do
      Picture.create(caption: 'real lies, real eyes, realize')
    end
    scenario 'should display pictures on the home page' do
      visit '/pictures'
      expect(page).to have_content('real lies, real eyes, realize')
      expect(page).not_to have_content('No pictures have been posted')
    end
  end

  context 'creating pictures' do
    scenario 'prompts user to fill out a form, then displays the new picture' do
      visit '/pictures'
      click_link 'POST A PICTURE'
      fill_in 'Caption', with: 'a little less conversation, a little more touch my body'
      click_button 'Create Picture'
      expect(page).to have_content 'a little less conversation'
      expect(current_path).to eq '/pictures'
    end
  end

  context 'viewing restaurants' do

  let!(:lll){Picture.create(caption:'Live, Laugh, Love', image:File.new('app/assets/images/duck.jpeg'))}

    scenario 'lets a user view a picture' do
      visit '/pictures'
      click_link 'Live, Laugh, Love'
      expect(page).to have_content 'Live, Laugh, Love'
      # expect(page).to have_css("a[href$='.jpeg']")
      expect(current_path).to eq "/pictures/#{lll.id}"
    end

  end

  context "editing a picture's caption" do

    before { Picture.create caption: 'Summer Daze', tag_list: 'AboutDatLyfe' }

    scenario 'let a user edit a picture' do
     visit '/pictures'
     click_link 'Summer Daze'
     click_link 'Edit Summer Daze'
     fill_in 'Caption', with: "Life is a beach and I'm just playing in the sand"
     click_button 'Update Picture'
     expect(page).to have_content 'Life is a beach'
     expect(page).not_to have_content 'Summer Daze'
     expect(current_path).to eq '/pictures'
    end

  end

  context 'deleting restaurants' do

    before { Picture.create caption: 'Beach Lyf', tag_list: 'Living, Laughing, Loving, Thriving' }

    scenario 'removes a picture when a user clicks a delete link' do
      visit '/pictures'
      click_link 'Beach Lyf'
      click_link 'Delete Beach Lyf'
      expect(page).not_to have_content 'Beach Lyf'
      expect(page).to have_content 'Picture deleted'
    end

  end
end
