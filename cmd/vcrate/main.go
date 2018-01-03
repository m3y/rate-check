package vcrate

import (
	"fmt"
	"github.com/m3y/vcrate/vcrate"
	"log"
)

func main() {
	body, err := vcrate()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(body)
}
