class RequestsDatatable < Effective::Datatable
  # include Effective::Enhancements

  collection do
    Request.all
  end

  filters do
    # scope :all
  end

  datatable do
    order :id, :asc
    length 50

    col :id, visible: false

    col :policy,       search: false
    col :request_type, search: false
    col :data,         search: false
  end

end
