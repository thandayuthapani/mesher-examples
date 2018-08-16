package main

import (
	"net/http"
	"github.com/gorilla/mux"
)

func main() {
	r:= mux.NewRouter()
	r.HandleFunc("/saymessage/{id}",sayMessage)
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("hello"))

	})
	http.Handle("/",r)
	http.ListenAndServe(":9999", nil)
}
func sayMessage(w http.ResponseWriter, r *http.Request){
	vars:= mux.Vars(r)
	id := vars["id"]
	w.Write([]byte("Hello from "+id))
}
