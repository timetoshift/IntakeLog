class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  require 'will_paginate'

  respond_to :html

  def index
    @account = Account.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end

  def show
    @notes = Note.where(account_id: @account.id) #Where a note belong to the current account
  end

  def new
    @account = Account.new
    respond_with(@account)
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.save
    respond_with(@account)
  end

  def update
    @account.update(account_params)
    respond_with(@account)
  end

  def destroy
    @account.destroy
    respond_with(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:first_name, :last_name, :return_client, :program_id, :insurance_id, :address, :phone)
    end
end