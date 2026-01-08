package main

import (
    "fmt"
    "net/http"
    "os"
)

func main() {
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }

    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        w.WriteHeader(http.StatusOK)
        fmt.Fprintf(w, `{"status":"UP"}`)
    })

    fmt.Println("Server starting on port " + port + "...")
    if err := http.ListenAndServe(":"+port, nil); err != nil {
        fmt.Printf("Server failed: %s\n", err)
    }
}
