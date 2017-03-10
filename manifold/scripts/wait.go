package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"os"
	"time"
)

var (
	host     = flag.String("host", "", "dns host to lookup")
	timeout  = flag.Duration("timeout", time.Minute*10, "max duration to wait")
	interval = flag.Duration("interval", time.Second*5, "check interval")
	not      = flag.String("not", "203.0.113.123", "")
)

func main() {
	flag.Parse()

	tch := time.After(*timeout)
	for {
		select {
		case <-tch:
			fmt.Println("timeout")
			os.Exit(1)
		default:
			addrs, err := net.LookupHost(*host)
			if err != nil {
				log.Println(err)
				time.Sleep(*interval)
				continue
			}
			done := true
			for _, addr := range addrs {
				if addr == *not {
					done = false
				}
			}
			if done && len(addrs) > 0 {
				os.Exit(0)
			}
		}
		time.Sleep(*interval)
	}
}
