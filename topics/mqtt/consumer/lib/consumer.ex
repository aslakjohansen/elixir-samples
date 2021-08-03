defmodule Consumer do
    @client_id "mqtt_consumer"
    use Tortoise.Handler
    
    def start_link(args) do
        GenServer.start(__MODULE__, args)
    end
  
    # callback functions
    
    @impl true
    def init(_) do
        Tortoise.Supervisor.start_child(
            client_id: @client_id,
            server: {Tortoise.Transport.Tcp, host: "localhost", port: 1883},
            handler: {Consumer, []},
            subscriptions: [{"#", 0}],
        )
        {:ok, %{}}
    end
    
    def handle_message(topic, payload, state) do
        counter = payload |> Jason.decode!() |> Map.get("counter")
        time = DateTime.utc_now() |> DateTime.to_unix(:nanosecond)
        IO.puts("#{time} #{topic} #{counter}")
        {:ok, state}
    end
    
    def child_spec(opts) do
        %{
              id: __MODULE__,
              start: {__MODULE__, :start_link, [opts]},
              type: :worker,
              restart: :permanent,
              shutdown: 500
        }
    end
    
#    # these are not necessary
#    def subscription(_status, _topic_filter, state) do
#        {:ok, state}
#    end
#    def terminate(_reason, _state) do
#        :ok
#    end
#    def connection(status, state) do
#        case status do
#            :up -> "Connected"
#            _   -> "Othernected"
#        end
#        |> IO.puts()
#        {:ok, state}
#    end
    
end
