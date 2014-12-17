require 'test_helper'

class Journal::JournalsControllerTest < ActionController::TestCase
  setup do
    @journal_journal = journal_journals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:journal_journals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create journal_journal" do
    assert_difference('Journal::Journal.count') do
      post :create, journal_journal: { description: @journal_journal.description, slug: @journal_journal.slug, title: @journal_journal.title, user_id: @journal_journal.user_id }
    end

    assert_redirected_to journal_journal_path(assigns(:journal_journal))
  end

  test "should show journal_journal" do
    get :show, id: @journal_journal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @journal_journal
    assert_response :success
  end

  test "should update journal_journal" do
    patch :update, id: @journal_journal, journal_journal: { description: @journal_journal.description, slug: @journal_journal.slug, title: @journal_journal.title, user_id: @journal_journal.user_id }
    assert_redirected_to journal_journal_path(assigns(:journal_journal))
  end

  test "should destroy journal_journal" do
    assert_difference('Journal::Journal.count', -1) do
      delete :destroy, id: @journal_journal
    end

    assert_redirected_to journal_journals_path
  end
end
