defmodule TicketCounterWeb.RunnerLiveTest do
  use TicketCounterWeb.ConnCase

  import Phoenix.LiveViewTest
  import TicketCounter.PixelsFixtures

  @create_attrs %{color: "some color", name: "some name"}
  @update_attrs %{color: "some updated color", name: "some updated name"}
  @invalid_attrs %{color: nil, name: nil}

  defp create_runner(_) do
    runner = runner_fixture()
    %{runner: runner}
  end

  describe "Index" do
    setup [:create_runner]

    test "lists all runner", %{conn: conn, runner: runner} do
      {:ok, _index_live, html} = live(conn, Routes.runner_index_path(conn, :index))

      assert html =~ "Listing Runner"
      assert html =~ runner.color
    end

    test "saves new runner", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.runner_index_path(conn, :index))

      assert index_live |> element("a", "New Runner") |> render_click() =~
               "New Runner"

      assert_patch(index_live, Routes.runner_index_path(conn, :new))

      assert index_live
             |> form("#runner-form", runner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#runner-form", runner: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.runner_index_path(conn, :index))

      assert html =~ "Runner created successfully"
      assert html =~ "some color"
    end

    test "updates runner in listing", %{conn: conn, runner: runner} do
      {:ok, index_live, _html} = live(conn, Routes.runner_index_path(conn, :index))

      assert index_live |> element("#runner-#{runner.id} a", "Edit") |> render_click() =~
               "Edit Runner"

      assert_patch(index_live, Routes.runner_index_path(conn, :edit, runner))

      assert index_live
             |> form("#runner-form", runner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#runner-form", runner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.runner_index_path(conn, :index))

      assert html =~ "Runner updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes runner in listing", %{conn: conn, runner: runner} do
      {:ok, index_live, _html} = live(conn, Routes.runner_index_path(conn, :index))

      assert index_live |> element("#runner-#{runner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#runner-#{runner.id}")
    end
  end

  describe "Show" do
    setup [:create_runner]

    test "displays runner", %{conn: conn, runner: runner} do
      {:ok, _show_live, html} = live(conn, Routes.runner_show_path(conn, :show, runner))

      assert html =~ "Show Runner"
      assert html =~ runner.color
    end

    test "updates runner within modal", %{conn: conn, runner: runner} do
      {:ok, show_live, _html} = live(conn, Routes.runner_show_path(conn, :show, runner))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Runner"

      assert_patch(show_live, Routes.runner_show_path(conn, :edit, runner))

      assert show_live
             |> form("#runner-form", runner: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#runner-form", runner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.runner_show_path(conn, :show, runner))

      assert html =~ "Runner updated successfully"
      assert html =~ "some updated color"
    end
  end
end
