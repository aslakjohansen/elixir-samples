defmodule LiveViewTodosWeb.TodoLive do
    use LiveViewTodosWeb, :live_view # macro for importing boilerplate stuff
    alias LiveViewTodos.Todos
    
    def mount(params, session, socket) do
        Todos.subscribe()
        {:ok, fetch(socket)}
    end
    
    def handle_event("add", %{"todo" => todo}, socket) do
        Todos.create_todo(todo)
        {:noreply, fetch(socket)} # fetch not necessary
    end
    
    def handle_event("toggle_done", %{"id" => id}, socket) do
        todo = Todos.get_todo!(id)
        Todos.update_todo(todo, %{done: !todo.done})
        {:noreply, fetch(socket)}
    end
    
    def handle_info({Todos, [:todo | _], _}, socket) do
        {:noreply, fetch(socket)} # fetch not necessary
    end
    
    defp fetch(socket) do
      assign(socket, todos: Todos.list_todos())
    end
    
#    def render(assigns) do
#        ~L"Rendering LiveView"
#    end
end
