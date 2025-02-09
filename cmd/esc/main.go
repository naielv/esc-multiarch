package main

import "github.com/naielv/esc-multiarch"

func main() {
	esc.Start()

	end := make(chan bool, 1)
	<-end
}
