class RankingsController < ApplicationController
  #before_action :set_ranking, only: %i[ show update destroy ]
  before_action :auth_request

  # GET /ranking/anio/mes
  def period

    year = params[:anio]
    month = params[:mes]
    page = params[:pagina]
    rows = params[:registros]

    from = Date.parse("01-#{month}-#{year}")
    to = Date.parse("30-#{month}-#{year}")

    @periodRanking = Ranking.joins(:user)
            .select(:name, :kilometers, :startDate, :endDate)
            .where("startDate >= ? AND startDate <= ? AND endDate >= ? AND endDate <= ?", from, to, from, to)
            .group(:name)
            .paginate(page, rows)
            .sum(:kilometers).to_a
    
            #@periodRanking.paginate(1, )

  end

  # GET /ranking/actual
  def current
    year = Date.today.year
    month = Date.today.month
    page = params[:pagina].to_i

    from = Date.parse("01-#{month}-#{year}")
    to = Date.parse("30-#{month}-#{year}")

    @currentRanking = Ranking.joins(:user)
            .select(:name, :kilometers, :startDate, :endDate)
            .where("startDate >= ? AND startDate <= ? AND endDate >= ? AND endDate <= ?", from, to, from, to)
            .group(:name)
            .order('sum_kilometers DESC')
            .paginate(page, 10)
            .sum(:kilometers).to_a

  end

  # GET /rankings
  def index
    @rankings = Ranking.all

    render json: @rankings
  end

  # GET /rankings/1
  def show
    render json: @ranking
  end

  # POST /rankings
  def create
    @ranking = Ranking.new(ranking_params)

    if @ranking.save
      render json: @ranking, status: :created, location: @ranking
    else
      render json: @ranking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rankings/1
  def update
    if @ranking.update(ranking_params)
      render json: @ranking
    else
      render json: @ranking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rankings/1
  def destroy
    @ranking.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ranking_params
      params.require(:ranking).permit(:kilometers, :startDate, :endDate, :user_id)
    end
end
