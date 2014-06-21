class CasesController < ApplicationController
  def index
    @roll = Case.all.order("id desc").page(params[:page]).per(10)
  end

  def show
    @roll = Case.all.order("id desc").page(params[:page]).per(10)
  end
end
