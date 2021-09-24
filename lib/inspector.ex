defmodule Inspector do
  @moduledoc """
  This is a simple module that allows a more friendly debugging experience
  """

 @doc """
  Prints the currenty file, location, stacktrace and bindings

  This macros allows an easy inspectable access to the
  content where it is called.

  Just place in your code:

      require Inspector; Inspector.i
  """
  def i do
    i(binding())
  end

  defp i(binding) do
    {:current_stacktrace, stacktrace} = Process.info(self(), :current_stacktrace)
    [caller | stacktrace] = Enum.slice(stacktrace, 2..-1)
    {module, function, arity, opts} = caller
    location = Exception.format_mfa(module, function, arity)
    file = "#{Path.relative_to_cwd(opts[:file])}:#{opts[:line]}"

    IO.inspect(
      %{
        file: file,
        location: location,
        binding: binding,
        stacktrace: stacktrace
      },
      label: :inspect
    )
  end
end
