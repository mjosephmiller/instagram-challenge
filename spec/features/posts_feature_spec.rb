require 'rails_helper'

feature 'posts' do
  context 'no pictures have been posted' do
    scenario 'should display a prompt to post a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures have been posted. Why not be the first?'
      expect(page).to have_link 'POST A PICTURE'
    end

    scenario 'it prevents a user from posting a picture without attaching an image' do
      visit '/pictures'
      click_link 'POST A PICTURE'
      fill_in 'Caption', with: 'Throwback'
      expect { click_button 'Create Picture' }.not_to change(Picture, :count)
    end
  end

  context 'pictures have been added' do

    before do
      Picture.create(caption: 'real lies, real eyes, realize', image:File.new('app/assets/images/duck.jpeg'))
    end

    scenario 'should display pictures on the home page' do
      visit '/pictures'
      expect(page).to have_content('real lies, real eyes, realize')
      expect(page).not_to have_content('No pictures have been posted')
    end
  end

  context 'viewing restaurants' do

  let!(:lll){Picture.create(caption:'Live, Laugh, Love', image:File.new('app/assets/images/duck.jpeg'))}

    scenario 'lets a user view a picture' do
      visit '/pictures'
      click_link 'Live, Laugh, Love'
      expect(page).to have_content 'Live, Laugh, Love'
      expect(current_path).to eq "/pictures/#{lll.id}"
    end

    scenario 'let a user edit a picture' do
     visit '/pictures'
     click_link 'Live, Laugh, Love'
     click_link 'Edit Live, Laugh, Love'
     fill_in 'Caption', with: "Life is a beach and I'm just playing in the sand"
     click_button 'Update Picture'
     expect(page).to have_content 'Life is a beach'
     expect(page).not_to have_content 'Live, Laugh, Love'
     expect(current_path).to eq '/pictures'
    end

    scenario 'removes a picture when a user clicks a delete link' do
      visit '/pictures'
      click_link 'Live, Laugh, Love'
      click_link 'Delete Live, Laugh, Love'
      expect(page).not_to have_content 'Live, Laugh, Love'
      expect(page).to have_content 'Picture deleted'
    end

  end

end
