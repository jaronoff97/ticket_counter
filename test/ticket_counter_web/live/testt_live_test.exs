defmodule TicketCounterWeb.TesttLiveTest do
  use TicketCounterWeb.ConnCase

  import Phoenix.LiveViewTest
  import TicketCounter.TicketsFixtures

  @create_attrs %{name: "some name", number: 42}
  @update_attrs %{name: "some updated name", number: 43}
  @invalid_attrs %{name: nil, number: nil}

  defp create_testt(_) do
    testt = testt_fixture()
    %{testt: testt}
  end

  describe "Index" do
    setup [:create_testt]

    test "lists all test", %{conn: conn, testt: testt} do
      {:ok, _index_live, html} = live(conn, Routes.testt_index_path(conn, :index))

      assert html =~ "Listing Test"
      assert html =~ testt.name
    end

    test "saves new testt", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.testt_index_path(conn, :index))

      assert index_live |> element("a", "New Testt") |> render_click() =~
               "New Testt"

      assert_patch(index_live, Routes.testt_index_path(conn, :new))

      assert index_live
             |> form("#testt-form", testt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#testt-form", testt: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.testt_index_path(conn, :index))

      assert html =~ "Testt created successfully"
      assert html =~ "some name"
    end

    test "updates testt in listing", %{conn: conn, testt: testt} do
      {:ok, index_live, _html} = live(conn, Routes.testt_index_path(conn, :index))

      assert index_live |> element("#testt-#{testt.id} a", "Edit") |> render_click() =~
               "Edit Testt"

      assert_patch(index_live, Routes.testt_index_path(conn, :edit, testt))

      assert index_live
             |> form("#testt-form", testt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#testt-form", testt: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.testt_index_path(conn, :index))

      assert html =~ "Testt updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes testt in listing", %{conn: conn, testt: testt} do
      {:ok, index_live, _html} = live(conn, Routes.testt_index_path(conn, :index))

      assert index_live |> element("#testt-#{testt.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#testt-#{testt.id}")
    end
  end

  describe "Show" do
    setup [:create_testt]

    test "displays testt", %{conn: conn, testt: testt} do
      {:ok, _show_live, html} = live(conn, Routes.testt_show_path(conn, :show, testt))

      assert html =~ "Show Testt"
      assert html =~ testt.name
    end

    test "updates testt within modal", %{conn: conn, testt: testt} do
      {:ok, show_live, _html} = live(conn, Routes.testt_show_path(conn, :show, testt))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Testt"

      assert_patch(show_live, Routes.testt_show_path(conn, :edit, testt))

      assert show_live
             |> form("#testt-form", testt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#testt-form", testt: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.testt_show_path(conn, :show, testt))

      assert html =~ "Testt updated successfully"
      assert html =~ "some updated name"
    end
  end
end
