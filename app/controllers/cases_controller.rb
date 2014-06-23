class CasesController < ApplicationController
  def index
    @roll = Case.all.order("id desc").page(params[:page]).all
  end
end
