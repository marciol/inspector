defmodule Inspector do
  @moduledoc """
  This is a simple module that allows a more friendly debugging experience
  """

  @doc """
  Prints the currenty file, location, and bindings

  This macros allows an easy inspectable access to the
  content where it is called.

  Just place in your code:

      require Inspector; Inspector.i
  """
  defmacro i() do
    quote do
      Inspector.inspect(binding(), __ENV__)
    end
  end

  @doc false
  def inspect(binding, %Macro.Env{} = env) do
    %{file: file, line: line, module: module, function: function_arity} = env

    file = "#{Path.relative_to_cwd(file)}:#{line}"

    location =
      case function_arity do
        {function, arity} ->
          Exception.format_mfa(module, function, arity)

        _ ->
          nil
      end

    IO.inspect(
      %{
        file: file,
        location: location,
        binding: binding
      },
      label: :inspect
    )
  end
end
