# encoding: utf-8
class CommentsController < ApplicationController

  before_filter :authenticate_user!

  before_action :set_comment, only: [:show, :destroy]

  before_action :set_entity

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @entity.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
        format.js   { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def set_entity
      @entity = case
                when params.has_key?(:photo_id) then Photo.find(params[:photo_id])
                end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :entity_type, :entity_id, :content, :deleted_at, :reason)
    end
end
