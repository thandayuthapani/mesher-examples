package main

import (
	"fmt"
	"net/http"
	"github.com/gorilla/mux"
	"os"
	"log"
	"io/ioutil"
)

var myClient *http.Client

func init() {
	defaultRoundTripper := http.DefaultTransport
	defaultTransportPointer, ok := defaultRoundTripper.(*http.Transport)
	if !ok {
		panic(fmt.Sprintf("defaultRoundTripper not an *http.Transport"))
	}
	defaultTransport := *defaultTransportPointer // dereference it to get a copy of the struct that the pointer points to
	defaultTransport.MaxIdleConns = 100
	defaultTransport.MaxIdleConnsPerHost = 100

	myClient = &http.Client{Transport: &defaultTransport}

}
func main() {
	r:= mux.NewRouter()
	r.HandleFunc("/saymessage/{id}",sayMessage)
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		resp, err := myClient.Get(os.Getenv("TARGET"))
		log.Println(os.Getenv("TARGET"))
		body,err:= ioutil.ReadAll(resp.Body)
		if err != nil {
			w.WriteHeader(500)
			w.Write([]byte(err.Error()))
			return
		}
		if resp == nil {
			w.WriteHeader(500)
			return
		}

		b := make([]byte, 0)
		_, _ = resp.Body.Read(b)
		resp.Body.Close()
		w.Write(body)

	})
	http.Handle("/",r)
	http.ListenAndServe(":9000", nil)
}
func sayMessage(w http.ResponseWriter, r *http.Request){
	vars:= mux.Vars(r)
	id := vars["id"]
	resp, err:= myClient.Get("cse://service-mesher/saymessage"+id)
	if err!= nil{
		w.Write([]byte(err.Error()))
	}
	body, err:= ioutil.ReadAll(resp.Body)
	if err!= nil{
		w.Write([]byte(err.Error()))
	}
	fmt.Println(string(body))
	w.Write(body)
	//w.Write([]byte("Hello World"+id))
}