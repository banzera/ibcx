class FinancesDatatable < Effective::Datatable
  # include Effective::Enhancements

  collection do
    PolicyFinancial.latest
  end

  filters do
    # scope :all
  end

  datatable do
    order :id, :asc
    length 50

    col :id, visible: false

    col :number,          search: false do |p| p.policy.number end
    col :insured,         search: false do |p| p.policy.primary_insureds_name end
    col :cash_value,      search: false do |p| p.cash_value.format end
    col :loan_balance,    search: false do |p| p.loan_balance.format end
    col :net_cash_value,  search: false do |p| p.net_cash_value.format end

    aggregate :total do |values, column|
      if column[:name].in? [:number, :insured]
        '' #fa_icon 'arrow-left', text: 'Total Outstanding Items'
      else
        values.collect(&column[:name]).sum.format
      end
    end

  end

end
