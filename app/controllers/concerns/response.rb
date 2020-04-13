module Response
  extend ActiveSupport::Concern

  def json_response(object, status = :ok, opts = {})
    meta_opts = {meta: {message: 'Success', code: 0}}.merge(opts)
    response = {json: object, root: "data",adapter: :json}.merge(meta_opts)
    render response
  end

end