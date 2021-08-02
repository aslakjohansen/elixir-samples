defmodule Producer do
    use GenServer
    
    # behaviour functions
    
    def start_link(args) do
        GenServer.start(__MODULE__, args)
    end
    
    # callback functions
    
    @impl true
    def init(_) do
        ref = initiate_countdown(1_000)
        {:ok, %{ref: ref}}
    end
    
    @impl true
    def handle_info(:timeout, state) do
        IO.puts("Timeout called #{DateTime.utc_now()}")
        ref = initiate_countdown(1_000)
        new_state = Map.put(state, :ref, ref)
        {:noreply, new_state}
    end
    
    # helper functions
    
    defp initiate_countdown(timeout) do
        Process.send_after(self(), :timeout, timeout)
    end
end
