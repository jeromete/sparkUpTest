class ImportsController < ApplicationController
  def index
  end

  def import
    if params[:file] || File.extname(params[:file]) == '.xlsx'
      @users = Import.import(params[:file])
    else
      redirect_to root_url, notice: 'Pas de fichier fourni.'
    end
  end

  def show
    redirect_to root_url
  end
end
