defmodule Newsletter do
  @type file :: pid()
  @type path :: String.t()
  @type email :: String.t()
  @type send_email :: (email() -> :ok | :error)

  @spec read_emails(path()) :: [email()]
  def read_emails(path), do: File.read!(path) |> String.split()

  @spec open_log(path()) :: pid()
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(file(), email()) :: :ok
  def log_sent_email(pid, email), do: IO.puts(pid, email)

  @spec close_log(file()) :: :ok | {:error, any()}
  def close_log(pid), do: File.close(pid)

  @spec send_newsletter(path(), path(), send_email()) :: :ok
  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_file = open_log(log_path)

    Enum.map(emails, fn email ->
      if send_fun.(email) == :ok do
        log_sent_email(log_file, email)
      end
    end)

    close_log(log_file)
  end
end
