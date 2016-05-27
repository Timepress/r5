module ApplicationHelper

  def t_header name
    header = t("activerecord.attributes.#{name}")
    header[0] = header[0].upcase
    header
  end

  # make long text short with '...'
  def shorten text, length=20
    return '' unless text.present?
    res = text.scan /^(.{1,#{length}})(.*)/
    "#{res[0][0]}#{res[0][1].present? ? '...' : ''}"
  end

  def num_warn condition
    "num #{'warn' if condition}"
  end

  def records_filter
  concat t('records') + ': ' +
    select_tag('filter[per_page]', options_for_select(%w[30 50 100],
         filter.params[:per_page]) ) + "\n"
  end

  def menu_item name, url, test
    %Q{<li#{' class=active' if params[:controller]+params[:action]=~test }><a href="#{url}">#{ name }</a></li>}.html_safe
  end

  def dropdown_menu name, test, &block
    out = %Q[<li #{"class='active'" if params[:controller] =~ /#{test}/} id='fat-menu' class='dropdown'>]
    out += %Q[<a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">]
    out += %Q[<i class="icon-user"></i>#{name}]
    out += %Q[<i class="icon-caret-down"></i></a>]
    out += %Q[<ul class="dropdown-menu">]
    out += capture(&block)
    out += %Q[</ul></li>]
    out.html_safe
  end

  # same as I18n.l() but ignores nil
  def lf date, options={}
    l(date, options) if date
  end

  # selecting - yes, no, nil
  def yes_no_select
    [nil, [t('yes'), 'yes'], [t('no'), 'no'] ]
  end

  # same as I18n.l() but ignores nil
  def lf date, options={}
    options[:format] = options[:format].to_sym if options[:format]
    I18n.l(date, options) if date
  end

  def num number, options={:precision=>2}
    return number unless number.is_a? Numeric
    return '' if options[:skip_zero] && number==0
    number_with_precision( number, options )
  end

  def c_num number, precision=2, skip_zero=false
    return '' if skip_zero && number==0
    return number unless number.is_a? Float
    number_with_precision( number, :precision=>precision, :delimiter => ' ')
#    c_number_with_precision( number, precision )
  end

  def num3 number, skip_zero=false
    c_num number, 3, skip_zero
  end

  def num2 number, skip_zero=false
    c_num number, 2, skip_zero
  end

  def num0 number, skip_zero=false
    return '' if skip_zero && number==0
    return number if number.is_a? Fixnum
    c_num number, 0, skip_zero
  end

  def numx number, precision=3, skip_zero=false
    c_num number, precision, skip_zero
  end

  def delete_button objekt, text
    link_to 'Odstranit', objekt, method: :delete, data: { confirm: text }, class: 'btn btn-danger pull-right' if params[:action] == 'edit'
  end

  def session_debug
    "#{session['debug_params']}<br />#{link_to_function 'debug', "$('#debug_div').toggle()",
        class: 'btn thin'}<hr class='separation'/><div class='box white spaced' id='debug_div'
        style='display:none'>params:#{params.inspect}<br /><br />session#{session.inspect
        }<br /><br />referrer:#{request.referrer}".html_safe if DEVEL && session['debug_params']
    session['debug_params']=''
  end
end
