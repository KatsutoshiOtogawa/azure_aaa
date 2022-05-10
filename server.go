package main

import (
	"os"
	"log"
	"net"
	"net/http/fcgi"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "Helloworld",
		})
	})
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})


	// cgiかつwebサーバーがある時。
	if os.Getenv("CGI") != "" {

		// listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
		sockPath := os.Getenv("APP_SOCK_PATH")
		
		if sockPath == "" {
			log.Fatal("Does not set APP_SOCK_PATH")
		}
		l, err := net.Listen("unix", sockPath)
		if err != nil {
			log.Fatal("create faile tcp port")
		}
		err = fcgi.Serve(l, r)
		if err != nil {
			log.Fatal("create faile fcgi server")
		}
	} else {

		r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
	}
}
