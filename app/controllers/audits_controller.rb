class AuditsController < ApplicationController
  before_action :set_audit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def start_audit
    @audit = Audit.find(params[:audit_id])
    @questions = @audit.questions.all

    @audit_submission = AuditSubmission.create(
      audit_id: @audit.id,
      completed: false,
      user_id: current_user.id
      )

    @questions.each do |question|
      Response.create(
        audit_submission_id: @audit_submission.id,
        question_id: question.id
        )
    end

    redirect_to audit_start_audit_list_path(@audit)
  end 

  def start_audit_list
    @audit = Audit.find(params[:audit_id])
    @audit_submission = AuditSubmission.where(audit_id: @audit.id).last
    @responses = Response.where(audit_submission_id: @audit_submission.id).all
  end

  def save_audit
    puts 'reached here'
    @find_response = Response.find(params[:get_response].to_i)

    if params[:response_status] == "YES"
      @find_response.update_attributes(response_entry: params[:response_entry].to_s, user_id: current_user.id, status: "YES")
    elsif params[:response_status] == "NO"
       @find_response.update_attributes(response_entry: params[:response_entry].to_s, user_id: current_user.id, status: "NO")
    else
      @find_response.update_attributes(response_entry: params[:response_entry].to_s, user_id: current_user.id, status: "NA")
    end
    respond_to do |format|
      format.js {head :ok}
    end
  end

  def complete_audit

    @audit_submission = AuditSubmission.find(params[:audit_submission])
    @response_no = Response.where(audit_submission_id: @audit_submission.id).where(status: "NO").all
    @response_yes = Response.where(audit_submission_id: @audit_submission.id).where(status: "YES").all
    @response_na = Response.where(audit_submission_id: @audit_submission.id).where(status: "NA").all
    @response_total = Response.where(audit_submission_id: @audit_submission.id).all.count
    @final_result = (@response_na.count + @response_yes.count).to_d / @response_total.to_d
    @final_result = @final_result * 100

    if @response_no.count + @response_yes.count + @response_na.count == @response_total
    @audit_submission.update_attributes(
      completed: true,  
      status_yes: @response_yes.count,
      status_no: @response_no.count,
      status_na: @response_na.count,
      final_result: @final_result
      )
    else
      @audit_submission.update_attributes(
        completed: false,  
        status_yes: @response_yes.count,
        status_no: @response_no.count,
        status_na: @response_na.count,
        final_result: @final_result
        )
    end


    redirect_to audits_path
  end

  def submitted_audits
    @audit = Audit.find(params[:audit_id])
    @submitted_audits = AuditSubmission.where(audit_id: params[:audit_id]).all
  end

  def report_card
    require "prawn"
    @audit_submission = AuditSubmission.find(params[:audit_submission])
    respond_to do |format|
      format.pdf do
        pdf = ReportCardPdf.new(@audit_submission, view_context)
        send_data pdf.render, filename: "Audit_#{@audit_submission.updated_at.strftime('%d_%m_%Y_%I%M%p')}",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def my_audit_log
    @audits = AuditSubmission.where(user_id: current_user.id).all
  end

  def edit_audit_list
    @audit = Audit.find(params[:audit_id])
    @audit_submission = AuditSubmission.find(params[:audit_submission_id])
    @responses = Response.where(audit_submission_id: params[:audit_submission_id]).all
  end

  # GET /audits
  # GET /audits.json
  def index
    @audits = Audit.all
  end

  # GET /audits/1
  # GET /audits/1.json
  def show
  end

  # GET /audits/new
  def new
    @audit = Audit.new
  end

  # GET /audits/1/edit
  def edit
  end

  # POST /audits
  # POST /audits.json
  def create
    @audit = Audit.new(audit_params)

    respond_to do |format|
      if @audit.save
        format.html { redirect_to new_audit_question_path(@audit), notice: 'Audit was successfully created.' }
        format.json { render :show, status: :created, location: @audit }
      else
        format.html { render :new }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audits/1
  # PATCH/PUT /audits/1.json
  def update
    respond_to do |format|
      if @audit.update(audit_params)
        format.html { redirect_to @audit, notice: 'Audit was successfully updated.' }
        format.json { render :show, status: :ok, location: @audit }
      else
        format.html { render :edit }
        format.json { render json: @audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audits/1
  # DELETE /audits/1.json
  def destroy
    @audit.destroy
    respond_to do |format|
      format.html { redirect_to audits_url, notice: 'Audit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit
      @audit = Audit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
      params.require(:audit).permit(:title, :description, :department, :user_id)
    end
end
