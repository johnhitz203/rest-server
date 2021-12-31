defmodule RestServerWeb.UserControllerTest do
  use RestServerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/users")
    assert %{"data" => users} = Jason.decode!(conn.resp_body)

    # assert length(conn.resp_body) === 3
    assert length(users) === 3
  end

  test "DELETE /users/:id", %{conn: conn} do
    conn = delete(conn, "/users/1")
    assert %{"data" => users} = Jason.decode!(conn.resp_body)

    # assert length(conn.resp_body) == 2
    assert length(users) === 2

    # or
    # check that Enum.find(conn.resp_body) === nil w/ refute
    # refute checks that value is either nil or false
    # refute Enum.find(conn.resp_body, &(&1 === 1))
    refute Enum.find(users, &(&1["id"] === 1))
  end

  # test "GET /users/:id", %{conn: conn} do
  #   conn = get(conn, "/users/1")
  #   # assert %{"data" => users} = Jason.decode!(conn.resp_body)
  #
  #   assert length(conn.resp_body) === 1
  # end
end
