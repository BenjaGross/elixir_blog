defmodule ElixirBlog.Post do
  use ElixirBlog.Web, :model
  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :body, :string
    has_many :comments, ElixirBlog.Comment, on_delete: :delete_all

    timestamps()
  end

  def count_comments(query) do
    from p in query,
      group_by: p.id,
      left_join: c in assoc(p, :comments),
      select: {p, count(c.id)}
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end
