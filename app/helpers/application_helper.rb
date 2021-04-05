# frozen_string_literal: true

module ApplicationHelper
  def date_format(date, format = 'default')
    return nil if date.blank?

    syntax = '%d %b %Y'
    syntax = '%d %b %Y %H:%M' if %w[long with_time].include?(format)
    syntax = "%d %b '%y" if %w[short simple].include?(format)
    syntax = '%Y-%m-%d' if %w[iso].include?(format)
    syntax = '%a, %d %b %y' if %w[short_with_day].include?(format)
    syntax = '%d/%m/%Y' if %w[datepicker].include?(format)

    date.try(:strftime, syntax)
  end

  def number(number, **args)
    options = {
      delimiter: '.', separator: ',', precision: 0
    }.merge(args)

    number_with_precision(number, options)
  end

  def number_decimal(number)
    number(number, delimiter: '.', separator: ',', precision: 2)
  end

  def clear_filename(filename)
    filename = filename.rpartition('.').first
    filename = filename.gsub('-', ' ')
    filename = filename.gsub('_', ' ')
    # filename = filename.humanize

    # filename.split.map(&:capitalize).join(' ')

    filename
  end

  def error_on(record, field)
    html = ''
    if record && record.errors.include?(field)
      record.errors[field].uniq.each do |error|
        html += %( <span class="help-error text-danger">#{field.to_s.humanize} #{error}<span> )
      end
    end

    html.html_safe
  end

  def event_status(status)
    case status
    when 'active'
      'badge-success'
    when 'passed'
      'badge-danger'
    when 'upcoming'
      'badge-info'
    end
  end

  def mailer_status(status)
    case status
    when 'submitted'
      'badge-info'
    when 'sent'
      'badge-success'
    when 'sending'
      'badge-warning'
    when 'failed'
      'badge-danger'
    when 'invalid'
      'badge-danger'
    end
  end

  def abstract_status(status)
    case status
    when 'submitted'
      'badge-primary'
    when 'rejected'
      'badge-danger'
    when 'in_review'
      'badge-info'
    when 'need_review'
      'badge-warning'
    when 'accepted'
      'badge-success'
    end
  end

  def participant_file(type)
    case type
    when 'AbstractFile'
      'badge-primary'
    when 'PaperFile'
      'badge-danger'
    end
  end
end
