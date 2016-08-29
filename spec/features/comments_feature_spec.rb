require 'rails_helper'

feature 'commenting' do
  before do
    Picture.create(caption: 'Beach Lyf', image:File.new('app/assets/images/duck.jpeg'))
  end
  scenario 'allows users to leave a comment using a form' do
     visit '/pictures'
     click_link 'Beach Lyf'
     click_link 'COMMENT'
     fill_in "Comments", with: "Wow!"
     click_button 'Submit'
     expect(current_path).to eq "/pictures"
     click_link 'Beach Lyf'
     expect(page).to have_content('Wow!')
  end

end
