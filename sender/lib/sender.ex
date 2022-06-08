defmodule Sender do
  def send_email("konnichiwa@world.com"),
    do: :error

  def send_email(email) do
    Process.sleep(3000)
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end

  def notify_all(emails) do
    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1,
      ordered: false,
      on_timeout: :kill_task
    )
    |> Enum.to_list()
  end
end