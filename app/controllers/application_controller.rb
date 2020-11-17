class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: Rails.root.join('public/404.html'), status: :not_found, layout: false, content_type: 'text/html'
  end

  def render_500(error)
    ExceptionNotifier.notify_exception(error, env: request.env, data: { message: 'error' })
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
    render file: Rails.root.join('public/500.html'), status: :internal_server_error, layout: false, content_type: 'text/html'
  end

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
