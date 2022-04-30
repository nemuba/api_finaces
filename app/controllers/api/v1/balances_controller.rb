# frozen_string_literal: true

# module Api
module Api
  # module V1
  module V1
    class BalancesController < ApiController
      before_action :authenticate_and_set_user
      before_action :set_balance, only: %I[show update destroy]

      def index
        render_json(current_user.balance, status: :ok)
      end

      def show
        render_json(@balance, status: :ok)
      end

      def create
        balance = current_user.build_balance(balance_params)

        if balance.save
          render_json balance, status: :created
        else
          render_json({ status: 'error', error: balance.errors.full_messages.to_sentence }, status: :unprocessable_entity)
        end
      end

      def update
        if @balance.update(balance_params)
          render_json @balance
        else
          render_json({ status: 'error', error: @balance.errors.full_messages.to_sentence }, status: :unprocessable_entity)
        end
      end

      def destroy
        @balance.destroy

        render_json({ status: 'success', message: 'Saldo excluído !' }, status: :ok)
      end

      private

      def balance_params
        params.permit(:balance_value)
      end

      def set_balance
        @balance = Balance.find(params[:id])
      end
    end
  end
end
