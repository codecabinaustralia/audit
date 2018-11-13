class ReportCardPdf < Prawn::Document
	def initialize(audit_submission, view)
	super(top_margin: 70)
	@audit_submission = audit_submission
	@view = view
	head_labels
	line_items
	end	
	
	def head_labels
	require 'time'
	require 'date'
	font "Helvetica"
	text "#{@audit_submission.audit.title}", size: 20, style: :bold
	text "Submission number: ##{@audit_submission.id}"
	move_down 2
	text "Submitted by: #{@audit_submission.audit.user.first_name} #{@audit_submission.audit.user.last_name}"
	move_down 2
	text "Completed on: #{@audit_submission.updated_at.strftime('%d %m %Y at %I:%M%p')}"
	move_down 10
	text "#{@audit_submission.audit.description}"

	move_down 20
	text "#{@audit_submission.audit.title} score:"
	move_down 10
	text "#{mypercentage(@audit_submission.final_result)}", size: 30, style: :bold

	end	

	def line_items
		move_down 20
		table line_item_rows do
			row(0).font_style = :bold
			self.row_colors = ["ffffff", "e5e5e5"]
		end

	end

	def line_item_rows
		[["Question", "Response", "Completed?"]] + 
		@audit_submission.responses.map do |response|
			if response.status == "NO"
			[response.question.title, response.response_entry, response.status]
			else
			[response.question.title, response.response_entry, response.status]
			end
		end 
	end

	def mypercentage(num)
		@view.number_to_percentage(num, precision: 2)
	end
end