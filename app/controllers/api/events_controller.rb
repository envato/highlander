class Api::EventsController < ApiController

  def create
    if new_event_for_user(metric)
      code = :ok
    else
      code = :not_found
    end

    respond_to do |format|
      format.json { head code }
    end
  end

  private

  def valid_metrics
    interested_in_metrics - not_interested_in_metrics
  end

  def interested_in_metrics
    Metric::NAMES
  end

  def not_interested_in_metrics
    %w{ github_push twitter_mention }
  end

  def metric_name
    params['metric']
  end

  def metric
    Metric.where(name: metric_name).first
  end
end
