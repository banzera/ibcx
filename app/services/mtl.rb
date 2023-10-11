  class MTL < Mechanize

  MTL_BASE_URL    = "https://www.mutualtrust.com/"
  MTL_HOME_URL    = MTL_BASE_URL + "Default.aspx"
  MTL_POLICY_URL  = MTL_BASE_URL + "Policy/PolicyInformation.aspx"
  MTL_SUMMARY_URL = MTL_BASE_URL + "Policy/PolicySummary.aspx"

  def self.logger
    @logger ||= begin
      log_level = (ENV["LOG_LEVEL"] || "DEBUG").to_s.upcase
      Logger.new(STDOUT, formatter: LoggerFormatter, level: log_level, progname: name)
    end
  end

  class << self
    def instance_for(account)
      @@mtl ||= MTL.new(account)
    end
  end

  attr_reader :account

  def initialize(account)
    super
    @agent.user_agent = AGENT_ALIASES['Mac Safari']
    log = Rails.logger

    @account = account

    login
    goto_account_summary
    policy_links
  end

  def login
    puts "Logging in to #{MTL_HOME_URL}"

    page = get(MTL_HOME_URL)

    ppi

    form = page.form

    form.send :"ctl00$ConsumerMenu1$UserTextBox=", account.username
    form.send :"ctl00$ConsumerMenu1$PasswordTextBox=", account.password

    submit(form, form.buttons[1])
  end

  def ppi            = puts("#{page.title.strip} => #{page.uri} (#{page.code})")
  def hiddens        = page.form.hiddens.map(&:name)
  def fields         = page.form.fields.map(&:name)
  def policy_numbers = policy_links.keys

  def inspect = "MTL [#{@current_policy}]"

  def [](policy_number)
    link = policy_links[policy_number.to_s]

    return nil unless link

    goto_account_summary
    goto_policy_page(link)

    @current_policy = policy_number

    self
  end

  def policy_links
    @policy_links ||= begin
      goto_account_summary
      ll = page.links_with(href: /PolicyNumberLinkButton/)

      Hash[ll.collect {|l| [l.text, l]}]
    end
  end

  def print_policy_numbers
    policy_links.each do |l|  puts "Policy # #{l.text}" end
    nil
  end

  def process_all
    policy_numbers.each do |num|
      self[num].process
    end
  end

  def process
    puts "="*80
    puts 'Processing %s' % @current_policy

    pi = parse_policy_info

    ap pi

    p = Policy.find_or_initialize_by(number: @current_policy)
    p.update(
      policy_type:           pi["Policy Type"],
      primary_insureds_name: pi["Primary Insured's Name"],
      dob:                   pi["Date of Birth"],
      issue_age:             pi["Issue Age"],
      payor_name:            pi["Payor Name"],
      status:                pi["Policy Status"],
      issue_date:            pi["Issue Date"],
      base_plan:             pi["Base Plan"],
      policy_class:          pi["Class"],
      mec_status:            pi["Mec Status"],
      dividend_option:       pi["Dividend Option"],
      nfo_option:            pi["NFO Option"],
    )

    p.transaction do
      r = p.retrievals.create

      ci = parse_coverage_info
      ap ci

      ci.each do |k,v|
        r.details.create!(name: k, **v)
      end

      fi =  parse_financial_info
      ap fi

      r.financials.create!(
        cash_value:                      fi["Policy Cash Values"],
        loan_payoff:                     fi["Loan Payoff"],
        net_cash_value:                  fi["Net Cash Value"],
        cost_basis:                      fi["Cost Basis"],
        dividend_earned:                 fi["Dividend Earned"],
        # dividend_earned_at:              fi["Dividend Earned on 12/28/2022"],
        loan_balance:                    fi["Loan Balance"],
        loan_interest_rate:              fi["Loan Interest Rate"],
        annual_premium:                  fi["Annual Premium"],
        paid_to:                         fi["Paid-to Date"],
        stipulated_annual_premium:       fi["Stipulated Annual Premium"],
        total_premiumn_collected:        fi["Total Premium Collection"],
        maximum_annual_premium_limit:    fi["Maximum Annual Premium Limit"],
        minimum_annual_premium_required: fi["Minimum Annual Premium Required"],
      )

    end # transaction

    nil
  end

  def goto_account_summary = get(MTL_SUMMARY_URL)

  def goto_first_policy
    goto_account_summary
    goto_policy_page(policy_links.first)
  end

  def goto_policy_page(link)
    md = /ctl00.*LinkButton/.match link.href

    navigate_to md[0]
  end

  def goto_general_info
    puts "Navigating to General Information on #{page.uri}"
    navigate_to 'ctl00$MainContentPlaceHolder$ALISControl$GeneralButton'
  end

  def goto_coverage_info
    puts "Navigating to Coverage Information on #{page.uri}"
    navigate_to 'ctl00$MainContentPlaceHolder$ALISControl$CoverageButton'
  end

  def goto_financial_info
    puts "Navigating to Financial Information on #{page.uri}"
    navigate_to "ctl00$MainContentPlaceHolder$ALISControl$FinancialButton"
  end

  def parse_financial_info
    goto_financial_info

    puts "Parsing Financial Information on #{page.uri}"

    td = page.search('table.form-view table tr td:not([colspan])')
             .map {|k| k.content
                        .gsub('&nbsp','')
                        .tr(':',"")
                        .tr('*',"")
                        .tr('(', "-")
                        .tr(')', "")
                        .gsub(/on \d{2}\/\d{2}\/\d{4}/, '')
                        .gsub(/as of \d{2}\-\d{2}\-\d{4}/, '')
                        .strip }

    Hash[td.each_slice(2).to_a]
  end

  def parse_coverage_info
    goto_coverage_info

    puts "Parsing Coverage Information on #{page.uri}"

    td = page.search('table.policyGrid tr td')
             .map {|k| k.content.gsub('&nbsp','').strip }

    tbl = {}
    td.each_slice(4) do |slice|
      tbl[slice[0]] = {
        face_amount: slice[1],
        annual_prem: slice[2],
        maturity:    slice[3],
      }
    end

    tbl
  end

  def parse_policy_info
    puts "Parsing Policy Information on #{page.uri}"

    keys = page.search 'table.form-view tr td.policyLeftColumn'
    kk   = keys.map {|k| k.content.gsub('&nbsp','').strip}

    vals = page.search 'table.form-view tr td.policyRightColumn'
    vv   = vals.map {|v| v.content.strip}

    pi = Hash[kk.zip(vv)]
  end

  def parse_beneficiary_info

  end

  def navigate_to(target)
    page.form.set_fields '__EVENTTARGET': { 0 => target }
    submit(page.form)
  end

  def cash_values
    policies.map do |pn, p|
      p.financials["Policy Cash Values:"].scan(/[.0-9]/).join.to_f
    end
  end

  def net_cash_values
    policies.map do |pn, p|
      p.financials["Net Cash Value:"].scan(/[.0-9]/).join.to_f
    end
  end

  def loan_balances
    policies.map do |pn, p|
      p.financials["Loan Balance:"].scan(/[.0-9]/).join.to_f
    end
  end

  def total_loan_balance
    loan_balances.sum
  end

  def total_cash_value
    cash_values.sum
  end

  def total_net_cash_value
    net_cash_values.sum
  end
end


