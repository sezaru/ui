defmodule Ui.Resources do
  @moduledoc false

  alias Ui.Resources

  use Ash.Domain

  authorization do
    authorize :by_default
  end

  resources do
    resource Resources.Resource1
  end
end
