defmodule InspectorTest do
  use ExUnit.Case
  doctest Inspector

  import ExUnit.CaptureIO

  test "inspect the content of the calling site" do
    defmodule ExampleModule do
      def do_something(arg) do
        a_random_variable = arg
        another_random_thing = a_random_variable
        require Inspector
        Inspector.i()
      end
    end

    assert capture_io(fn ->
             ExampleModule.do_something(%{
               foo: "eu gosto de",
               bar: "bolo de fubá"
             })
           end) ==
             capture_io(fn ->
               IO.inspect(
                 %{
                   binding: [
                     a_random_variable: %{bar: "bolo de fubá", foo: "eu gosto de"},
                     another_random_thing: %{bar: "bolo de fubá", foo: "eu gosto de"},
                     arg: %{bar: "bolo de fubá", foo: "eu gosto de"}
                   ],
                   file: "test/inspector_test.exs:13",
                   location: "InspectorTest.ExampleModule.do_something/1"
                 },
                 label: :inspect
               )
             end)
  end
end
