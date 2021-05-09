defmodule LiveViewTodosWeb.TodoLive do
    use LiveViewTodosWeb, :live_view # macro for importing boilerplate stuff
    
    def mount(params, session, socket) do
        {:ok, socket}
    end
    
    def render(assigns) do
        ~L"Rendering LiveView"
    end
end
