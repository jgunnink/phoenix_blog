defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User

  @valid_attrs %{
    email: "some content",
    password_digest: "some content",
    username: "some content",
    password: "abc123abc",
    password_confirmation: "abc123abc"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest value gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value is not changed if the password fields nil" do
    changeset = User.changeset(
      %User{},
      %{
        email: "jk@example.com",
        username: "jk",
        password: nil,
        password_confirmation: nil
        }
      )
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
