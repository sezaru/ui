defmodule Ui.Resources.Resource1 do
  @moduledoc false

  use Ash.Resource,
    domain: Ui.Resources,
    data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id

    attribute :name, :string, allow_nil?: false
    attribute :type, :string, allow_nil?: false
  end

  ets do
    private? true
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true

      accept [:name, :type]
    end

    update :update do
      primary? true

      accept [:name, :type]
    end
  end
end
