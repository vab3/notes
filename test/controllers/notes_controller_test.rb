require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(first_name: 'joe',
                        last_name: 'user',
                        is_admin: false,
                        email: 'joe@example.com',
                        password: 'password!!',
                        password_confirmation: 'password!!')
    sign_in @user
    @note = @user.notes.create(title: 'NoteTitle',
                               body: 'NoteBody')
  end

  test "should get index" do
    get notes_url
    assert_response :success
  end

  test "should get new" do
    get new_note_url
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post notes_url, params: { note: { body: @note.body, title: @note.title, user_id: @note.user_id } }
    end

    assert_redirected_to notes_url
  end

  test "should get edit" do
    get edit_note_url(@note)
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: { note: { body: @note.body, title: @note.title, user_id: @note.user_id } }
    assert_redirected_to notes_url
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete note_url(@note)
    end

    assert_redirected_to notes_url
  end

  test "should be invalid if title is > 30 chars" do
    title = ''
    31.times{title << 'a'}
    note = @user.notes.create(title: title, body: 'hi')
    refute note.valid?
  end

  test "should be invalid if title and body are blank" do
    note = @user.notes.create(title: '', body: '')
    refute note.valid?
  end

  test "title should be set to first 30 chars of body" do
    body = ""
    31.times{body << 'a'}
    expected_title = body[0..30]
    note = @user.notes.create(title: '', body: body)
    assert note.title == expected_title
  end
end
