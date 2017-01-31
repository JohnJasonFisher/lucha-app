class BudgetsController < ApplicationController
  before_action :authenticate_client!
  respond_to :html, :json

  def index
  end

  def show
    gon.id = params[:id]
  end

  def update
    budget = current_client.budget
    
    if budget.update(budget_params)
      budget.update(
        gross_monthly_income: budget.gross_monthly_income, 
        total_monthly_debt: budget.total_monthly_debt,
        debt_divided_by_income: budget.debt_income_ratio)
      render json: { success: "Your budget has been updated." }.to_json
    else
      render json: { danger: "Error saving data.", budget: budget.errors.full_messages }.to_json
    end
  end

  def budget_params
    params.permit(:gross_wages, :self_employment_income, :overtime, :unemployment, :tips_commissions_bonus, :nontaxable_social_security, :taxable_social_security, :rental_income, :other_income, :principal_and_interest, :prop_tax, :assoc_fees, :junior_mortgage, :min_credit_card_payment, :student_loan, :gas, :electricity, :water, :phone, :other_utilities, :food, :gas_car_maintenance, :child_care, :medical_expenses, :rent, :rental_insurance, :principal_and_interest, :prop_tax, :assoc_fees, :junior_mortgage, :min_credit_card_payment, :student_loan, :gas, :electricity, :water, :phone, :other_utilities, :food, :gas_car_maintenance, :child_care, :medical_expenses, :rent, :rental_insurance)
  end

end
