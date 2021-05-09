defmodule LiveViewTodosWeb.TodoLive do
    use LiveViewTodosWeb, :live_view # macro for importing boilerplate stuff
    alias LiveViewTodos.Todos
    
    def mount(params, session, socket) do
        {:ok, assign(socket, todos: Todos.list_todos())}
    end
    
#    def render(assigns) do
#        ~L"Rendering LiveView"
#    end
end
