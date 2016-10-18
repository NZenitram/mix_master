require 'rails_helper'

RSpec.feature "User submits a new artist" do
  scenario "they enter data to create a new artist" do
    artist_name       = "Bob Marley"
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit '/artists'
    click_on 'New artist'
    fill_in "artist_name", with: artist_name
    fill_in "artist_image_path", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context "the submitted data is invalid" do
    scenario "they see an error message" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

      visit artists_path
      click_on "New artist"
      fill_in "artist_image_path", with: artist_image_path
      click_on "Create Artist"

      expect(page).to have_content "Name can't be blank"
    end
  end

  context "a page displays all artists" do
    scenario "all artists appear on a page" do
      artist_1 = Artist.create(name: "Jon Denver", image_path: "blank")
      artist_2 = Artist.create(name: "Miley Cyrus", image_path: "blank")
      artist_3 = Artist.create(name: "Biggy", image_path: "blank")

      visit '/artists'

      expect(page).to have_content "Jon Denver"
      expect(page).to have_content "Miley Cyrus"
      expect(page).to have_content "Biggy"
    end
  end

  context "user can edit and update artists" do
    scenario "user can edit an artist's name" do
      artist = Artist.create(name: "Jon Denver", image_path: "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg")
      name = "Jon Doe"
      id = Artist.where(name: "Jon Denver").ids

      visit artist_path(artist)
      click_on "Edit"
      fill_in "Name", with: name
      click_on "Update Artist"

      expect(page).to have_content "Jon Doe"
    end
  end

  scenario "user can delete an artist" do
    artist = Artist.create(name: "Jon Denver", image_path: "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg")


    visit artist_path(artist)
    # save_and_open_page
    click_on "Destroy"

    expect(page).to_not have_content "Jon Doe"
  end

end
