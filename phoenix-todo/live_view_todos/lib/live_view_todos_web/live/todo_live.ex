defmodule LiveViewTodosWeb.TodoLive do
    use LiveViewTodosWeb, :live_view # macro for importing boilerplate stuff
    alias LiveViewTodos.Todos
    
    def mount(params, session, socket) do
        {:ok, fetch(socket)}
    end
    
    def handle_event("add", %{"todo" => todo}, socket) do
        Todos.create_todo(todo)
        {:noreply, fetch(socket)}
    end
    
    defp fetch(socket) do
      assign(socket, todos: Todos.list_todos())
    end
    
#    def render(assigns) do
#        ~L"Rendering LiveView"
#    end
end
