defmodule Producer do
    @client_id "mqtt_producer"
    @topic     "my_topic"
    use GenServer
    
    # behaviour functions
    
    def start_link(args) do
        GenServer.start(__MODULE__, args)
    end
    
    # callback functions
    
    @impl true
    def init(_) do
        ref = initiate_countdown(1_000)
        
        {:ok, _pid} = Tortoise.Connection.start_link(
            client_id: @client_id,
            server: {Tortoise.Transport.Tcp, host: "localhost", port: 1883},
            handler: {Tortoise.Handler.Logger, []}
        )
        {:ok, %{ref: ref, counter: 0}}
    end
    
    @impl true
    def handle_info(:timeout, state) do
        counter = Map.get(state, :counter)
        Tortoise.publish(@client_id, @topic, "{\"counter\": #{counter}}")
        IO.puts("#{DateTime.utc_now()}> #{counter}")
        ref = initiate_countdown(1_000)
        {:noreply, %{ref: ref, counter: counter+1}}
    end
    
    # helper functions
    
    defp initiate_countdown(timeout) do
        Process.send_after(self(), :timeout, timeout)
    end
end
