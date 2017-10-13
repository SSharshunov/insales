class AccountRepository < Hanami::Repository
  def account_by_insale_id(insales_id, limit: 1)
    accounts
      .where(insales_id: insales_id)
      .order(:insales_id)
      .limit(limit)
  end

  # def update_deliveries_ids(insales_id, json)
  #   accounts
  #     .where(insales_id: insales_id)
  #     .order(:insales_id)
  #     .limit(limit)
  #     .first
  #     .update()
  # end
end
