require "test_helper"

class RankingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ranking = rankings(:one)
  end

  test "should get index" do
    get rankings_url, as: :json
    assert_response :success
  end

  test "should create ranking" do
    assert_difference("Ranking.count") do
      post rankings_url, params: { ranking: { endDate: @ranking.endDate, kilometers: @ranking.kilometers, startDate: @ranking.startDate } }, as: :json
    end

    assert_response :created
  end

  test "should show ranking" do
    get ranking_url(@ranking), as: :json
    assert_response :success
  end

  test "should update ranking" do
    patch ranking_url(@ranking), params: { ranking: { endDate: @ranking.endDate, kilometers: @ranking.kilometers, startDate: @ranking.startDate } }, as: :json
    assert_response :success
  end

  test "should destroy ranking" do
    assert_difference("Ranking.count", -1) do
      delete ranking_url(@ranking), as: :json
    end

    assert_response :no_content
  end
end
